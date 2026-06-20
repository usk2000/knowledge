# [Product+System] MVP機能セットと将来的な機能

Accent Fit を **MVP → 将来拡張**の2段階で整理します。  
ポイントは \*\*「学習価値が出る最小セット」\*\*をまず作り、その後 **学習体験を強化する機能**を追加することです。

***

# 1. MVPの最小機能セット

MVPの目的

```
発音練習 → スコア → 改善
```

このループが成立すればOKです。

***

## MVP User Flow

![mermaid-diagram (2)](hnLsYBSX-mermaid-diagram_(2).png)


***

# MVP Screen構成

## 1️⃣ Home / Practice

役割

```
今日の練習
```

表示

- 今日のPrompt

- Recordボタン

UI例

```
Today's practice

Could you send the report?

[Start Recording]
```

***

## 2️⃣ Recording

機能

```
audio recording
```

UI

```
Recording...

[Stop]
```

***

## 3️⃣ Result Screen

表示

```
Fit Score
Advice
```

例

```
Fit Score: 82

Rhythm: 80
Stress: 75
Clarity: 90

Advice
Try stressing the word "report".
```

***

## 4️⃣ History

機能

```
過去の練習
```

例

```
Mar 8
Could you send the report?
Score 82
```

***

# MVP機能一覧

| 機能        | 必須 |
| --------- | -- |
| Prompt表示  | ✔  |
| 録音        | ✔  |
| 音声評価API   | ✔  |
| Fit Score | ✔  |
| Advice    | ✔  |
| 履歴保存      | ✔  |

***

# MVP不要機能

最初は入れない

| 機能        | 理由    |
| --------- | ----- |
| ユーザーアカウント | MVP不要 |
| SNS共有     | 不要    |
| コミュニティ    | 不要    |
| 詳細分析      | 複雑    |

***

# MVP Backend

必要API

```
GET /prompts
POST /speech/evaluations
```

***

# MVP Data

保存

```
SpeechSession
```

***

# MVP Prompt数

十分な量

```
Sentence 40
Drill 20
Talk 10
```

合計

```
70 prompts
```

***

# MVP開発規模

目安

| 項目      | 規模 |
| ------- | -- |
| Mobile  | 小  |
| Backend | 小  |
| AI      | 中  |

開発期間

```
4〜6週間
```

***

# 2. 将来の拡張機能

ここから **学習体験を強化**します。

***

# 拡張 User Flow

![mermaid-diagram (3)](mZHVAjP--mermaid-diagram_(3).png)

***

# 拡張 Screen

## 1️⃣ Progress Dashboard

表示

```
Weekly progress
```

例

```
Stress improvement +12
Rhythm stable
Clarity +5
```

***

## 2️⃣ Weakness Training

例

```
Your weakness: Stress
```

↓

```
Recommended drills
```

***

## 3️⃣ Drill Practice

音素トレーニング

例

```
light right
led red
```

***

## 4️⃣ Talk Practice

自由会話

例

```
Talk about your weekend.
```

***

## 5️⃣ Learning Plan

例

```
Daily plan
```

```
3 sentences
2 drills
1 talk
```

***

# 拡張AI機能

## Phoneme detection

例

```
/r/
/l/
/th/
```

***

## AI Coaching

例

```
Your stress pattern improved today.
```

***

# 拡張機能一覧

| 機能                 | 目的      |
| ------------------ | ------- |
| Progress Dashboard | モチベーション |
| Weakness Training  | 効率学習    |
| Drill Practice     | 音素改善    |
| Talk Practice      | 流暢性     |
| Learning Plan      | 継続      |
| AI Coaching        | UX      |

***

# MVP vs Full Feature

| 項目         | MVP | Full |
| ---------- | --- | ---- |
| Prompt練習   | ✔   | ✔    |
| 音声評価       | ✔   | ✔    |
| Advice     | ✔   | ✔    |
| 履歴         | ✔   | ✔    |
| Progress分析 |     | ✔    |
| 弱点トレーニング   |     | ✔    |
| Drill      |     | ✔    |
| Talk       |     | ✔    |
| AIコーチ      |     | ✔    |
| 学習プラン      |     | ✔    |

***

# MVPの価値

MVPだけでも

```
発音練習
↓
スコア
↓
改善
```

のループが成立します。

***

# 拡張版の価値

Full版では

```
personalized learning
```

になります。

***

# MVPの最小画面数

実は **これだけです**

| Screen    |
| --------- |
| Home      |
| Recording |
| Result    |
| History   |

合計

```
4 screens
```

***

# 最後に（かなり重要）

Accent Fit は実は **個人開発でも成功確率が高いタイプのアプリ**です。

理由

- AI差別化

- 明確な価値

- グローバル市場

ただし成功するかは **ある1つの要素**でほぼ決まります。

それは

```
UX
```

です。

もしよければ次に  
\*\*Accent Fit の「ユーザーがハマるUX設計」\*\*を作ります。  
これはかなりプロダクトの成功に関わる部分です。
