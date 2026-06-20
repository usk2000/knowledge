# [System] MVP Screen Design

**Single Screen UX（1画面UX）で設計します。**

これはプロジェクトのコアUX

- **Instant start**

- **Immediate feedback**

- **Daily practice**

と完全に一致します。pasted

***

# Step 2

# MVP 画面設計

## 画面数

```
1 Screen
```

名前

```
Practice Screen
```

この1画面で

```
Prompt
Record
Score
Retry
```

すべて完結します。

***

# 画面構造

UIレイアウト

```
┌─────────────────────┐
 Accent Fit
 Today: 3 practices
─────────────────────
 Prompt

 I really like reading books.

─────────────────────
      🎤 Speak
─────────────────────
 Score: 72
─────────────────────
        Retry
└─────────────────────┘
```

***

# UIコンポーネント

## 1 Header

表示

```
Accent Fit
Today: 3 practices
```

目的

- 習慣化

- progress表示

***

## 2 Prompt

表示

```
I really like reading books.
```

条件

- 1文

- 10秒以内

***

## 3 Record Button

UI

```
🎤 Speak
```

状態

| State      | 表示           |
| ---------- | ------------ |
| Idle       | 🎤 Speak     |
| Recording  | 🔴 Recording |
| Processing | Analyzing... |

***

## 4 Score Display

録音後に表示

```
Score: 72
```

シンプル

MVPは

```
0〜100
```

のみ

***

## 5 Retry Button

```
Retry
```

押すと

```
Score → hidden
New prompt
```

***

# 状態マシン

Single Screen UXでは **状態管理が重要**です。

State

```
Idle
Recording
Processing
Result
```

遷移

```
Idle
 ↓ tap speak
Recording
 ↓ stop
Processing
 ↓ score returned
Result
 ↓ retry
Idle
```

***

# UXフロー

```
App open
 ↓
Prompt visible
 ↓
Tap Speak
 ↓
Speak (≤10s)
 ↓
Score appears
 ↓
Retry
```

**1 session ≈ 15秒**

***

# モバイル実装構造

SwiftUI / Android 共通思想

ViewModel state

```
PracticeState

prompt
isRecording
isProcessing
score
todayCount
```

***

# 画面で必要なAPI

## 1 Prompt取得

```
GET /prompt
```

Response

```
{
  "id": "prompt_123",
  "text": "I really like reading books."
}
```

***

## 2 Speech評価

```
POST /evaluate
```

Request

```
audio
promptId
```

Response

```
{
  "score": 72
}
```

***

## 3 Session保存

```
POST /session
```

```
promptId
score
duration
```

***

# MVP UIの重要ポイント

### 1 frictionを減らす

アプリ起動

```
→ 即prompt
```

ホーム画面なし

***

### 2 スピード

結果は

```
< 2秒
```

***

### 3 習慣化

表示

```
Today: 3 practices
```

***

# ここまでで決まったこと

### UX

```
Single screen
```

### Core Loop

```
Prompt → Speak → Score → Retry
```

### MVP UI

```
Practice Screen
```

***

# 次のステップ

次は **Step 3**

```
System Architecture
```

ここでは

```
Mobile
Backend
Speech AI
Firestore
```

を **実装レベルで設計**します。

具体的には

- 音声アップロード方法

- AI評価パイプライン

- Firestore構造

- API構造

を決めます。

***

進める前に1つだけ重要な質問があります。

**音声処理をどちらにしますか？**

### Option A（おすすめ）

```
Mobile → Backend → AI
```

理由

- iOS / Android共通

- AI変更しやすい

- Firestore保存しやすい

***

### Option B

```
Mobile → AI API
```

理由

- Backend不要

- 早い

デメリット

- 将来拡張困難

***

**AIプロダクトとしては A が圧倒的に良いです。**

選んでください。

```
A
Backend evaluation
```

or

```
B
Direct AI
```

情報源
