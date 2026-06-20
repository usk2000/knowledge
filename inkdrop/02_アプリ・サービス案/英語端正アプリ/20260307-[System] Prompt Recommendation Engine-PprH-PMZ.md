# [System] Prompt Recommendation Engine

では \*\*Accent Fit の Prompt Recommendation Engine（お題推薦エンジン）\*\*を設計します。  
これは **ユーザーが次にやるべきお題を決めるロジック**で、**継続率と学習効率に直結する重要部分**です。

ここでは次を整理します。

- 推薦の目的

- 入力データ

- MVPアルゴリズム

- 実装構造（モバイル側）

- 将来の高度化

***

# 1. Prompt Recommendation の目的

推薦のゴールは次の3つです。

### 1️⃣ 弱点を改善する

例

```
stress score が低い
```

↓

```
goal:stress の prompt
```

***

### 2️⃣ 難易度を合わせる

ユーザーが

```
簡単すぎ
or
難しすぎ
```

にならない。

***

### 3️⃣ 同じお題の連続を避ける

継続性を維持。

***

# 2. 推薦の入力データ

推薦エンジンは次を使います。

## UserProfile

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

## SpeechSession history

直近

```
10〜20 sessions
```

例

```
fitScore
adviceTarget
promptId
```

***

## Prompt metadata

Firestoreの

```
difficulty
tags
targets
```

***

# 3. MVP推薦アルゴリズム

MVPでは **シンプルな3段階**で十分です。

```
1 difficulty filter
2 weakness focus
3 diversity random
```

***

# 4. Step1 Difficulty Filter

ユーザーレベルで絞ります。

```
level 1 → difficulty 1
level 2 → difficulty 1-2
level 3 → difficulty 2-3
```

***

# 5. Step2 Weakness Detection

直近のFitScoreから

```
平均
```

を計算。

例

```
Rhythm 80
Stress 65
Clarity 82
```

↓

```
weakest = stress
```

***

# 6. Weakness Tag Match

弱点タグ

```
prosody:stress
goal:stress
```

を持つPromptを優先。

***

# 7. Step3 Diversity

直近のお題を避ける。

```
lastPromptIds
```

を除外。

例

```
last 5 prompts
```

***

# 8. 最終スコアリング

候補Promptにスコアを付けます。

例

```
score =
weakness match
+ difficulty match
+ random
```

***

例

| Prompt | weakness | difficulty | random | total |
| ------ | -------- | ---------- | ------ | ----- |
| A      | 1.0      | 0.7        | 0.2    | 1.9   |
| B      | 0.5      | 0.8        | 0.3    | 1.6   |

→ Aを採用

***

# 9. 疑似コード

```
def recommend_prompt(user, sessions, prompts):

    weakness = detect_weakness(sessions)

    candidates = [
        p for p in prompts
        if p.difficulty <= user.level
    ]

    candidates = exclude_recent(
        candidates,
        sessions
    )

    best = None
    best_score = -1

    for p in candidates:

        score = 0

        if weakness in p.targets:
            score += 1.0

        if p.difficulty <= user.level:
            score += 0.5

        score += random.random() * 0.3

        if score > best_score:
            best = p
            best_score = score

    return best
```

***

# 10. モバイル側実装

推薦は **モバイル側で実行可能**です。

理由

- Prompt数が少ない

- ロジック軽い

- API不要

***

# 推薦構造

```
PromptRepository
SpeechSessionRepository
UserProfileRepository
```

↓

```
PromptRecommendationService
```

***

# Swift例

```
struct PromptRecommendationService {

    func recommend(
        prompts: [Prompt],
        sessions: [SpeechSession],
        profile: UserProfile
    ) -> Prompt {

        let weakness = detectWeakness(sessions)

        let candidates = prompts.filter {
            $0.difficulty <= profile.level
        }

        let recent = Set(sessions.prefix(5).map { $0.promptId })

        let filtered = candidates.filter {
            !recent.contains($0.id)
        }

        return filtered.max { a, b in
            score(a, weakness) < score(b, weakness)
        }!
    }
}
```

***

# 11. Recommendation のUX

Home画面では

```
Today's practice
```

として提示。

***

例

```
Today's focus: Stress
```

↓

```
Could you send the report by Friday?
```

***

# 12. Drill Recommendation

Drillは

```
phoneme weakness
```

から決めます。

例

```
/r/ score low
```

↓

```
r/l drill
```

***

# 13. Talk Recommendation

Talkは

```
topic + goal
```

で選びます。

例

```
goal = business
```

↓

```
topic:meeting
```

***

# 14. Prompt rotation

Prompt数が少ない場合

```
round robin
```

でもOK。

***

# 15. キャッシュ

Promptは

```
App launch
↓
fetch prompts
↓
memory cache
```

***

更新

```
24h TTL
```

***

# 16. 将来の進化

MVPの次はここです。

***

## ML推薦

```
prompt embeddings
```

と

```
user history embeddings
```

の類似度。

***

## Bandit algorithm

```
explore
exploit
```

***

## Personalized curriculum

```
weekly training plan
```

***

# 17. 最終構造

Prompt推薦は

```
UserProfile
+
SpeechSession history
+
Prompt metadata
```

から

```
Next Prompt
```

を決定します。

***

# まとめ

Accent Fit の推薦エンジンは

```
difficulty filter
+
weakness focus
+
diversity control
```

のシンプルなアルゴリズムで **MVPから十分成立**します。

***

もしよければ次に  
\*\*このアプリの「最初のリリースで必要な全コンポーネント（完全なシステム構成図）」\*\*を整理できます。

これは

- モバイル

- API

- 音声評価

- Firestore

- DB

全部を **1枚のアーキテクチャ図**にまとめたものです。