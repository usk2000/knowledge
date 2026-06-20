# [Product] Product Design Doc

# Accent Fit – AIプロダクト設計ドキュメント（LLM用）

## 0. このドキュメントの目的

このドキュメントは、Accent Fit の設計・実装・検討を ChatGPT / LLM と継続的に進めるための共通コンテキストである。
目的は以下。

* プロダクトの狙いを一貫して維持する
* MVP / Core / Expansion を段階的に切り分ける
* 実装対象と非対象を明確にする
* AI機能の設計論点を分解する
* 次のチャットでもスムーズに議論を再開できるようにする

---

## 1. プロダクト概要

### 1.1 プロダクト名

**Accent Fit**

### 1.2 コンセプト

**Speak Clearly, Naturally**

### 1.3 プロダクト定義

Accent Fit は、日本語話者向けの英語発音矯正アプリである。
1セッション約10秒の短時間トレーニングを中心に、発音を記録・評価・改善提案し、弱点を可視化して継続的に改善できる体験を提供する。

### 1.4 提供価値

* 短時間で続けやすい
* 発音改善にフォーカスしている
* 弱点を可視化できる
* 毎日の習慣に乗せやすい
* 日本語話者の典型的な弱点に特化できる

### 1.5 ターゲットユーザー

主対象は日本人社会人。

例:

* エンジニア
* ビジネスパーソン
* 英語会議がある人
* 学習時間を長く取れない人

特徴:

* 忙しい
* 1回の学習時間は短い方が良い
* 実践的な発音改善を求める
* 文法より「通じる発音」を優先したい

---

## 2. プロダクトの基本思想

### 2.1 最小学習ループ

**Prompt → Speak → Score → Improve**

### 2.2 UX原則

* Instant start
* Short loop
* Immediate feedback
* Daily habit

### 2.3 1セッション長

* 目安: 約10秒
* 長くても 20〜30秒以内
* 待ち時間を極力減らす

### 2.4 差別化

競合:

* ELSA Speak
* Speak
* Duolingo

Accent Fit の差別化:

* 発音特化
* 超短時間ループ
* 弱点可視化
* 日本語話者向け最適化

---

## 3. 機能一覧

## 3.1 MVP 機能

目的: 最短で学習ループを成立させる。

### MVPで含める機能

* Prompt表示
* 録音
* 音声アップロード
* 音声評価
* Fit Score 表示
* 短い Advice 表示
* Practice履歴
* 最低限の弱点カテゴリ集計

### MVP画面

* Practice
* Recording
* Result
* History

### MVPで明確にやらないこと

* 複雑な会話シミュレーション
* 自由会話評価
* 高度なランキング
* ソーシャル機能
* ゲーミフィケーションの作り込み
* 高度な長期学習プランナー

---

## 3.2 Core 機能

目的: Accent Fit のコア価値を成立させる。

### Coreで追加する機能

* Personal Pronunciation Map
* 弱点別の詳細分析
* Prompt推薦
* 弱点カテゴリの成長可視化
* 目標難易度に応じた出題制御
* 日本語話者向けルール強化
* Reference Audio 再生
* 履歴のフィルタ / 集計
* 評価結果の安定化ロジック

### Core画面/体験

* Result の詳細画面
* Pronunciation Map 画面
* Recommendations 画面
* Weakness detail 画面

---

## 3.3 Expansion 機能

目的: 継続率、精度、提供価値を広げる。

### Expansion候補

* AI生成Promptの本格運用
* UserProfileに基づく長期パーソナライズ
* シチュエーション別トレーニング
* 仕事 / 会議 / プレゼン向けパック
* Shadowingモード
* Minimal pairs drill
* 日次 / 週次レビュー
* 学習 streak
* 通知最適化
* Teacher / Coach風の説明生成
* 高品質 TTS 参照音声
* 複数アクセント対応
* CEFRや目的別コース
* A/Bテスト基盤
* Web管理画面
* Dataset運用管理UI

---

## 4. MVP / Core / Expansion の比較

| 項目       | MVP      | Core              | Expansion  |
| -------- | -------- | ----------------- | ---------- |
| 学習ループ    | あり       | 強化                | 高度化        |
| 発音評価     | 基本       | 詳細                | 高精度・多面的    |
| Advice   | 単純       | 弱点別               | 個別最適化      |
| 弱点可視化    | 最低限      | Pronunciation Map | 長期分析       |
| Prompt推薦 | なし or 簡易 | あり                | 高度パーソナライズ  |
| Dataset  | 固定CSV中心  | 管理強化              | 自動生成・運用高度化 |
| UX       | 最短導線     | 継続導線強化            | 習慣化・拡張体験   |

---

## 5. 実装対象

## 5.1 MVPの実装

### ユーザーストーリー

* ユーザーはPromptを1つ見る
* すぐ録音する
* 音声を送信する
* スコアと短いアドバイスを見る
* 練習履歴を確認する

### 実装対象

#### Mobile

* Practice画面
* Recording画面
* Result画面
* History画面
* 音声収録
* API連携
* ローカル保存

#### Backend

* 音声受信API
* 評価API
* Prompt配信API or Firestore読込
* SpeechSession保存

#### AI / Scoring

* 基本スコア算出
* カテゴリ別簡易評価
* Advice生成テンプレート

#### Data

* 100 prompts CSV
* Prompt metadata
* SpeechSession schema

### MVP完了条件

* 1日で複数回使える
* 録音→評価→結果表示が安定している
* 最低限の改善実感がある
* 手動QAで価値を確認できる

---

## 5.2 Coreの実装

### ユーザーストーリー

* ユーザーは自分の弱点を継続的に把握できる
* 自分に合うPromptが出る
* 何を改善すべきかがより明確になる

### 実装対象

* Pronunciation Map 計算
* Weaknessカテゴリ拡張
* Recommendation Engine
* Reference Audio
* Result詳細
* 時系列の成長可視化
* スコア平滑化
* Promptの難易度/ターゲット制御

### Core完了条件

* 弱点が継続的に可視化される
* 出題が個人に合っていると感じられる
* Resultに納得感がある
* 連続使用時に学習体験が単調にならない

---

## 5.3 Expansionの実装

### ユーザーストーリー

* ユーザーごとにより最適化された学習体験を得る
* 利用目的別の学習ができる
* アプリが継続利用しやすくなる

### 実装対象

* AI生成Promptパイプライン
* 長期成長モデル
* コース / パック管理
* ストリーク / リマインダー
* A/Bテスト
* 管理画面
* 高度な分析・配信

### Expansion完了条件

* パーソナライズがプロダクト価値として成立する
* 継続率改善に効く仕組みがある
* Dataset / Prompt運用が人力だけに依存しない

---

## 6. 実装タイムライン

## 6.1 全体ロードマップ

期間目安: **8〜10 weeks**

### Phase 1: Design

* 要件整理
* 画面整理
* データモデル定義
* Prompt schema 確定
* SpeechSession schema 確定
* 評価方針の初期設計

### Phase 2: Core App

* iOS / Android の基本画面
* 録音
* Prompt表示
* Result表示
* History保存

### Phase 3: Speech API

* 音声受信
* 評価処理
* スコア返却
* Advice生成
* Firestore保存

### Phase 4: UX Polish

* 導線改善
* 待ち時間改善
* Resultの理解しやすさ向上
* 初回体験最適化

### Phase 5: Store Release

* QA
* ベータ配布
* 軽微修正
* ストア公開準備

---

## 6.2 週次イメージ

### Week 1

* 機能定義
* 情報設計
* データ設計
* 画面ラフ

### Week 2

* Mobile基盤
* 録音処理
* Prompt表示
* ローカルモデル仮実装

### Week 3

* Backend API立ち上げ
* 音声アップロード
* Result連携

### Week 4

* スコア返却
* Advice返却
* 履歴保存

### Week 5

* MVP一貫導線完成
* QA
* 失敗ケース処理

### Week 6

* Pronunciation Map の初期版
* 弱点カテゴリ追加

### Week 7

* Recommendation Engine 初期版
* Prompt制御改善

### Week 8

* UX polish
* βテスト準備

### Week 9-10

* 改善対応
* Store release準備

---

## 7. System Architecture

## 7.1 全体構成

### Mobile

* iOS: SwiftUI
* Android: Kotlin

### Backend

* Python
* FastAPI

### AI処理

* Whisper
* wav2vec2
* 追加のスコアリングロジック

### Storage

* Firestore
* Local storage
* audio files

---

## 7.2 論理構成

### Mobile層

* Presentation
* Application / UseCase
* Domain
* Infra

### Backend層

* API layer
* Evaluation service
* Prompt service
* Recommendation service
* Persistence layer

---

## 7.3 主要エンティティ

### Prompt

* id
* text
* type
* difficulty
* tags
* targets

### SpeechSession

* id
* userId
* promptId
* audioPath / audioUrl
* transcript
* overallScore
* categoryScores
* phonemeScores
* advice
* createdAt

### UserProfile

* id
* languageBackground
* practiceHistorySummary
* weaknessProfile
* targetDifficulty
* preferences

---

## 7.4 基本シーケンス

1. Mobile が Prompt を取得
2. User が録音
3. Audio を Backend に送信
4. Backend が音声前処理
5. Evaluation Pipeline がスコア計算
6. Advice / category scores を生成
7. SpeechSession を保存
8. Mobile に結果返却
9. Mobile が履歴と結果を表示

---

## 8. Dataset Design

## 8.1 Prompt Dataset

現在の最小フォーマット:

* id
* text
* type
* difficulty
* tags
* targets

CSV例:

```csv
id,text,type,difficulty,tags,targets
p001,I really like this red room.,sentence,1,rl;stress,R;L;stress
```

## 8.2 Prompt type

* sentence
* drill
* talk

想定拡張:

* minimal_pair
* shadowing
* phrase
* meeting
* presentation

## 8.3 targets 設計

例:

* R
* L
* TH
* stress
* rhythm
* clarity
* vowel_length
* consonant_cluster

## 8.4 Prompt quality 要件

* 短い
* 発音練習の意図が明確
* 難易度が段階化されている
* ターゲット音素 / リズムが明確
* 初学者でも理解しやすい

## 8.5 Reference Audio Dataset

将来の重要データセット:

* promptId
* accentType
* speakerType
* audioUrl
* transcript
* speedTag
* qualityScore

用途:

* お手本再生
* 比較評価
* shadowing

---

## 9. Evaluation Pipeline

## 9.1 目的

ユーザー音声を入力し、以下を出力する。

* overall pronunciation score
* category scores
* phoneme or target scores
* short advice
* future pronunciation map input

## 9.2 入力

* recorded audio
* prompt text
* prompt targets
* optional user history

## 9.3 出力

* overallScore
* categoryScores
* targetScores
* transcript / alignment info
* advice
* confidence

## 9.4 評価の段階

### Step 1: Audio validation

* 長さ確認
* 無音率確認
* 音量確認
* ノイズ過多確認

### Step 2: Speech recognition / transcription

* Whisper等で文字起こし
* 発話内容の乖離確認

### Step 3: Alignment / target analysis

* Prompt text と音声を比較
* 対象音素やストレス位置を分析

### Step 4: Category scoring

カテゴリ例:

* Stress
* Rhythm
* Clarity
* R/L
* TH
* Vowels

### Step 5: Overall scoring

* カテゴリ重み付け
* Prompt targets を反映
* 極端なスコアを補正

### Step 6: Advice generation

* ルールベース / テンプレート中心
* 将来的にLLM補助

## 9.5 MVP版の割り切り

MVPでは完璧な音素レベル評価を目指さない。
まずは「ユーザーが改善方向を理解できる」ことを優先する。

---

## 10. Pronunciation Map

## 10.1 目的

ユーザーの発音の弱点を継続的に可視化する。

## 10.2 役割

* 学習継続の動機付け
* 次に練習すべき対象の特定
* Recommendation Engine の入力

## 10.3 表示例

* Stress: 72
* Rhythm: 80
* Clarity: 85
* R sound: 60
* TH sound: 55

## 10.4 データソース

* SpeechSession の蓄積
* categoryScores
* targetScores
* 時系列の改善傾向

## 10.5 初期実装案

* 最近N件の加重平均
* 新しい記録に高い重み
* 低信頼データは重みを下げる
* カテゴリ別に 0〜100 で保持

## 10.6 将来拡張

* difficulty補正
* prompt bias補正
* confidenceによる平滑化
* 学習進捗の可視化
* 短期指標 / 長期指標の分離

---

## 11. Recommendation Engine

## 11.1 目的

ユーザーに次に出すPromptを最適化する。

## 11.2 入力

* UserProfile
* SpeechSession history
* Pronunciation Map
* Prompt metadata

## 11.3 MVPアルゴリズム

* difficulty filter
* weakness focus
* diversity control

## 11.4 具体ルール例

* 現在難易度に合うPromptのみ候補にする
* 弱点 target を含むPromptを優先する
* 同じPromptの連続出題を避ける
* 同じtagsばかりに偏らないようにする

## 11.5 将来拡張

* 学習効率ベース最適化
* multi-armed bandit
* session目的別推薦
* 時間帯 / 継続率考慮
* 失敗しすぎ / 易しすぎ補正

---

## 12. Prompt Generation

## 12.1 目的

日本語話者向け発音練習Promptを継続的に供給する。

## 12.2 生成方法

* Template generation
* LLM generation
* Human review

## 12.3 MVP運用

* 手動作成 + CSV管理中心
* 少量LLM補助
* 人手レビュー必須

## 12.4 LLM生成の観点

* 対象音素 / ストレス意図が明確
* 文の長さが短い
* 語彙が過剰に難しくない
* 不自然な英文を避ける
* type, difficulty, tags, targets を付与

## 12.5 推奨ワークフロー

1. ターゲットを決める
2. LLMで候補生成
3. 自動ルールで弾く
4. 人手レビュー
5. CSV / DB に登録

---

## 13. 日本語話者向け設計の重点

## 13.1 初期重点領域

* R / L
* TH
* Stress
* Rhythm

## 13.2 なぜ重要か

これらは日本語話者の発音課題として頻出であり、短時間学習でも改善価値が伝わりやすい。

## 13.3 プロダクト上の反映

* Prompt targets に入れる
* Adviceテンプレートを用意する
* Pronunciation Map の上位カテゴリに含める
* Recommendation Engine で優先制御する

---

## 14. 成功指標

## 14.1 MVP指標

* 1セッション完了率
* 録音成功率
* 評価成功率
* 結果画面到達率
* 3日継続率
* 初回利用満足度

## 14.2 Core指標

* 7日継続率
* 再訪率
* Pronunciation Map閲覧率
* 推薦Prompt消化率
* ユーザー主観の改善実感

## 14.3 Expansion指標

* 30日継続率
* 課金転換率
* 学習時間あたり改善効率
* コース継続率

---

## 15. リスクと設計上の注意

## 15.1 主なリスク

* スコアの納得感が低い
* Adviceが抽象的すぎる
* 待ち時間が長い
* Promptが単調
* 音声品質差に引っ張られる

## 15.2 対応方針

* MVPでは説明可能性を優先
* スコアだけでなく理由も返す
* 低品質音声は再録音を促す
* Recommendationで単調さを抑制
* 高精度化はCore以降に段階導入

---

## 16. 次に深掘るべきテーマ

優先順:

1. Reference Audio dataset
2. Speech evaluation algorithm
3. Pronunciation Map implementation
4. Recommendation algorithm
5. Prompt generation pipeline

---

## 17. 次チャット用ショートコンテキスト

```text
Project: Accent Fit
Accent Fit is a pronunciation training app for Japanese learners of English.
Concept: 10-second pronunciation training.
Loop: Prompt → Speak → Score → Improve.
Core value: short daily practice + weakness visualization.
Key feature: Personal Pronunciation Map.
Main targets: R/L, TH, stress, rhythm.
Tech: iOS SwiftUI, Android Kotlin, backend Python FastAPI.
Speech AI: Whisper / wav2vec2.
Prompt dataset: CSV with id, text, type, difficulty, tags, targets.
```

---

## 18. LLMへの依頼テンプレート

### 18.1 アルゴリズム設計

```text
Context:
[paste short context]

Topic:
Speech evaluation algorithm

Task:
Design the scoring pipeline for Accent Fit MVP and Core.
Output format:
- architecture
- algorithm steps
- input/output schema
- tradeoffs
```

### 18.2 データ設計

```text
Context:
[paste short context]

Topic:
Prompt dataset design

Task:
Design CSV/Firestore schema for prompts, sessions, and pronunciation map.
```

### 18.3 実装計画

```text
Context:
[paste short context]

Topic:
Implementation roadmap

Task:
Break MVP into weekly milestones for iOS, Android, backend, and AI.
```
