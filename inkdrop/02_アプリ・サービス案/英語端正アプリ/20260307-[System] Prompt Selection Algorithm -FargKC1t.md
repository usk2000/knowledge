# [System] Prompt Selection Algorithm 

ここは実は **学習体験・継続率を大きく左右する部分**です。

設計目標はこの3つです。

- ユーザーに **ちょうど良い難易度**を出す

- **弱点を自然に補強**する

- 同じお題ばかりにならない

***

# 1. Prompt Selection の役割

アプリの流れの中ではここです。

```
Home
 ↓
Prompt selection
 ↓
Record
 ↓
Fit Score
 ↓
Advice
```

つまり **Home画面で提示するお題を決めるロジック**です。

***

# 2. 入力データ

Prompt selection は次の情報を使います。

### 1️⃣ UserProfile

```
goal
level
```

例

```
goal = business
level = 2
```

***

### 2️⃣ 最近のSpeechSession

直近10〜20セッション

```
FitScore
AdviceTarget
PromptId
```

***

### 3️⃣ Prompt metadata

Firestoreにある

```
difficulty
tags
targets
```

***

# 3. Selection Strategy（基本）

まず **シンプルな3段階**で決めます。

```
1. difficulty filter
2. weakness focus
3. diversity control
```

***

# 4. Step1 Difficulty Filter

ユーザーのレベルで候補を絞る

```
level = 1 → difficulty 1
level = 2 → difficulty 1-2
level = 3 → difficulty 2-3
```

Firestore query

```
where difficulty <= level
```

***

# 5. Step2 Weakness Focus

直近のSpeechSessionから弱点を推定

例

```
stress average = 68
rhythm average = 80
clarity average = 82
```

→ weakest = **stress**

***

弱点に対応するタグ

```
goal:stress
prosody:stress
```

これを優先します。

***

# 6. Step3 Diversity Control

同じお題ばかりを避ける

例

```
直近5回のpromptId
```

を除外

Firestore filter

```
promptId NOT IN lastPrompts
```

***

# 7. 最終スコアリング

候補Promptに対してスコアをつけます。

```
score =
weakness_match
+ difficulty_match
+ diversity_bonus
```

***

例

| Prompt | weakness | difficulty | diversity | total |
| ------ | -------- | ---------- | --------- | ----- |
| A      | 1.0      | 0.9        | 0.7       | 2.6   |
| B      | 0.3      | 1.0        | 0.8       | 2.1   |

→ A を選択

***

# 8. 実装レベルの疑似コード

```
def select_prompt(user_profile, sessions, prompts):

    weakness = detect_weakness(sessions)

    candidates = filter_difficulty(
        prompts,
        user_profile.level
    )

    candidates = exclude_recent(
        candidates,
        sessions
    )

    scored = []

    for prompt in candidates:

        score = 0

        if weakness in prompt.targets:
            score += 1.0

        if prompt.difficulty <= user_profile.level:
            score += 0.5

        score += random.uniform(0, 0.3)

        scored.append((prompt, score))

    return max(scored, key=lambda x: x[1])[0]
```

***

# 9. MVP版（超シンプル）

MVPならこれでも十分です。

```
1. difficulty filter
2. weakness tag match
3. random
```

***

# 10. Talk / Drill との関係

モードごとに selection を変えます。

### Sentence

```
weakness based
```

***

### Drill

```
phoneme weakness
```

例

```
/r/ 弱い
→ r/l drill
```

***

### Talk

```
topic based
```

例

```
goal = business
→ work topic
```

***

# 11. キャッシュ戦略

Prompt selection は

**毎回Firestore queryすると遅い**ので

アプリ起動時に

```
prompts cache
```

を持つと良いです。

***

# 12. Prompt cache

```
App start
 ↓
GET /prompts
 ↓
memory cache
```

更新

```
1 day TTL
```

***

# 13. 将来の高度化

MVPの次に来る進化はここです。

***

### ML推薦

```
Prompt embedding
```

ユーザー履歴

```
Speech embedding
```

類似度で推薦

***

### Bandit algorithm

探索と最適化

```
explore
exploit
```

***

# 14. Selection API（任意）

Prompt selection を **サーバー側に置くか**という話があります。

MVPは

```
クライアント側
```

で十分です。

理由

- Prompt数が少ない

- ロジックが軽い

- レイテンシー無し

***

# 15. 最終構造

Accent Fit の Prompt selection は

```
UserProfile
+
SpeechSession history
+
Prompt metadata
```

から

```
next prompt
```

を決定します。

***

# 16. ここまでで完成したもの

あなたのアプリはこれで **完全な設計**になっています。

完成した設計

- Product design

- Prompt schema

- Speech evaluation API

- Mobile architecture

- Server architecture

- Prompt selection algorithm

***