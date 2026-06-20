# MVPプロダクト設計


## UX原則

### ① One Screen

- 画面遷移なし（単一画面）

### ② One Action

- 常に操作は1つ

### ③ One Feedback

- Score 1つ
- Advice 1つ

### ④ No Decision

- 選択させない

### ⑤ Loop First

- 改善ループを最優先

***

# 3. Fit Score設計

## 定義

Fit = ネイティブ発音との距離

内訳（将来）：

- Phoneme（音）
- Stress（強勢）
- Rhythm（リズム）
- Fluency（自然さ）

***

## MVP仕様

- 総合スコアのみ表示
- 内訳は非表示

***

## 将来方針

👉 段階的開示

- MVP：Scoreのみ
- Core：弱点1つ表示
- Expansion：Pronunciation Map

***

## UX原則

👉 **Action First / Insight Later**

***

# 4. フィードバック設計

## Score

- 数値のみ（即表示）
- アニメーションなし（MVP）

***

## Advice

- 音素レベル
- 1つのみ提示

例：

```
Pull your tongue back for /r/
```

***

## 音声補助

- 任意再生（タップ）
- 自動再生なし

***

# 5. Prompt設計

## MVP

- 完全ランダム
- 短文（最大10秒）

***

## UX意図

- 選択排除
- 即開始

***

# 6. Recording設計

## 仕様

- 自動停止（基本）
- 手動停止（補助）

***

## UX意図

- 操作削減
- 安心感の担保

***

# 7. 分岐設計（重要）

## Retry vs Next

### 方針

👉 Retryを主導  
👉 Nextは副導線

***

## UI設計

```
[Retry]

Skip →
```

***

## 意図

- 改善ループを優先
- 離脱も可能

***

# 8. 状態設計（State Machine）

## 5状態のみ

### ① Idle

- Prompt表示
- Record開始

***

### ② Recording

- 録音中
- 自動 or 手動停止

***

### ③ Processing

- 短時間ローディング

***

### ④ Result

- Score
- Advice
- Retry / Skip

***

### ⑤ Loop

- Retryで再録音
- Skipで次Prompt

***

# 9. UI構造

```
[Top]
Prompt

[Center]
状態表示（録音 / スコア）

[Bottom]
Primaryボタン（1つのみ）
```

***

## ボタン状態

| 状態        | ボタン    |
| --------- | ------ |
| Idle      | Record |
| Recording | Stop   |
| Result    | Retry  |

***

# 10. 意図的にやらないこと（MVP）

- スコア内訳表示
- 履歴 / グラフ
- Prompt選択
- 設定画面
- チュートリアル

***

# 11. UXの核心指標

- 1セッション内ループ回数
- Retry率
- 平均セッション時間

***

# 12. UXの本質まとめ

```
Fast
Simple
Repeatable
```

***