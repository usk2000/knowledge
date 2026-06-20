# [System]モバイル設計


# A. モバイル側設計（Repository / Domain）

目的

- UIとデータ取得を分離

- API / Firestore / Local DB を差し替え可能にする

Clean Architectureでいう

```
View
Application
Domain
Infrastructure
```

に対応します。

***

# A-1. Domain Entities

まずドメインモデルを確定します。

## Prompt

```
struct Prompt: Identifiable, Codable, Sendable {
    let id: String
    let version: Int
    let text: String
    let type: PromptType
    let difficulty: Int
    let tags: [String]
}
```

***

## FitScore

```
struct FitScore: Codable, Sendable {
    let overall: Int
    let rhythm: Int
    let stress: Int
    let clarity: Int
}
```

***

## FitAdvice

```
struct FitAdvice: Codable, Sendable {
    let target: String
    let message: String
}
```

***

## SpeechSession

```
struct SpeechSession: Identifiable, Codable, Sendable {
    let id: String
    let createdAt: Date
    
    let promptId: String
    let promptVersion: Int
    let promptTextSnapshot: String
    
    let audioPath: String
    
    let score: FitScore
    let advice: FitAdvice
}
```

***

# A-2. Repository Interfaces

Domain側は **interfaceだけ**です。

***

## PromptRepository

```
protocol PromptRepository: Sendable {
    func listPrompts() async throws -> [Prompt]
    func getPrompt(id: String) async throws -> Prompt
}
```

実装

```
FirestorePromptRepository
LocalPromptRepository
```

***

## SpeechEvaluationRepository

API呼び出し

```
protocol SpeechEvaluationRepository: Sendable {
    func evaluateSpeech(
        audioURL: URL,
        promptId: String,
        mode: EvaluationMode
    ) async throws -> SpeechEvaluationResult
}
```

戻り値

```
struct SpeechEvaluationResult: Sendable {
    let promptId: String
    let promptVersion: Int
    let promptText: String
    let score: FitScore
    let advice: FitAdvice
}
```

***

## SpeechSessionRepository

ローカルDB

```
protocol SpeechSessionRepository: Sendable {
    
    func save(session: SpeechSession) async throws
    
    func listSessions() async throws -> [SpeechSession]
    
    func getSession(id: String) async throws -> SpeechSession?
}
```

実装

```
SQLiteSpeechSessionRepository
CoreDataSpeechSessionRepository
```

***

# A-3. UseCase / Application Layer

## EvaluateSpeechUseCase

```
struct EvaluateSpeechUseCase: Sendable {
    
    let evaluationRepository: SpeechEvaluationRepository
    let sessionRepository: SpeechSessionRepository
    
    func execute(
        audioURL: URL,
        prompt: Prompt
    ) async throws -> SpeechSession {
        
        let result = try await evaluationRepository.evaluateSpeech(
            audioURL: audioURL,
            promptId: prompt.id,
            mode: .sentence
        )
        
        let session = SpeechSession(
            id: UUID().uuidString,
            createdAt: Date(),
            promptId: result.promptId,
            promptVersion: result.promptVersion,
            promptTextSnapshot: result.promptText,
            audioPath: audioURL.path,
            score: result.score,
            advice: result.advice
        )
        
        try await sessionRepository.save(session: session)
        
        return session
    }
}
```

***

# A-4. iOS ViewModel

Recording → Evaluate → Result

```
@MainActor
final class RecordViewModel: ObservableObject {

    @Published var state: State = .idle
    
    enum State {
        case idle
        case recording
        case evaluating
        case result(SpeechSession)
        case error(Error)
    }
    
    let evaluateSpeech: EvaluateSpeechUseCase
    
    func evaluate(audioURL: URL, prompt: Prompt) async {
        state = .evaluating
        
        do {
            let session = try await evaluateSpeech.execute(
                audioURL: audioURL,
                prompt: prompt
            )
            
            state = .result(session)
        }
        catch {
            state = .error(error)
        }
    }
}
```

***

