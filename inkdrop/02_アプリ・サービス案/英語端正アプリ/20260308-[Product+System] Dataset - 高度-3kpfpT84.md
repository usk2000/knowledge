# [Product+System] Dataset - 高度


以下に **これまで議論した発音アプリ用 Dataset 設計 → Dataset生成 → phoneme alignment → scoring** を  
**実装観点で一つの設計としてまとめます。**

（あなたの条件）

- 約10 words

- TOEIC 600–950

- IPA保存

- TTSなし

- 音声評価あり

- Google Sheets管理

***

# 1. Dataset全体構造（設計まとめ）

発音AIアプリでは **4種類のDataset** を持つと最も扱いやすいです。

```
phoneme_curriculum
↓
minimal_pairs
↓
sentence_dataset
↓
phoneme_confusion_matrix
```

それぞれの役割

| dataset             | 目的     |
| ------------------- | ------ |
| phoneme\_curriculum | 発音学習順序 |
| minimal\_pairs      | 音素識別訓練 |
| sentence\_dataset   | 実践練習   |
| confusion\_matrix   | 誤発音評価  |

***

# 2. phoneme curriculum

発音学習の順序を定義。

例

| phoneme | stage | example |
| ------- | ----- | ------- |
| iː      | 1     | see     |
| ɪ       | 1     | sit     |
| r       | 2     | right   |
| l       | 2     | light   |
| θ       | 2     | think   |

推奨

```
stage1 vowel
stage2 consonant
stage3 word stress
stage4 sentence stress
stage5 rhythm
stage6 connected speech
stage7 intonation
```

***

# 3. minimal pair dataset

音素の違いを認識させる。

| id    | word\_a | word\_b | ipa\_a | ipa\_b | phoneme |
| ----- | ------- | ------- | ------ | ------ | ------- |
| MP001 | right   | light   | raɪt   | laɪt   | r\_l    |
| MP002 | ship    | sheep   | ʃɪp    | ʃiːp   | ɪ\_iː   |
| MP003 | think   | sink    | θɪŋk   | sɪŋk   | θ\_s    |

おすすめサイズ

```
200 pairs
```

***

# 4. sentence dataset

発音練習のメイン。

Google Sheets構造

| column           | example                                         |
| ---------------- | ----------------------------------------------- |
| id               | PR\_STRESS\_001                                 |
| sentence         | I bought a new camera during the holiday sale   |
| level            | 700                                             |
| word\_count      | 9                                               |
| phoneme\_targets | ɔː                                              |
| prosody\_target  | sentence\_stress                                |
| ipa              | aɪ bɔːt ə nuː kæmərə ˈdjʊərɪŋ ðə ˈhɑːlədeɪ seɪl |
| tags             | shopping                                        |

ルール

```
8–12 words
1–2 pronunciation targets
common vocabulary
```

***

# 5. phoneme confusion matrix

誤発音パターン

| expected | detected | probability |
| -------- | -------- | ----------- |
| r        | l        | 0.25        |
| l        | r        | 0.20        |
| θ        | s        | 0.30        |
| v        | b        | 0.22        |

用途

- scoring

- feedback

***

# 6. Dataset生成フロー

あなたの構想に最適な生成方法

```
template generator
↓
LLM naturalization
↓
IPA generation
↓
Google Sheets
```

***

# 7. Google Sheets → Dataset生成スクリプト（GAS）

Apps Script例

```
function generateSentences() {

  const sheet = SpreadsheetApp.getActive().getSheetByName("sentences")

  const prompt = `
Generate 5 English sentences for pronunciation practice.

Constraints:
- about 10 words
- TOEIC level 600-800
- clear sentence stress

Return JSON:
[
 {sentence:"...", ipa:"...", target:"sentence_stress"}
]
`

  const response = callLLM(prompt)

  const data = JSON.parse(response)

  data.forEach(row => {

    const id = "PR_" + Utilities.getUuid().slice(0,8)

    sheet.appendRow([
      id,
      row.sentence,
      row.ipa,
      row.target
    ])

  })

}
```

***

# 8. Google Sheets → JSON dataset export

```
function exportDataset() {

  const sheet = SpreadsheetApp.getActive().getSheetByName("sentences")
  const rows = sheet.getDataRange().getValues()

  const dataset = []

  for (let i = 1; i < rows.length; i++) {

    dataset.push({
      id: rows[i][0],
      sentence: rows[i][1],
      ipa: rows[i][2],
      target: rows[i][3]
    })

  }

  const json = JSON.stringify(dataset, null, 2)

  DriveApp.createFile("dataset.json", json)

}
```

***

# 9. phoneme alignment（重要）

音声評価の中心。

目的

```
speech → phoneme sequence
```

***

## 方法1（おすすめ）

### Whisper + phoneme conversion

```
audio
↓
Whisper ASR
↓
text
↓
phoneme dictionary
↓
IPA
```

問題

```
phoneme timing が弱い
```

***

## 方法2（発音評価向け）

### forced alignment

おすすめ

```
Montreal Forced Aligner
```

処理

```
audio
+
sentence text
↓
phoneme alignment
```

出力

```
word timing
phoneme timing
```

例

```
b 0.12
ɔː 0.25
t 0.40
```

***

# 10. phoneme alignment pipeline

```
audio
↓
noise reduction
↓
ASR transcript
↓
forced alignment
↓
phoneme sequence
↓
compare with IPA
```

***

# 11. phoneme scoring

例

expected

```
raɪt
```

detected

```
laɪt
```

評価

```
r → l substitution
```

score

```
score = 1 - confusion_probability
```

例

```
P(l|r)=0.25
score=0.75
```

***

# 12. overall score

おすすめ

```
overall_score =
0.5 phoneme_score
+ 0.3 stress_score
+ 0.2 rhythm_score
```

***

# 13. feedback generation

例

```
You pronounced /r/ like /l/.
Try curling your tongue slightly backward.
```

***

# 14. システム構成

```
Google Sheets
↓
dataset generator
↓
JSON dataset
↓
mobile app
↓
speech scoring engine
```

***

# 15. あなたの構想で次に重要なこと

ここまでで **dataset設計 + scoring** はできました。

次に重要なのは

```
sentence design automation
```

です。

理由

発音教材は

```
sentence quality
```

で効果が大きく変わるためです。

***

もし希望があれば、次に

**LLMを使った「発音教材 sentence generator」設計**

を出します。

これを作ると

- Google Sheets

- LLM

- dataset

を使って **数千文の高品質発音教材**を自動生成できます。
