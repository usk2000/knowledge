# [Product] MVP 開発範囲

まず **Step 1: MVPの開発範囲** を決定します。

あなたのコンセプトは明確です：

**10-second pronunciation training**

```
Prompt → Speak → Score → Improve
```

MVPでは **このループを最短距離で成立させること** が最重要です。  
AIプロダクトでは **最初はUX loopが回るかだけ検証する** のが基本です。

***

# Step 1

# MVP開発範囲の決定

まず、機能を3段階に整理します。

| Layer         | 目的           |
| ------------- | ------------ |
| **MVP**       | 発音練習ループが成立する |
| **Core**      | 学習効果を高める     |
| **Expansion** | プロダクト価値を広げる  |

今回は **MVPのみ決定します。**

***

# MVPの機能（候補）

MVPは **6機能だけ** に絞ります。

## 1 Prompt delivery

練習する文章を表示

例

```
I really like reading books.
```

表示情報

- text

- difficulty(optional)

- target phoneme(optional)

***

## 2 Speech recording

ユーザーが発音

要件

- 10秒以内

- ワンタップ録音

- 録音終了自動

***

## 3 Speech scoring

発音評価

MVPはシンプル

出すもの

```
Score: 72
```

将来

```
r: weak
th: weak
```

***

## 4 Feedback display

評価結果表示

MVP

```
Your score: 72
Try again
```

***

## 5 Session save

練習結果保存

保存内容

```
SpeechSession

promptId
score
audioURL(optional)
timestamp
```

***

## 6 Daily practice counter

習慣化のため

表示

```
Today: 3 practices
```

***

# MVPに入れない機能

意図的に削ります。

### ❌ Pronunciation Map

AI要素が強くMVPには重い

### ❌ Recommendation Engine

まずデータが必要

### ❌ phoneme-level scoring

後で追加

### ❌ login

最初は anonymous

### ❌ social

不要

***

# MVP UX Flow

```
Home
 ↓
Practice
 ↓
Record
 ↓
Score
 ↓
Retry
```

これだけです。

***

# MVP Scopeまとめ

**機能数**

```
6 features
```

**画面数（暫定）**

```
3 screens
```

```
Home
Practice
Result
```

***

# MVPの成功条件

この3つが確認できれば成功

1️⃣ ユーザーが10秒練習を繰り返す  
2️⃣ スコアを見ることで再挑戦する  
3️⃣ 毎日使える

***

# 確認したいこと

MVPの思想として **2つの方向性** があります。

### A

**最速MVP**

```
Score only
```

例

```
Score: 72
```

***

### B

**弱点フィードバックMVP**

例

```
Score: 72

Weak sounds
R
TH
```

***

# 質問

MVPはどちらにしますか？

### ① Ultra Lean MVP

```
Prompt
Record
Score
```

***

### ② AI体験MVP

```
Prompt
Record
Score
Weak phoneme
```

***

おすすめは **①** です。  
理由：

- 開発速度

- Whisperだけで実装できる

- UX検証が早い

***

選択していただければ、次に進みます。

次のステップ

```
Step 2
画面設計
(Screen Design)
```

ここでは

- 画面数

- UI要素

- 画面遷移

- UXフロー

を **プロダクトレベルで設計** します。

**① Ultra Lean MVP**で進めます。

つまり MVP はこの **最小ループ**になります。

```
Prompt → Speak → Score → Repeat
```

これはプロジェクトのコアコンセプトである  
**10-second pronunciation training** と完全に一致します。pasted

***

# Step 1 結論

# MVP 開発範囲

## MVP Feature List

| Feature          | 内容      |
| ---------------- | ------- |
| Prompt delivery  | 練習文章表示  |
| Speech recording | 音声録音    |
| Speech scoring   | 発音スコア   |
| Result display   | スコア表示   |
| Session storage  | 練習履歴保存  |
| Daily counter    | 今日の練習回数 |

**合計：6機能**

***

# MVP User Loop

UXは極端にシンプルにします。

```
Open App
 ↓
See Prompt
 ↓
Tap Speak
 ↓
Speak (≤10s)
 ↓
Score appears
 ↓
Retry
```

**30秒以内で1セッション**

***

# MVPで扱うデータ

## Prompt

```
Prompt
- id
- text
```

例

```
I really like reading books.
```

***

## SpeechSession

```
SpeechSession
- id
- promptId
- score
- duration
- createdAt
```

※ MVPでは audio 保存しなくても良い

***

## UserProfile

MVPでは最小

```
UserProfile
- id
- createdAt
```

ログイン不要  
anonymous user

***

# MVPでやらないこと（重要）

以下は **意図的に削除**

| Feature               | 理由         |
| --------------------- | ---------- |
| Pronunciation Map     | データが必要     |
| Phoneme scoring       | AI開発コスト    |
| Recommendation engine | 早すぎる       |
| Account system        | friction増加 |
| Social                | 不要         |

***

# MVP成功の指標

3つだけ見ます。

```
Daily practice count
Session completion rate
Retry rate
```

もし

```
Retry > 40%
```

ならUX成功。

***

# MVP開発コスト

概算

| Component       | Complexity |
| --------------- | ---------- |
| Mobile UI       | Low        |
| Audio recording | Low        |
| Backend scoring | Medium     |
| AI evaluation   | Medium     |
| Firestore       | Low        |

**約3〜4週間**

***

# 次のステップ

次は **Step 2：画面設計**です。

ここでは

```
画面数
UI要素
画面遷移
UX flow
```

を決めます。

MVPでは画面は **かなり少なくできます。**

おそらく

```
2 screen
or
3 screen
```

になります。

***

次の質問です。

UXをどちらにしますか？

### A（おすすめ）

**1画面UX**

```
Prompt
↓
Record
↓
Score
```

全部同じ画面

TikTok型UX

***

### B

**3画面UX**

```
Home
Practice
Result
```

***

個人的には  
\*\*A（1画面UX）\*\*を強くおすすめします。

理由

- friction最小

- 習慣化しやすい

- 10秒練習に最適

- 実装も簡単

***

選んでください。

```
A
Single Screen UX
```

or

```
B
3 Screen UX
```

決まったら  
**次は画面設計を具体的に作ります（UIレベルまで）。**

SwiftUI / Android両方を意識した設計にします。

情報源
