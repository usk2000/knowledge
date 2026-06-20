# [System] Core Architecture

# 2. ドメインの中心

Core Domain は **5つだけ**です。

### 1️⃣ Prompt

お題

例

```
Could you send me the report by Friday?
```

保存場所  
Firestore

***

### 2️⃣ SpeechSession

発話の結果

```
SpeechSession
- id
- dateTime
- promptId
- audioPath
- fitScore
- advice
```

保存場所  
ローカルDB

***

### 3️⃣ FitScore

評価

```
FitScore
- overall
- rhythm
- stress
- clarity
```

***

### 4️⃣ FitAdvice

改善ポイント

```
FitAdvice
- target
- message
```

***

### 5️⃣ UserProfile

```
goal
level
```

***

# 3. データ配置（重要）

### Firestore

```
prompts
```

理由

- 運用で変更する
- 新しいお題を追加

***

### ローカルDB

```
speech_sessions
audio
user_profile
```

理由

- プライバシー
- オフライン
- シンプル

# 4. アプリの構造（UI）

4タブ

```
HOME
PRACTICE
LOG
SETTINGS
```

***

### HOME

- Record
- Prompt

***

### PRACTICE

- Drills
- Fit Talk

***

### LOG

- 履歴
- スコア推移

***

### SETTINGS

- Profile
- Pro

***

# 5. データフロー（評価処理）

録音後

```
audio
 ↓
音声解析
 ↓
FitScore生成
 ↓
FitAdvice生成
 ↓
SpeechSession保存
```

***

# 6. この設計の強い点

### シンプル

ドメイン

```
5つ
```

***

### スケール可能

追加できるもの

- 新しいPrompt
- AI会話
- カリキュラム

***

### プライバシー強い

音声

```
端末のみ
```

***

# 7. この後の設計（次の重要ステップ）

ここまでが **プロダクト設計**です。  
ここから先は **エンジニアリング設計**になります。

次にやるべきはこの順番です。

### ① Core Domain モデル確定

エンティティ

```
Prompt
SpeechSession
FitScore
FitAdvice
UserProfile
```

***

### ② Repository設計

```
PromptRepository
SpeechSessionRepository
```

***

### ③ Speech評価API設計

```
evaluateSpeech()
```

***

### ④ クライアントState設計

あなたが使う

- SwiftUI
- Compose

向け。

***