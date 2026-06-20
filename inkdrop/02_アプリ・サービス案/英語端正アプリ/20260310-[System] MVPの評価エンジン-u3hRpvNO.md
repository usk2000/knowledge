# [System] MVPの評価エンジン

では \*\*Accent Fit の AI Pipeline（実戦レベル設計）\*\*を説明します。  
これは **MVP → Core → Expansion** にスムーズに進化する構造です。  
あなたの構成（FastAPI / Firestore / Whisper）とも完全に整合します。 pasted

***

# 1. AI Pipeline 全体像

将来の Accent Fit の評価エンジンはこうなります。

```
```

***

# 2. MVP Pipeline

MVPでは **超シンプル**

```
```

***

## MVP 評価ロジック

```
score = (1 − WER) * 100
```

例

```
prompt:
Please send the report tomorrow

transcript:
Please send report tomorrow
```

WER

```
1 / 5 = 0.2
```

score

```
80
```

***

# 3. Core Pipeline（Pronunciation評価）

MVPの次に必要になるもの

```
phoneme alignment
```

***

## Alignment Pipeline

```
```

***

# Alignmentとは

単語ではなく

```
音素
```

単位で評価する。

例

```
report
```

IPA

```
r ɪ p ɔː r t
```

***

Audioから

```
r timing
ɪ timing
p timing
...
```

を取得。

***

# 4. Category Scoring

Accent Fit の将来カテゴリ

```
Stress
Rhythm
Clarity
R/L
TH
```

***

## scoring

```
```

***

# 5. Pronunciation Map

これが **Accent Fit のコア機能**

```
```

***

例

```
user sessions

R: 50
TH: 40
L: 80
```

結果

```
weak phonemes

R
TH
```

***

# 6. Recommendation Engine

```
```

例

```
weak: R
```

推薦

```
Red roses are really rare
```

***

# 7. AI Service Architecture

本番では

```
```

***

# 8. AI Server Directory

将来はこう分けるのが理想

```
ai/

asr/
   whisper.py

alignment/
   phoneme_align.py

scoring/
   pronunciation_score.py

features/
   rhythm.py
   stress.py
   clarity.py
```

***

# 9. MVPからの移行方法

重要なのは

**API interface を変えない**

***

現在

```
POST /evaluate
```

response

```
score
transcript
```

***

将来

```
score
transcript
categoryScores
phonemeScores
advice
```

***

つまり

APIは同じ。

***

# 10. Whisperの限界

Whisperは

```
speech recognition
```

専用

なので

```
phoneme scoring
```

には弱い。

***

そのため

```
wav2vec2
```

を追加。

***

# 11. 将来の評価エンジン

最終形

```
```

***

# 12. MVPの評価改善（簡単）

WERだけだと

```
Please send report tomorrow
```

でも高スコア。

改善するには

```
WER + pronunciation confidence
```

***

例

```
score = 0.7 * WER + 0.3 * confidence
```

***

# 13. AIモデルコスト

参考

| Model        | latency | cost |
| ------------ | ------- | ---- |
| whisper tiny | 0.3s    | 低    |
| whisper base | 1s      | 中    |
| wav2vec2     | 2s      | 高    |

***

# 14. MVPに最適な構成

```
Cloud Run
Whisper tiny
Firestore
```

***

# 15. 最重要アドバイス

Accent Fit は

**AIよりデータが重要**

つまり

```
prompt dataset
phoneme coverage
```

***

あなたが既に作っている

```
phoneme dataset
```

は

**かなり良い戦略**

***

# 次にやると良いこと

Accent Fit の成功に一番重要なのは

```
Prompt Dataset
```

です。

もし希望があれば次に

**Accent Fit Prompt Dataset 完全設計**

```
phoneme coverage dataset
difficulty curve
curriculum
prompt generation
```

を作ります。

これは **AIプロダクトの成功率を左右する部分**です。

情報源
