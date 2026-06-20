# [System]発音評価API設計


ここでは次を確定します。

- API の責務
- リクエスト / レスポンス
- 同期 / 非同期方針
- ドメインモデルとの対応
- MVP実装案
- 将来拡張ポイント

# 1. API の役割

この API の責務は、**録音音声を評価して Fit Score と Fit Advice を返すこと**です。

アプリ側から見ると、やりたいことは実質これだけです。

```
evaluateSpeech
```

ただし内部では、

- Prompt取得
- 音声前処理
- 音声比較
- スコア算出
- アドバイス生成

を行います。

***

# 2. API の基本方針

## 推奨

**最初は同期API** で良いです。

理由

- 1発話が短い
- UXがシンプル
- 実装しやすい
- iOS / Android 両方で扱いやすい

つまりアプリは

```
音声アップロード
→ 数秒待つ
→ Result表示
```

です。

***

## 非同期が必要になる条件

次のどれかが来たらジョブ型にします。

- Fit Talkで長い音声を扱う
- 複数候補比較をする
- 音声生成や高度なLLM解析を入れる
- 処理時間が数秒を超える

MVPでは不要です。

***

# 3. API エンドポイント構成

最小構成は **2本** で十分です。

## 1. 発音評価

```
POST /v1/speech/evaluations
```

## 2. サンプル音声や評価対象情報の取得

これは Prompt API 側に寄せる

```
GET /v1/prompts/{promptId}
GET /v1/prompts
```

つまり、Speech Evaluation API 自体は  
**評価に専念**させます。

***

# 4. 評価APIのリクエスト設計

## 推奨構造

音声ファイル本体は multipart か事前アップロードURL で送れますが、  
MVPでは **multipart/form-data** が最も簡単です。

***

## Request 例

```
POST /v1/speech/evaluations
Content-Type: multipart/form-data
Authorization: Bearer <token>
```

### form fields

- `audioFile`: 録音音声
- `promptId`: 対象Prompt
- `mode`: `sentence | free | drill | talk`
- `locale`: 例 `en-US`
- `userLevel`: `1 | 2 | 3`
- `appVersion`: 任意
- `devicePlatform`: `ios | android`

***

## JSONで表現するとこうです

```
{
  "promptId": "prompt_001",
  "mode": "sentence",
  "locale": "en-US",
  "userLevel": 2,
  "devicePlatform": "ios"
}
```

＋音声ファイル

***

# 5. レスポンス設計

このAPIの返り値は **SpeechSessionを完成させる材料** です。

***

## Response 例

```
{
  "evaluationId": "eval_123",
  "prompt": {
    "id": "prompt_001",
    "version": 3,
    "text": "Could you send me the report by Friday?"
  },
  "fitScore": {
    "overall": 82,
    "rhythm": 80,
    "stress": 78,
    "clarity": 87
  },
  "fitAdvice": {
    "target": "prosody:stress",
    "message": "Try stressing the word report a little more.",
    "why": "Clearer stress makes the sentence sound more natural.",
    "priority": "primary"
  },
  "quickInsight": "Getting closer. Your clarity is strong.",
  "labels": [
    "getting_closer",
    "clarity_strong"
  ],
  "analysis": {
    "recognizedText": "Could you send me the report by Friday",
    "confidence": 0.94,
    "durationMs": 4100
  },
  "debug": {
    "modelVersion": "eval-mvp-1.0"
  }
}
```

***

# 6. レスポンスの責務分離

## UI向け

- `fitScore`
- `fitAdvice`
- `quickInsight`
- `labels`

## ログ保存向け

- `prompt.id`
- `prompt.version`
- `prompt.text`
- `analysis.durationMs`
- `evaluationId`

## 将来の改善用

- `recognizedText`
- `confidence`
- `modelVersion`

この分離にしておくと、  
クライアントは **そのままSpeechSessionへ保存**しやすいです。

***

# 7. SpeechSession への保存対応

アプリ側はAPIレスポンスを受けたら、ローカルにこう保存します。

```
{
  "id": "session_001",
  "createdAt": "2026-03-06T18:00:00Z",
  "mode": "sentence",
  "promptId": "prompt_001",
  "promptVersion": 3,
  "promptTextSnapshot": "Could you send me the report by Friday?",
  "audioLocalPath": "/local/audio/001.m4a",
  "fitScoreOverall": 82,
  "fitScoreRhythm": 80,
  "fitScoreStress": 78,
  "fitScoreClarity": 87,
  "adviceTarget": "prosody:stress",
  "adviceMessage": "Try stressing the word report a little more.",
  "quickInsight": "Getting closer. Your clarity is strong.",
  "evaluationId": "eval_123"
}
```

***

# 8. ドメインモデルとの対応

API上の返却値は、ドメインではこの4つにマッピングできます。

## Prompt

```
prompt.id
prompt.version
prompt.text
```

## FitScore

```
overall
rhythm
stress
clarity
```

## FitAdvice

```
target
message
why
priority
```

## SpeechSession

APIレスポンスそのものではなく、  
クライアントで `audioLocalPath` 等を付加して完成

***

# 9. エラー設計

発音評価APIはエラー時UXが重要です。

## エラー分類

### 1. ユーザー音声起因

- 音が短すぎる
- 無音
- ノイズが大きい

例

```
{
  "error": {
    "code": "audio_too_short",
    "message": "Please speak a little longer."
  }
}
```

### 2. Prompt不整合

- promptIdが無効
- archived prompt

### 3. サーバー評価失敗

- モデル失敗
- タイムアウト

### 4. 認識できたが評価不能

例えば text mismatch が大きい場合

```
{
  "error": {
    "code": "speech_not_matched",
    "message": "Please try reading the sentence a bit more closely."
  }
}
```

***

# 10. MVP内部ロジック

MVPでは、内部をあまり複雑にしない方が良いです。

## 推奨パイプライン

```
1. promptId から Prompt を取得
2. 音声を前処理
3. STT で recognizedText を取得
4. sampleAudio または prompt基準で similarity を算出
5. rhythm / stress / clarity を簡易推定
6. 一番弱い項目から advice を1つ作る
7. 結果を返す
```

***

## MVPでの実装現実案

### パターンA

- Whisper系で transcription

- 音声埋め込み類似度で overall

- ルールベースで advice

### パターンB

- STT結果中心

- prosody特徴量を別途計算

- テンプレートで advice

最初は **A+Bのハイブリッド** が現実的です。

***

# 11. API のレスポンスタイム目標

MVPのUX上、目安はこれです。

- 理想：**2秒以内**

- 許容：**5秒以内**

- 5秒超なら将来ジョブ化を検討

***

# 12. Fit Talk を見据えた拡張

将来 Fit Talk を入れるなら、今のうちに `mode` を必ず持たせます。

## mode

- `sentence`
- `free`
- `drill`
- `talk`

これで同じAPIを再利用できます。

Talkでは prompt が質問文になります。

***

# 13. 将来拡張したいレスポンス項目

MVPでは返さなくてよいが、将来追加しやすいように場所だけ意識しておくと良いです。

## 追加候補

- `phonemeFindings`
- `segmentScores`
- `recommendedPromptIds`
- `comparisonToPrevious`
- `confidenceLevel`

例

```
{
  "phonemeFindings": [
    {
      "target": "phoneme:r",
      "score": 62,
      "note": "Tongue position may be too relaxed."
    }
  ]
}
```

***

# 14. API 契約の最小版

本当に最小ならこれだけでも成立します。

## Request

- audioFile
- promptId
- mode

## Response

```
{
  "fitScore": {
    "overall": 82,
    "rhythm": 80,
    "stress": 78,
    "clarity": 87
  },
  "fitAdvice": {
    "target": "prosody:stress",
    "message": "Try stressing the word report a little more."
  },
  "quickInsight": "Getting closer. Your clarity is strong."
}
```

ただし、実務上は `prompt.version` と `evaluationId` は最初から入れておく方が後で助かります。

***

# 15. 推奨API仕様まとめ

## Endpoint

```
POST /v1/speech/evaluations
```

## Request

- multipart/form-data
- audioFile
- promptId
- mode
- locale
- userLevel

## Response

- prompt snapshot
- fitScore
- fitAdvice
- quickInsight
- analysis metadata
- evaluationId

## 保存先

- Prompt：Firestore

- SpeechSession：端末ローカル

***

# 16. 次に進むべき設計

ここまでで、かなり実装可能な状態になっています。  
次にやるべきは、順番としてはこのどちらかです。

## A. ドメイン / Repository 設計

- `PromptRepository`
- `SpeechEvaluationRepository`
- `SpeechSessionRepository`

## B. APIサーバー内部設計

- 評価ユースケース
- モデル分割
- Whisper / embedding / advice generator の責務分離

実装に直結するのは **B. APIサーバー内部設計** です。
