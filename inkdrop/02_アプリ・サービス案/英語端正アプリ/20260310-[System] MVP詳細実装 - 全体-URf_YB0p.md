# [System] MVP詳細実装 - 全体

以下は **Accent Fit MVP を実装可能な粒度まで分解した設計**です。  
あなたは Clean Architecture を普段使っているので、それに合わせて **Mobile / Backend / AI Pipeline** を整理します。

コードは **重要部分のみ**示します（残りは自力実装前提）。

***

# 1. 全体アーキテクチャ（MVP）

```
flowchart LR

Mobile[iOS SwiftUI / Android Kotlin]

subgraph Backend
API[FastAPI]
Eval[Speech Evaluation Service]
PromptService[Prompt Service]
end

subgraph AI
Whisper
end

subgraph DB
Firestore
end

Mobile -->|GET /prompt| API
Mobile -->|POST /evaluate| API
Mobile -->|POST /session| API

API --> PromptService
PromptService --> Firestore

API --> Eval
Eval --> Whisper

API --> Firestore
```
![mermaid-diagram (8)](AEhKSn-r-mermaid-diagram_(8).png)


MVPでは

Firestore

- prompts

- speechSessions

***

# 2. Backend 詳細設計（FastAPI）

## ディレクトリ構造

```
backend/

app/
  main.py
  config.py

  api/
    prompt_api.py
    evaluate_api.py
    session_api.py

  services/
    prompt_service.py
    evaluation_service.py
    whisper_service.py
    scoring_service.py
    session_service.py

  models/
    prompt.py
    evaluation.py
    session.py

  infra/
    firestore_client.py
    audio_utils.py
```

***

# 3. Prompt API

## Endpoint

```
GET /prompt
```

返すデータ

```
{
  promptId: string
  text: string
}
```

***

## Firestore structure

```
prompts
   promptId
       text
       difficulty
       phonemes
```

***

## prompt\_service.py

```
from google.cloud import firestore
import random

class PromptService:

    def __init__(self):
        self.db = firestore.Client()

    def get_random_prompt(self):

        docs = self.db.collection("prompts").stream()
        prompts = [d.to_dict() | {"id": d.id} for d in docs]

        return random.choice(prompts)
```

***

## prompt\_api.py

```
from fastapi import APIRouter
from services.prompt_service import PromptService

router = APIRouter()
service = PromptService()

@router.get("/prompt")
def get_prompt():

    p = service.get_random_prompt()

    return {
        "promptId": p["id"],
        "text": p["text"]
    }
```

***

# 4. Speech Evaluation API

## Endpoint

```
POST /evaluate
```

Input

```
multipart/form-data

audio: wav
promptText: string
```

***

Response

```
{
 transcript: string
 wer: float
 score: int
}
```

***

# 5. Evaluation Pipeline

```
audio
 ↓
whisper
 ↓
transcript
 ↓
WER(prompt, transcript)
 ↓
score
```

***

# 6. Whisper Service

## whisper\_service.py

MVPは **openai-whisper local** が一番簡単

```
pip install openai-whisper
```

***

```
import whisper

class WhisperService:

    def __init__(self):
        self.model = whisper.load_model("base")

    def transcribe(self, audio_path):

        result = self.model.transcribe(audio_path)

        return result["text"]
```

***

# 7. WER Scoring

ライブラリ

```
pip install jiwer
```

***

## scoring\_service.py

```
from jiwer import wer

class ScoringService:

    def calculate(self, prompt, transcript):

        error = wer(prompt.lower(), transcript.lower())

        score = int((1 - error) * 100)

        if score < 0:
            score = 0

        return error, score
```

***

# 8. Evaluation Service

```
from services.whisper_service import WhisperService
from services.scoring_service import ScoringService

class EvaluationService:

    def __init__(self):

        self.whisper = WhisperService()
        self.scoring = ScoringService()

    def evaluate(self, audio_path, prompt):

        transcript = self.whisper.transcribe(audio_path)

        wer, score = self.scoring.calculate(prompt, transcript)

        return transcript, wer, score
```

***

# 9. Evaluate API

```
from fastapi import APIRouter, UploadFile, File, Form
import tempfile

from services.evaluation_service import EvaluationService

router = APIRouter()

service = EvaluationService()

@router.post("/evaluate")
async def evaluate(
    audio: UploadFile = File(...),
    promptText: str = Form(...)
):

    with tempfile.NamedTemporaryFile(delete=False) as tmp:
        tmp.write(await audio.read())
        path = tmp.name

    transcript, wer, score = service.evaluate(path, promptText)

    return {
        "transcript": transcript,
        "wer": wer,
        "score": score
    }
```

***

# 10. Session Storage API

MVPでは

Mobile

- ローカル保存

Backend

- optional

***

## POST /session

```
{
 promptId
 score
 duration
}
```

***

## session\_service.py

```
class SessionService:

    def __init__(self):
        self.db = firestore.Client()

    def save(self, session):

        self.db.collection("speechSessions").add(session)
```

***

# 11. Mobile Architecture（Clean）

あなた向けに **最小 Clean Architecture**

***

## Modules

```
app

presentation
application
domain
infra
```

***

# Domain Layer

Entities

```
Prompt
SpeechResult
SpeechSession
```

***

## Prompt

```
struct Prompt: Identifiable {

    let id: String
    let text: String
}
```

***

## SpeechResult

```
struct SpeechResult {

    let transcript: String
    let score: Int
}
```

***

# Repository

```
PromptRepository
SpeechEvaluationRepository
SessionRepository
```

***

# Application Layer

UseCases

```
FetchPromptUseCase
EvaluateSpeechUseCase
SaveSessionUseCase
GetDailyCountUseCase
```

***

## FetchPromptUseCase

```
protocol FetchPromptUseCase {

    func execute() async throws -> Prompt
}
```

***

# Infra Layer

API Client

```
PromptAPI
EvaluationAPI
SessionAPI
```

***

## PromptAPI

```
func getPrompt() async throws -> Prompt {

    let url = baseURL.appending(path: "/prompt")

    let (data, _) = try await URLSession.shared.data(from: url)

    return try JSONDecoder().decode(Prompt.self, from: data)
}
```

***

# Evaluate API

multipart upload

```
func evaluate(audio: Data, prompt: String) async throws -> SpeechResult
```

***

Example

```
var request = URLRequest(url: url)
request.httpMethod = "POST"
```

***

# Audio Recording (iOS)

MVP

```
AVAudioRecorder
```

***

settings

```
wav
16kHz
mono
```

***

```
[
 AVFormatIDKey: kAudioFormatLinearPCM,
 AVSampleRateKey: 16000,
 AVNumberOfChannelsKey: 1
]
```

***

# Practice Screen State Machine

```
Idle
Recording
Processing
Result
```

***

SwiftUI ViewModel

```
enum PracticeState {

    case idle
    case recording
    case processing
    case result(score: Int)
}
```

***

# Daily Counter

MVPは

```
UserDefaults
```

保存

```
date
count
```

***

# Implementation Order（実際の開発順）

あなたが一番速く作れる順序

***

### Step1

Prompt API

***

### Step2

Practice UI

***

### Step3

Audio Recording

***

### Step4

Evaluate API

***

### Step5

Whisper integration

***

### Step6

Result UI

***

### Step7

Session local save

***

# MVP 開発時間（現実）

経験者なら

```
Backend

Prompt API      30min
Evaluate API    2h
Whisper         1h

Mobile

UI              2h
Audio           1h
API             1h
```

合計

**1〜2日**

***

# 次に決めるべき重要ポイント（実装前）

MVP成功率に影響します

1️⃣ **prompt selection strategy**

```
完全ランダム
or
difficulty random
```

***

2️⃣ **score threshold**

```
80 = good
60 = retry
```

***

3️⃣ **audio length limit**

```
max 10 sec
```

***

もし希望があれば次に

**Accent Fit MVP の**

- 完全 FastAPI project template

- iOS SwiftUI Practice Screen implementation

- Android Compose implementation

- Dataset 1000 sentences generator

まで **実装レベルで出します。**  
（ここからが実際の開発速度を3〜5倍上げる部分です）
