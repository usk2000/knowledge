# [System] MVP System Architecture


**モバイル・API・AI・DB・運用**すべて含めた形で整理します。

この構成は

- **実装できる現実的構成**

- **後から拡張しやすい構成**  
  を前提にしています。

***

# 1. Accent Fit 全体アーキテクチャ

![mermaid-diagram (1)](mosZn1Fm-mermaid-diagram_(1).png)


***

# 2. Mobile（iOS / Android）

モバイルは **UIと軽いロジックのみ**です。

## 機能

### Recording

```
audio capture
```

***

### Prompt Recommendation

```
select next prompt
```

入力

- UserProfile

- SpeechSession

- Prompt metadata

***

### Local Storage

保存

```
SpeechSession
audio
user profile
```

***

# 3. Prompt API

役割

```
Prompt取得
```

エンドポイント

```
GET /v1/prompts
GET /v1/prompts/{id}
```

データ

```
text
difficulty
tags
targets
sampleAudio
```

***

# 4. Speech Evaluation API

役割

```
audio evaluation
```

エンドポイント

```
POST /v1/speech/evaluations
```

入力

```
audioFile
promptId
mode
```

出力

```
FitScore
FitAdvice
quickInsight
```

***

# 5. AI Evaluation Engine

内部構造

```
Speech Analyzer
↓
Score Calculator
↓
Advice Generator
```

***

# 6. Speech Analyzer

役割

```
audio → features
```

処理

```
embedding extraction
speech recognition
prosody features
```

***

# 7. Score Calculator

評価

```
rhythm
stress
clarity
```

総合

```
overall score
```

***

# 8. Advice Generator

ロジック

```
lowest score
↓
template advice
```

例

```
Try stressing the word "report".
```

***

# 9. Data Storage

## Firestore

保存

```
prompts
```

理由

- 運用更新

- 新規追加

***

## Local DB（モバイル）

保存

```
speech_sessions
audio files
user profile
```

理由

- プライバシー

- オフライン

***

# 10. Reference Audio

Promptには

```
sampleAudio
```

があります。

生成方法

```
TTS
```

例

```
Amazon Polly
ElevenLabs
Google TTS
```

***

# 11. Audio Flow

ユーザー操作

```
record
↓
upload audio
↓
evaluate
↓
receive score
↓
show result
```

***

# 12. Latency

MVP目標

```
2秒以内
```

内訳

```
upload 0.5
analysis 1.2
response 0.3
```

***

# 13. MVP インフラ

最小構成

```
FastAPI
1 CPU server
Firestore
```

モデル

```
wav2vec2
Whisper
```

***

# 14. Mobile App Structure

タブ

```
HOME
PRACTICE
LOG
SETTINGS
```

***

### HOME

```
record
prompt
```

***

### PRACTICE

```
drills
talk
```

***

### LOG

```
speech history
```

***

### SETTINGS

```
profile
pro
help
```

***

# 15. MVP Component List

## Mobile

```
Recording
Prompt Recommendation
SpeechSession storage
UI
```

***

## Backend

```
Speech Evaluation API
Prompt API
```

***

## AI

```
Speech Analyzer
Score Calculator
Advice Generator
```

***

## Data

```
Firestore prompts
Local DB sessions
```

***

# 16. セキュリティ

音声

```
temporary processing
```

保存

```
metadata only
```

***

# 17. 将来の拡張

## AI

```
phoneme alignment
LLM advice
```

***

## Learning

```
curriculum
weekly coaching
```

***

## Infra

```
GPU inference
model improvements
```

***

# まとめ

Accent Fit MVPは

```
Mobile
+
Prompt DB
+
Speech Evaluation API
+
AI evaluation engine
```

の **シンプルな4層構造**です。

***

ここまでで  
**Accent Fit のプロダクト設計はほぼ完成**しています。

もし次に進むなら、実装フェーズに入る前に **最後の1つ**を整理するのが非常におすすめです。

それは

**「MVPの最小機能セット（本当に最初に作るべき画面と機能）」**

です。

これを決めると  
**2〜3週間で動くプロトタイプ**が作れる設計になります。
