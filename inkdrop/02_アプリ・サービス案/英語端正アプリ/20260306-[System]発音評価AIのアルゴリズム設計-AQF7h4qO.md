# [System]発音評価AIのアルゴリズム設計


# 1. 発音評価の目的（再確認）

Accent Fit の評価は **「正誤判定」ではない**です。

目的はこれです。

```
ネイティブ発音との距離を測る
```

つまり

```
Fit = similarity
```

です。

***

# 2. 評価の全体フロー

音声評価の処理パイプライン

```
audio recording
   ↓
speech recognition
   ↓
phoneme alignment
   ↓
prosody analysis
   ↓
score calculation
   ↓
advice generation
```

***

# 3. 入力データ

### ユーザー音声

```
user_audio.wav
```

***

### Prompt情報

```
prompt_text
sample_audio
targets
```

例

```
Could you send me the report by Friday?
```

***

# 4. 音声処理ステップ

## Step1 Speech-to-text

まず **認識が大きく外れていないか**を確認します。

ツール候補

- Whisper

- Vosk

- Google Speech

出力

```
recognized_text
confidence
```

***

## Step2 phoneme alignment

ユーザー発音と理想発音の音素を比較

例

```
prompt phoneme
K UH D Y UW

user phoneme
K UH D Y UW
```

または

```
R EH P AO R T

R EH P AO T
```

ここで

```
missing consonant
```

などを検出

***

# 5. 評価項目

Accent Fit では **3軸だけ**にします。

これは UX のためです。

***

## 1️⃣ Rhythm

リズム

評価

```
syllable timing
pause
speech rate
```

例

```
too fast
unnatural pause
```

***

## 2️⃣ Stress

アクセント

評価

```
word stress
sentence stress
```

例

```
rePORT vs REport
```

***

## 3️⃣ Clarity

明瞭さ

評価

```
phoneme similarity
consonant clarity
vowel quality
```

***

# 6. Fit Score 計算

Fit Score は **0〜100**

例

```
Rhythm 80
Stress 70
Clarity 85
```

***

## 総合スコア

シンプルに

```
overall =
0.35 * rhythm
0.35 * stress
0.30 * clarity
```

***

# 7. Advice生成

Adviceは **最大1つ**

理由

- 人間は複数改善できない

- UXが悪くなる

***

## Advice生成ロジック

一番低いスコアを選択

```
min(rhythm, stress, clarity)
```

***

### 例

```
Rhythm 82
Stress 63
Clarity 88
```

↓

```
target = stress
```

***

## Adviceテンプレート

例

```
Try stressing the word “report”.
```

または

```
Keep a steady rhythm between words.
```

***

# 8. Advice生成テンプレート

テンプレートベースにすると運用が簡単

例

```
stress:
"Try stressing the word {word}"

rhythm:
"Keep a steady rhythm between words"

consonant:
"Make the ending consonant clearer"
```

***

# 9. 将来の高度化

MVPはシンプルで良いです。

将来は

### phonemeレベル

```
/r/
/l/
/th/
```

***

### アドバイス例

```
Try pulling your tongue slightly back for /r/
```

***

# 10. AI構成（現実的な構成）

MVP構成

```
Whisper
+
phoneme model
+
rule based advice
```

***

高度版

```
Speech encoder
+
embedding similarity
+
LLM advice
```

***

# 11. Fit Score計算の簡易版（MVP）

MVPでは **phoneme alignment無しでも成立します**

方法

```
audio embedding similarity
```

例

```
wav2vec
HuBERT
```

***

評価

```
cosine similarity
```

***

Fit Score

```
score = similarity * 100
```

***

# 12. MVPアルゴリズム（おすすめ）

最初はこれが一番現実的です。

```
record audio
↓
embedding
↓
sample audio embedding
↓
cosine similarity
↓
Fit Score
```

***

Advice

```
score低い
↓
テンプレート
```

***

# 13. Accent Fitの強み

他アプリ

```
Speech recognition
```

Accent Fit

```
Pronunciation similarity
```

***

# 14. システム構成

```
App
 ↓
Audio upload
 ↓
Evaluation API
 ↓
Fit Score
 ↓
Advice
```

***

# 15. ここまでで設計が揃ったもの

### プロダクト

- 概念

- 機能

### システム

- Prompt DB

- SpeechSession

- FitScore

- Advice

### AI

- evaluation pipeline

***

# 次の重要ステップ

次は **実装設計で一番重要な部分**です。

```
Speech evaluation service
```

つまり

```
evaluateSpeech()
```

のAPI設計です。

ここを作ると

- iOS

- Android

- Web

全部使えます。

希望があれば  
**Accent Fit の Speech Evaluation API を実装レベルで設計します。**

これはかなり重要な部分です。
