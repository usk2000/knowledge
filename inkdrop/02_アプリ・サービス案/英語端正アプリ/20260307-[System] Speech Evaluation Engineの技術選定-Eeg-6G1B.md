# [System] Speech Evaluation Engineの技術選定


ここでは **Accent Fit の発音評価エンジン（Speech Evaluation Engine）を現実的な技術選択で設計**します。  
ポイントは \*\*「MVPを速く作る」＋「将来高度化できる」\*\*ことです。

整理する内容：

1. 技術選択の選択肢

2. MVPに最適な構成

3. 評価アルゴリズムの具体構造

4. 実装スタック（推奨）

5. 将来の進化パス

***

# 1. 発音評価エンジンのアプローチ（3種類）

英語発音評価には主に次の3方式があります。

## ① STTベース（Speech-to-text）

仕組み

```
audio
↓
speech recognition
↓
expected text と比較
↓
評価
```

例

- Whisper

- Google Speech

評価できるもの

- 認識一致率

- 発話速度

弱点

- 発音そのものの評価が弱い

- accent評価ができない

***

## ② 音素比較（phoneme alignment）

仕組み

```
audio
↓
phoneme recognition
↓
expected phoneme
↓
alignment
```

例

```
report
R IH P AO R T
```

メリット

- 発音のどこが違うか分かる

弱点

- 実装がかなり重い

- モデルが必要

***

## ③ 音声埋め込み（embedding similarity）

仕組み

```
audio
↓
speech embedding
↓
reference audio embedding
↓
cosine similarity
```

メリット

- 実装がシンプル

- accent差を評価できる

弱点

- 細かい音素指摘は難しい

***

# 2. MVPに最適な方式

Accent Fit MVPは **③ embedding similarity + STT補助** がベストです。

理由

- 実装が速い

- 精度がそこそこ高い

- infraが軽い

***

# 3. MVPエンジン構成

```
audio
 ↓
speech embedding
 ↓
reference embedding
 ↓
cosine similarity
 ↓
FitScore
 ↓
rule-based advice
```

***

# 4. 推奨モデル

embeddingモデル

### 最有力

```
wav2vec2
HuBERT
```

用途

```
speech embedding
```

***

### 軽量候補

```
whisper encoder
```

***

### STT

```
Whisper
```

***

# 5. FitScore計算

similarity

```
cosine_similarity(user, reference)
```

例

```
0.82
```

↓

```
FitScore = 82
```

***

# 6. Score breakdown

embedding similarityだけでは

```
rhythm
stress
clarity
```

は出ません。

そこで **特徴量を追加**します。

***

## Rhythm

計算

```
speech_rate
pause pattern
```

***

## Stress

計算

```
energy peaks
syllable duration
```

***

## Clarity

計算

```
embedding similarity
```

***

# 7. Score計算式

```
overall =
0.35 * rhythm
0.35 * stress
0.30 * clarity
```

***

# 8. Advice生成

MVPは **ルールベース**で十分です。

例

```
stress < 70
→ stress advice
```

テンプレ

```
Try stressing the word "{keyword}".
```

***

# 9. Reference audio

評価には **reference音声**が必要です。

取得方法

## 方法1

TTS

例

```
Amazon Polly
Google TTS
ElevenLabs
```

メリット

- Promptが増えても自動生成

***

## 方法2

人間音声

メリット

- 精度高い

デメリット

- スケールしない

***

# 10. 推奨

```
TTS + embedding
```

***

# 11. サーバー構成

```
Speech Evaluation Service
```

内部

```
API
↓
Prompt fetch
↓
Audio preprocess
↓
Embedding model
↓
Similarity
↓
Score calculator
↓
Advice generator
```

***

# 12. 推奨技術スタック

サーバー

```
Python
FastAPI
PyTorch
```

モデル

```
wav2vec2
Whisper
```

音声処理

```
librosa
torchaudio
```

***

# 13. インフラ

最小構成

```
API server
GPU optional
```

embedding計算は

```
CPUでも可
```

***

# 14. レイテンシ

MVP目標

```
2〜3秒
```

内訳

```
upload 0.5s
analysis 1.5s
response 0.5s
```

***

# 15. 将来の進化

## Stage2

```
phoneme alignment
```

例

```
Montreal Forced Aligner
```

***

## Stage3

```
speech transformer
```

例

```
SpeechT5
wavLM
```

***

## Stage4

LLM advice

```
phoneme findings
↓
LLM explanation
```

***

# 16. 最終アーキテクチャ

```
iOS / Android
 ↓
Speech Evaluation API
 ↓
Embedding Model
 ↓
Score Calculator
 ↓
Advice Generator
```

***

# 17. MVP構成（現実）

```
Whisper
+
wav2vec2
+
rule advice
```

***

# 最後に（かなり重要）

ここまでで **Accent Fit の設計はほぼ完成**しています。

ただし、実装に入る前に **1つ決めるべき最重要事項**があります。

それは

```
音声評価を

ローカル
or
サーバー
```

どちらでやるかです。

これは

- コスト

- レイテンシ

- 精度

- Appサイズ

に直結します。

もしよければ次に  
**Accent Fit の音声評価を「オンデバイス or サーバー」どちらにするべきか**を、かなり実践的に整理します。
