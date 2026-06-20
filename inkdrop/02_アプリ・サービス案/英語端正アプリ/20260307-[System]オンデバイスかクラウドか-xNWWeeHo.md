# [System]オンデバイスかクラウドか

ここでは **Accent Fit の発音評価を「オンデバイス vs サーバー」どちらで実行するか**を、実務的に整理します。結論だけでなく、**MVP→拡張の現実的なロードマップ**も示します。

***

# 1. 結論（先に）

**MVPはサーバー評価が最適です。**

理由はシンプルで、次の4点です。

1. モデルサイズ

2. モデル更新

3. 実装コスト

4. 精度改善

***

# 2. オンデバイス評価

## 構造

```
App
 ↓
Audio recording
 ↓
Local speech model
 ↓
Score
```

***

## メリット

### 1️⃣ レイテンシが低い

```
0.5〜1秒
```

***

### 2️⃣ プライバシー

音声が端末外に出ない

***

### 3️⃣ オフライン

通信不要

***

## デメリット

### 1️⃣ モデルサイズ

例

```
wav2vec2
≈ 300MB
```

これは

```
アプリサイズ爆発
```

になります。

***

### 2️⃣ モデル更新が困難

評価アルゴリズムを改善する場合

```
App update 必須
```

***

### 3️⃣ 計算コスト

音声モデルは

```
CPU負荷
```

が高いです。

***

# 3. サーバー評価

## 構造

```
App
 ↓
upload audio
 ↓
Speech Evaluation API
 ↓
Fit Score
```

***

## メリット

### 1️⃣ モデル改善が簡単

サーバー更新で

```
精度向上
```

できます。

***

### 2️⃣ 大きなモデル使用可能

例

```
wav2vec2-large
```

***

### 3️⃣ 実装が簡単

モバイルは

```
upload + result
```

だけ。

***

## デメリット

### 1️⃣ レイテンシ

```
2〜3秒
```

***

### 2️⃣ インフラコスト

音声解析

```
CPU/GPU
```

***

# 4. Accent Fit の要件

Accent Fit は

```
短い音声
数秒
```

です。

つまり

```
サーバー評価でもUXは問題ない
```

***

# 5. 推奨アーキテクチャ

MVP

```
iOS / Android
 ↓
Speech Evaluation API
 ↓
Evaluation Service
 ↓
wav2vec2 + Whisper
```

***

# 6. API処理時間

理想

```
2秒
```

内訳

```
upload   0.5s
analysis 1.2s
response 0.3s
```

***

# 7. 音声データの扱い

重要です。

### 推奨

```
音声は保存しない
```

理由

- プライバシー

- 法的リスク

- ストレージコスト

***

保存するのは

```
SpeechSession metadata
```

のみ。

***

# 8. 将来の進化

MVP

```
Server evaluation
```

***

Stage2

```
Server + cache
```

***

Stage3

```
Hybrid
```

***

# 9. Hybrid architecture

最終形はこれです。

```
Quick score → On-device
Accurate score → Server
```

***

例

```
0.5秒
Quick Fit Score
```

↓

```
2秒
Detailed Score
```

***

# 10. Apple環境

将来は

```
CoreML
```

で

```
small speech model
```

が載せられます。

***

# 11. Android

同様に

```
TensorFlow Lite
```

***

# 12. Accent Fit の最適構成

MVP

```
Server evaluation
```

***

モバイル

```
record
upload
show result
```

***

サーバー

```
speech embedding
score
advice
```

***

# 13. インフラ最小構成

最小

```
FastAPI server
1 CPU machine
```

embeddingモデルは

```
CPUでも動く
```

***

# 14. コスト

1評価

```
0.1〜0.3秒 CPU
```

なので

```
100k/day
```

でも

小規模VMで回ります。

***

# 15. MVPスタック

サーバー

```
Python
FastAPI
PyTorch
```

モデル

```
Whisper
wav2vec2
```

***

# 16. モバイル実装

必要なのは

```
audio recording
multipart upload
```

のみ。

***

# 17. Accent Fit の完成アーキテクチャ

```
iOS / Android
   ↓
SpeechEvaluationRepository
   ↓
HTTP
   ↓
Evaluation API
   ↓
Speech Analyzer
   ↓
Score + Advice
```

***

# 最後に

ここまでで

**Accent Fit は実際に作れるレベルまで設計が固まりました。**

ただし、実際に作るときに **最後の大きな設計**があります。

それは

```
Prompt recommendation system
```

つまり

```
次のお題をどう出すか
```

です。

これは

- 継続率

- 学習効率

を大きく左右します。

もしよければ次に  
\*\*Accent Fit の Prompt Recommendation Engine（かなり重要）\*\*を設計します。
