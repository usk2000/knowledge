# [Product+System] Dataset - 高度2

ここでは **発音教材用 Sentence Generator** を、あなたの構想（Google Sheets＋スクリプト生成＋LLM補助）に合わせて設計します。  
目的は **数百〜数千文の安定した発音練習データを自動生成**することです。

***

# 1. Sentence Generator の基本方針

発音教材では **完全LLM生成はおすすめしません**。  
理由：

- 発音ターゲットが崩れる

- stress pattern が不安定

- IPA生成の誤り

そのため構成は

```
phoneme curriculum
↓
template generator
↓
LLM naturalization
↓
IPA generation
↓
dataset validation
↓
Google Sheets
```

***

# 2. Sentence生成ルール

発音教材の品質を保つために **設計ルール**を決めます。

### 文長

```
8–12 words
```

### ターゲット密度

```
1–2 pronunciation targets
```

### 語彙

```
CEFR B1–C1
```

### prosody

```
clear stress pattern
```

***

# 3. テンプレート設計

例（stress練習）

Template

```
I bought a new {product} during the {event} sale
```

variables

```
product = camera, laptop, jacket
event = holiday, summer, clearance
```

生成

```
I bought a new camera during the holiday sale
I bought a new laptop during the summer sale
```

***

# 4. phoneme targeting template

例（母音 /ɔː/）

Template

```
I bought a {object} before the morning call started
```

targets

```
bought
call
```

***

# 5. prosody template

例（sentence stress）

```
I REALLY enjoyed the movie we watched last night
```

stress

```
REALLY ENJOYED MOVIE
```

***

# 6. Google Sheets Template Table

Sheet: `templates`

| id   | template                                         | target |
| ---- | ------------------------------------------------ | ------ |
| T001 | I bought a new {product} during the {event} sale | stress |
| T002 | The {device} stopped working during the meeting  | vowel  |

***

Sheet: `variables`

| key     | values                   |
| ------- | ------------------------ |
| product | camera,laptop,jacket     |
| event   | holiday,summer,clearance |
| device  | computer,printer,router  |

***

# 7. テンプレート展開スクリプト（GAS）

```
function expandTemplates() {

  const templateSheet = SpreadsheetApp.getActive().getSheetByName("templates")
  const varSheet = SpreadsheetApp.getActive().getSheetByName("variables")
  const outputSheet = SpreadsheetApp.getActive().getSheetByName("sentences")

  const templates = templateSheet.getDataRange().getValues()
  const vars = varSheet.getDataRange().getValues()

  const dict = {}

  for (let i=1;i<vars.length;i++){
    dict[vars[i][0]] = vars[i][1].split(",")
  }

  for (let i=1;i<templates.length;i++){

    let sentence = templates[i][1]

    Object.keys(dict).forEach(key => {

      const value = dict[key][Math.floor(Math.random()*dict[key].length)]

      sentence = sentence.replace(`{${key}}`, value)

    })

    const id = "PR_" + Utilities.getUuid().slice(0,8)

    outputSheet.appendRow([id, sentence, templates[i][2]])

  }

}
```

***

# 8. LLM naturalization

テンプレート文を自然化。

prompt例

```
Rewrite this sentence naturally but keep the same meaning.
Sentence length around 10 words.

Sentence:
I bought a new camera during the holiday sale
```

LLM output

```
I bought a new camera during the big holiday sale.
```

***

# 9. IPA生成

LLMでIPAを生成。

prompt

```
Provide IPA transcription for the following sentence.

Sentence:
I bought a new camera during the holiday sale
```

output

```
aɪ bɔːt ə nuː kæmərə ˈdjʊərɪŋ ðə ˈhɑːlədeɪ seɪl
```

***

# 10. IPA validation

チェック

```
word count
IPA token count
stress mark
```

***

# 11. Dataset Validation

自動チェック

```
word count 8–12
contains target phoneme
unique sentence
```

***

# 12. Dataset生成パイプライン

```
template generator
↓
sentence expansion
↓
LLM naturalization
↓
IPA generation
↓
validation
↓
Google Sheets
```

***

# 13. 生成数

おすすめ

| dataset           | size |
| ----------------- | ---- |
| minimal pairs     | 200  |
| phoneme sentences | 300  |
| prosody sentences | 300  |

合計

```
800 sentences
```

***

# 14. Sentence quality improvement

LLMに **sentence scoring** をさせると品質が上がります。

prompt

```
Score this sentence for pronunciation training.

Criteria
- clear stress
- natural rhythm
- common vocabulary

Score 1-10
```

***

# 15. 自動生成システム

最終構成

```
Google Sheets
↓
GAS generator
↓
LLM API
↓
dataset
↓
mobile app
```

***

# 16. あなたのアプリで次に重要なこと

ここまでで

```
dataset
generator
alignment
scoring
```

は揃いました。

しかし実際の発音AIアプリでは **もう1つ超重要なもの**があります。

それは

```
speech scoring model
```

です。

実は

- Duolingo

- ELSA Speak

- Speak

などは **独自の発音スコアモデル**を持っています。

もし希望があれば次に

**発音AIアプリの scoring engine（実装レベル）**

を解説できます。

内容

- phoneme alignment

- GOP scoring

- pronunciation score

- Swift / Kotlin 実装構造

です。
