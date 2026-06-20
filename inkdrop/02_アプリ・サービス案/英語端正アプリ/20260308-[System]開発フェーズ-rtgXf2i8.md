# [System]開発フェーズ


ここでは **Accent Fit を実際にリリースするための個人開発ロードマップ**を、できるだけ現実的に整理します。  
あなたはモバイル開発経験（Swift / Kotlin）があるので、それを前提にしています。

ゴールはこれです。

```
8〜10週間でストア公開
```

***

# 1. 開発フェーズ全体

開発は **5フェーズ**に分けます。

```
```

***

# 2. フェーズ1（1週間）

## Product Design 固定

ここはほぼ完了していますが、最終確定します。

決めること

- MVP機能

- Promptセット

- 評価スコア

***

### MVP確定

機能

```
Prompt表示
録音
音声評価
Fit Score
Advice
履歴
```

画面

```
Home
Recording
Result
History
```

***

### Prompt準備

目標

```
70 prompts
```

内訳

```
Sentence 40
Drill 20
Talk 10
```

Google Sheetで管理。

***

# 3. フェーズ2（2〜3週間）

## Mobile Core App

ここはあなたの得意分野です。

***

### UI構築

SwiftUI

画面

```
Home
Recording
Result
History
```

***

### Recording

iOS

```
AVAudioRecorder
```

Android

```
MediaRecorder
```

***

### Audio保存

保存先

```
local storage
```

***

### SpeechSession保存

SQLiteまたは

```
Realm / CoreData
```

***

### Prompt取得

Firestore

```
GET prompts
```

***

# 4. フェーズ3（2週間）

## Speech Evaluation API

サーバーを作ります。

***

### 技術

```
Python
FastAPI
```

***

### エンドポイント

```
POST /speech/evaluations
```

***

### 処理

```
audio upload
↓
embedding
↓
score
↓
advice
```

***

### モデル

MVP

```
wav2vec2
Whisper
```

***

# 5. フェーズ4（1〜2週間）

## UX polish

ここがかなり重要です。

***

### Result UX

表示

```
Fit Score
Rhythm
Stress
Clarity
Advice
```

***

### Practice Loop

結果後

```
Practice Again
```

***

### Prompt Recommendation

弱点ベース

```
weakness detection
```

***

# 6. フェーズ5（1週間）

## Store release

***

### App Store assets

必要

```
icon
feature graphic
screenshots
description
```

あなたはすでに

```
icon
feature graphic
```

作っています。

***

### 説明文

例

```
Improve your English pronunciation in seconds.
```

***

### TestFlight

最初

```
10 users
```

***

# 7. MVPの技術構成

Mobile

```
SwiftUI
Kotlin
```

Backend

```
FastAPI
```

AI

```
wav2vec2
```

DB

```
Firestore
```

***

# 8. 開発規模

コード量

| 部分      | 行数    |
| ------- | ----- |
| Mobile  | 4k〜6k |
| Backend | 1k〜2k |

***

# 9. リリース後

リリースしたら次を追加します。

***

### Progress screen

```
weekly improvement
```

***

### Drill training

```
r/l
th
```

***

### AI coaching

```
personal feedback
```

***

# 10. 成功のKPI

最初に見る指標

```
sessions/day
```

目標

```
3 practice sessions/day
```

***

# まとめ

Accent Fit のリリースロードマップ

| Phase      | 内容             | 期間 |
| ---------- | -------------- | -- |
| Design     | Prompt / UX    | 1週 |
| Core App   | UI / recording | 3週 |
| Speech API | 評価エンジン         | 2週 |
| Polish     | UX改善           | 2週 |
| Release    | ストア            | 1週 |

合計

```
8〜10 weeks
```

***

もしよければ次に  
\*\*Accent Fit を個人開発でも「ヒットする可能性が高い構成」にするための機能（かなり重要）\*\*を整理できます。

これは実は

**プロダクト成功率をかなり左右する部分**です。
