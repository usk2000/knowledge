# [System] Prompt Design System

これは **お題を大量に作っても品質を維持するためのルール**です。  
（発音学習アプリではここがかなり重要です）

目的はこの3つです。

- 発音トレーニングとして **効果のある文章**

- **タグ・ターゲットと整合**

- **大量生成しても破綻しない**

***

# 1. Prompt Design の基本原則

## 原則1：1つの学習目的

1 Prompt = **1発音目的**

例

```
Could you send me the report by Friday?
```

ターゲット

```
prosody:stress
ending:consonant
```

NG

```
too many phonemes
too many long clauses
```

***

## 原則2：短い文章

Sentence Prompt

```
5〜10 words
```

理由

- 発音トレーニングに最適

- 録音が短い

- Retryしやすい

***

## 原則3：自然な英語

避ける

```
textbook sentences
unnatural phrases
```

優先

```
spoken English
```

***

# 2. Prompt のタイプ

Accent Fit では **3種類**です。

***

# 2-1 Sentence Prompts

文章読み上げ

例

```
Could you send me the report?
```

用途

- 発音

- リズム

- ストレス

***

# 2-2 Drill Prompts

音素トレーニング

例

```
light, right, led, red
```

用途

```
phoneme:r_l
```

***

# 2-3 Talk Prompts

会話

例

```
Tell me about your weekend.
```

用途

- fluency

- rhythm

***

# 3. Sentence Prompt Template

Sentence Prompt は **テンプレートから作る**と品質が安定します。

***

## Template 1

```
Could you {verb} the {object}?
```

例

```
Could you send the report?
Could you check the schedule?
```

***

## Template 2

```
I need to {verb} the {object}.
```

例

```
I need to finish the report.
```

***

## Template 3

```
Let's {verb} the {object}.
```

例

```
Let's review the document.
```

***

## Template 4

```
I'll {verb} it by {time}.
```

例

```
I'll finish it by Friday.
```

***

# 4. Drill Prompt Template

音素ごと

***

## r/l

```
light right
led red
long wrong
```

***

## th

```
think thank
this that
three through
```

***

## v/b

```
vest best
very berry
```

***

# 5. Talk Prompt Template

Talk は **topic-based**

***

## Work

```
Tell me about a project you worked on.
```

***

## Daily

```
What did you do yesterday?
```

***

## Opinion

```
What do you think about remote work?
```

***

# 6. Prompt Difficulty 設計

difficulty は

```
1 easy
2 medium
3 hard
```

***

## Level 1

特徴

```
short sentence
common words
```

例

```
Please send the file.
```

***

## Level 2

特徴

```
two clauses
stress patterns
```

例

```
Could you send the report by Friday?
```

***

## Level 3

特徴

```
long sentence
complex rhythm
```

例

```
I'll send the report after the meeting.
```

***

# 7. Prompt Tagging Rules

tags は **UI用**

***

## audience

```
aud:business
aud:daily
```

***

## topic

```
topic:email
topic:meeting
topic:work
```

***

## goal

```
goal:stress
goal:rhythm
goal:clarity
```

***

## length

```
len:short
len:medium
len:long
```

***

# 8. Target Rules

targets は **評価ロジック用**

***

## phoneme

```
phoneme:r
phoneme:l
phoneme:th
phoneme:v
```

***

## prosody

```
prosody:stress
prosody:rhythm
prosody:intonation
```

***

## clarity

```
clarity:consonant
clarity:vowel
```

***

# 9. Prompt 作成数の目安

MVPでは

```
Sentence 60
Drill 30
Talk 20
```

計

```
110 prompts
```

で十分です。

***

# 10. Sentence Prompt Examples（20例）

例

```
Could you send the report?
Please check the schedule.
I need to finish the report.
Let's review the document.
I'll send it by Friday.
Can you open the file?
Please call me later.
I'll update the report.
Let's start the meeting.
Could you check this?
I finished the report.
I'll send the email.
Please review this file.
Let's discuss the plan.
I'll call you tomorrow.
Can you send the file?
Please confirm the schedule.
Let's finish this task.
I'll review the document.
Could you join the meeting?
```

***

# 11. Prompt Quality Checklist

Promptを追加する時のチェック

### 必須

- 5〜10 words

- natural English

- clear pronunciation target

***

### NG

```
idioms
rare vocabulary
tongue twisters
```

***

# 12. Prompt Versioning

Promptは将来修正されます。

そのため

```
version
```

を持たせます。

SpeechSessionには

```
promptTextSnapshot
```

を保存。

***

# 13. Prompt 作成ワークフロー

おすすめ

```
Google Sheets
↓
Review
↓
Firestore sync
```

***

# 14. Prompt Authoring Roles

役割

```
Author
Reviewer
```

Reviewerは

- grammar

- pronunciation clarity

をチェック

***

# 15. Prompt Design System まとめ

Promptは

```
Sentence
Drill
Talk
```

3種類

タグ

```
audience
topic
goal
length
```

ターゲット

```
phoneme
prosody
clarity
```

***

# 最後に（かなり重要）

Accent Fit の設計で

**まだ触れていない重要なテーマ**があります。

それは

```
音声評価エンジンの実装方式
```

です。

つまり

```
自作
vs
既存API
```

です。

これは

- 開発コスト

- 精度

- 運用

すべてに大きく影響します。

希望があれば次に  
\*\*Accent Fit の発音評価エンジンをどう作るか（現実的な技術選択）\*\*を整理します。
