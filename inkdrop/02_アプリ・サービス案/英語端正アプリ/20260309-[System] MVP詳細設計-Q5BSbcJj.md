# [System] MVP詳細設計

# Step 4

# Detailed Design

ここから **実装レベル設計**です。

構成

```
Mobile
Backend
AI pipeline
Firestore
Prompt dataset
```

***

# 1 Mobile Architecture

ユーザーは Swift / Kotlin に強いので  
**Clean Architecture + MVVM** を想定します。

## Layer構造

```
View
ViewModel
UseCase
Repository
API Client
```

***

## PracticeViewModel State

```
struct PracticeState {
    var prompt: Prompt?
    var isRecording: Bool
    var isProcessing: Bool
    var score: Int?
    var todayCount: Int
}
```

***

## Actions

```
onAppear
tapSpeak
recordFinished
retry
```

***

## UseCases

```
GetPromptUseCase
EvaluateSpeechUseCase
SaveSessionUseCase
```

***

# 2 Backend Architecture

FastAPI モジュール構造

```
app/

api/
  prompt.py
  evaluate.py
  session.py

services/
  prompt_service.py
  evaluation_service.py
  session_service.py

ai/
  whisper_engine.py
  scoring_engine.py

models/
  prompt.py
  session.py
```

***

# Prompt API

```
GET /prompt
```

Response

```
{
  "id": "p_001",
  "text": "I really like reading books."
}
```

***

# Evaluate API

```
POST /evaluate
```

Request

```
multipart/form-data

audio
promptId
```

Response

```
{
  "score": 72,
  "transcript": "I rery like reading books"
}
```

***

# Session API

```
POST /session
```

Request

```
{
  "promptId": "p_001",
  "score": 72,
  "duration": 8
}
```

***

# 3 AI Evaluation Pipeline

MVPでは **最もシンプルなスコアリング**

```
flowchart TD

Audio --> Whisper
Whisper --> Transcript
Transcript --> Compare
Compare --> WER
WER --> Score
```

![mermaid-diagram (7)](zSDjcOpW-mermaid-diagram_(7).png)

***

## Score formula

```
WER = word_error_rate(prompt, transcript)

score = (1 - WER) * 100
```

***

# 4 Firestore Schema

## prompts

```
prompts
  p001
    text
    difficulty
```

***

## speechSessions

```
speechSessions
  sessionId
    userId
    promptId
    score
    duration
    createdAt
```

***

## users

```
users
  userId
    createdAt
```

***

# 5 Prompt Dataset

MVP

```
1000 sentences
```

例

```
I really like reading books.
I need to buy a new laptop.
The meeting starts at nine.
Please send me the document.
I will call you tomorrow.
```

***

# Prompt difficulty

```
easy
medium
hard
```

***

# Backend Prompt Selection

MVP

```
random()
```

将来

```
weak phoneme
```

ベース

***

# MVP 技術スタック

Mobile

```
SwiftUI
Kotlin
```

Backend

```
FastAPI
Cloud Run
```

AI

```
Whisper small
```

Database

```
Firestore
```

***

# MVP開発タスク

実装順序

```
1 Prompt dataset
2 Backend prompt API
3 Mobile UI
4 Audio recording
5 Evaluate API
6 Whisper scoring
7 Session storage
8 Practice counter
```

***

# 次のステップ（重要）

ここまでで **MVP設計は約60%完成**です。

次にやると良いのは

### ① Prompt Dataset 設計

1000文の構造

### ② Speech scoring algorithm 改良

WERだけでは弱い

### ③ Pronunciation Map 設計

Accent Fitの核心

***

もしよければ次は  
**かなり重要な設計**をやります。

> **Prompt Dataset 設計**

これは

```
Accent FitのAI性能
```

を決めます。

実は  
**1000文はランダムではダメです。**

**phoneme coverage dataset** にする必要があります。

必要なら次に

**「発音トレーニング用 Prompt Dataset 設計」**

を作ります。  
これはこのアプリの **AI品質を決める最重要部分**です。

情報源
