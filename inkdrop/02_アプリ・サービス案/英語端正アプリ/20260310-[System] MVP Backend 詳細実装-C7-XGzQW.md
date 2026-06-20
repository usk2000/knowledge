# [System] MVP Backend 詳細実装

FastAPI のデプロイ方法はいくつかありますが、\*\*Accent Fit の構成（Whisper + Firestore）\*\*を考えると実用的な選択肢は次の3つです。

結論から言うと **MVPなら Cloud Run が一番簡単**です。  
理由：GPU不要 / Firestoreと相性良い / Dockerだけで動く。 pasted

***

# 1. 一番おすすめ：Google Cloud Run

理由

```
FastAPI ✔
Firestore ✔
Docker ✔
Auto scaling ✔
```

***

# Step1 Dockerfile作成

project root

```
accent-fit-backend/
```

Dockerfile

```
FROM python:3.11

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
```

***

# Step2 requirements.txt 更新

Whisperは ffmpeg 必須

```
fastapi
uvicorn
python-multipart

google-cloud-firestore

openai-whisper
jiwer
```

***

# Step3 ffmpeg追加

Dockerfile修正

```
FROM python:3.11

RUN apt-get update && apt-get install -y ffmpeg

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]
```

***

# Step4 GCP設定

```
gcloud init
```

プロジェクト設定

```
gcloud config set project YOUR_PROJECT_ID
```

***

# Step5 Artifact Registry

```
gcloud artifacts repositories create accent-fit \
  --repository-format=docker \
  --location=asia-northeast1
```

***

# Step6 Docker build

```
docker build -t accent-fit .
```

***

# Step7 push

```
gcloud builds submit --tag asia-northeast1-docker.pkg.dev/YOUR_PROJECT/accent-fit/api
```

***

# Step8 Cloud Run deploy

```
gcloud run deploy accent-fit-api \
 --image asia-northeast1-docker.pkg.dev/YOUR_PROJECT/accent-fit/api \
 --platform managed \
 --region asia-northeast1 \
 --allow-unauthenticated
```

***

# 完成

URL

```
https://accent-fit-api-xxxxx.run.app
```

テスト

```
curl https://accent-fit-api-xxxxx.run.app/prompt
```

***

# Firestore 認証（重要）

Cloud Runなら

**サービスアカウント自動認証**

つまり

```
GOOGLE_APPLICATION_CREDENTIALS
不要
```

今のコード

```
firestore.Client()
```

そのまま動きます。

***

# 2. Whisper の問題（重要）

Cloud Run だと

```
CPU only
```

Whisper推論時間

```
tiny   0.3s
base   1.5s
small  4s
```

MVPおすすめ

```
whisper.load_model("tiny")
```

***

# 3. もう一つの方法（安い）

### Fly.io

FastAPI + Docker

```
fly deploy
```

メリット

```
簡単
低コスト
```

デメリット

```
Firestore IAM設定少し面倒
```

***

# 4. 一番速い MVP デプロイ

もし

**今すぐ公開したいなら**

これが一番速い

```
Render
Railway
```

Docker不要

***

# 5. MVPでの推奨構成

Accent Fit MVP

```
flowchart LR

Mobile --> CloudRunAPI
CloudRunAPI --> Whisper
CloudRunAPI --> Firestore
```
![mermaid-diagram (9)](M2y4qZeK-mermaid-diagram_(9).png)

***

# 次にやるべきこと

Cloud Run デプロイ前に **必ずこれを追加してください**

### 1 Audio size limit

FastAPI

```
if len(audio) > 2MB:
    raise HTTPException
```

***

### 2 Rate limit

```
10 req / min
```

***

# 質問

次の設計をする前に **1つ確認したいです**

Whisper を

### A

**APIサーバーで推論**

### B

**専用AIサーバー**

将来的に

```
Pronunciation Map
phoneme scoring
wav2vec2
```

を作る場合、**Bの方が圧倒的に良い**です。

もし希望があれば次に

**Accent Fit の本番アーキテクチャ（かなり重要）**

```
AI server
Evaluation pipeline
Vector DB
```

を **プロダクトレベルで設計**します。

Cloud Run + FastAPI 前提で説明します。  
あなたのテンプレート構造（`app/main.py`, `app/api/*`, `services/*`）に合わせて **どのファイルに書くか**まで具体的に示します。

***

# 1. Audio Size Limit の実装

制限する場所は **APIレイヤー**です。  
理由：

- Service層はビジネスロジック

- API層は **入力バリデーション**

つまり

```
app/api/evaluate_api.py
```

に書きます。

***

## 推奨制限

MVPなら

```
audio length 10 sec
audio size 2MB
```

16kHz mono wavなら

```
10秒 ≒ 320KB
```

なので 2MB は余裕。

***

## evaluate\_api.py 修正

```
from fastapi import APIRouter, UploadFile, File, Form, HTTPException
import tempfile

from app.services.evaluation_service import EvaluationService

router = APIRouter()
service = EvaluationService()

MAX_AUDIO_SIZE = 2 * 1024 * 1024  # 2MB


@router.post("/evaluate")
async def evaluate(
    audio: UploadFile = File(...),
    promptText: str = Form(...)
):

    content = await audio.read()

    if len(content) > MAX_AUDIO_SIZE:
        raise HTTPException(status_code=413, detail="Audio too large")

    with tempfile.NamedTemporaryFile(delete=False) as tmp:
        tmp.write(content)
        path = tmp.name

    transcript, wer, score = service.evaluate(path, promptText)

    return {
        "transcript": transcript,
        "wer": wer,
        "score": score
    }
```

***

# 2. Audio Duration Limit

これは

```
infra/audio_utils.py
```

に書くのが綺麗です。

***

## audio\_utils.py

```
import wave


def check_duration(path, max_sec=10):

    with wave.open(path) as f:

        frames = f.getnframes()
        rate = f.getframerate()

        duration = frames / rate

        if duration > max_sec:
            raise Exception("Audio too long")

        return duration
```

***

## evaluate\_api.py に追加

```
from app.infra.audio_utils import check_duration
```

```
duration = check_duration(path)
```

***

# 3. Rate Limit の実装

FastAPIは標準で RateLimit が無いので  
一般的に使うライブラリは

```
slowapi
```

***

## install

```
pip install slowapi
```

***

# main.py 修正

```
app/main.py
```

***

```
from fastapi import FastAPI
from slowapi import Limiter
from slowapi.util import get_remote_address
from slowapi.middleware import SlowAPIMiddleware

from app.api.router import router


limiter = Limiter(key_func=get_remote_address)

app = FastAPI()

app.state.limiter = limiter
app.add_middleware(SlowAPIMiddleware)

app.include_router(router)
```

***

# evaluate\_api.py に追加

```
from slowapi import Limiter
from slowapi.util import get_remote_address
from slowapi.errors import RateLimitExceeded
```

***

```
from app.main import limiter
```

***

## endpoint

```
@router.post("/evaluate")
@limiter.limit("10/minute")
async def evaluate(...)
```

***

# 最終構成

```
app/
 ├ main.py              ← Rate limit設定
 ├ api/
 │   └ evaluate_api.py  ← Audio size limit
 ├ infra/
 │   └ audio_utils.py   ← Duration limit
```

***

# 4. Cloud Run の注意点

Cloud Run は

```
request size limit
```

があります。

現在

```
32MB
```

なので問題なし。

***

# 5. Whisper 推論方式

ここは **AIプロダクト設計の重要ポイント**なので  
MVP / Scale を分けて説明します。

***

# A. APIサーバーで推論（今の設計）

```
Mobile
  ↓
FastAPI
  ↓
Whisper
  ↓
score
```

```
```

***

## メリット

```
シンプル
デプロイ1個
開発速い
```

***

## デメリット

```
推論でAPIがブロック
スケール難しい
CPU負荷
```

***

## 推論時間

```
tiny  0.3s
base  1.2s
small 4s
```

MVPは

```
tiny
```

がベスト。

***

# B. AI Server 分離

```
Mobile
  ↓
API Server
  ↓
AI Server
```

***

![mermaid-diagram (10)](zAmp4OQa-mermaid-diagram_(10).png)

***

## メリット

```
AIスケール可能
GPU対応
将来拡張
```

***

## デメリット

```
構成複雑
開発遅い
```

***

# Bが必要になる理由

Accent Fit の将来

```
phoneme scoring
stress detection
rhythm scoring
pronunciation map
```

は

```
Whisper
+
wav2vec2
+
alignment model
```

が必要。

***

# AI server pipeline

```
audio
 ↓
ASR
 ↓
phoneme alignment
 ↓
feature extraction
 ↓
scoring
```

***

# MVPでの最適解

私なら

```
Phase1
API + Whisper

Phase2
AI server split
```

***

# MVP構成（おすすめ）

![mermaid-diagram (9)](U-ETSsvz-mermaid-diagram_(9).png)

***

# 将来構成
![mermaid-diagram (11)](aQl1x5iL-mermaid-diagram_(11).png)


***

# 私からの提案

Accent Fit は **AIプロダクト**なので  
MVPでも **1つだけ先にやると後で楽なこと**があります。

それは

```
evaluation_service を API から分離
```

つまり

```
services/
   evaluation_service.py
```

を

```
ai/
   evaluation_service.py
```

にすること。

***

もし希望があれば次に  
**Accent Fit AI pipeline（実戦レベル設計）**

を作ります。

これは

```
Whisper
wav2vec2
phoneme alignment
Pronunciation Map
```

まで含めた **AIプロダクトの心臓部分**です。

