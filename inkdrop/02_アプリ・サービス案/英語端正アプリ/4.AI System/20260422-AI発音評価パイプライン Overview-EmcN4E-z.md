# AI発音評価パイプライン Overview


## 1. 全体構造（High-level）

```
Input
  ↓
Preprocess
  ↓
Feature Extraction
  ↓
Scoring
  ↓
Feedback Generation
  ↓
State Update
  ↓
Output
```

***

## 2. 各ステージの責務

### ① Input

**役割**

- 評価に必要な最小データを受け取る

**入力**

- 音声（ユーザ録音）
- テキスト（Prompt）
- IPA / phoneme情報（任意）

**ポイント**

- MVPでは「音声 + テキスト」で成立
- 将来は「単語分解・音素ラベル」を活用

***

### ② Preprocess

**役割**

- 音声を評価可能な形に整形

**処理**

- 無音除去（VAD）
- 正規化（音量）
- セグメント分割（必要なら）

**設計意図**

- モデル依存の前処理を分離することで  
  → Whisper / wav2vec2 切り替え容易

***

### ③ Feature Extraction

**役割**

- 音声を評価用の特徴量に変換

**MVP（A案）**

- Whisper → テキスト化 + timing

**将来（B案）**

- wav2vec2 → embedding / phoneme alignment

**出力例**

- transcript
- word timing
- phoneme候補
- embedding

**重要ポイント**

- 「テキスト一致」ではなく  
  **音の近さ（acoustic similarity）を扱う基盤**

***

### ④ Scoring

**役割**

- 発音の「Fit度」を数値化

**出力**

- 総合スコア（0–100）
- カテゴリ別スコア

```
Overall Score
 ├ Stress
 ├ Rhythm
 ├ Clarity
 ├ R/L
 └ TH
```

**設計方針**

- MVP：ルールベース + 軽い統計
- 将来：MLスコアリング or embedding距離

**ポイント**

- 「正誤」ではなく  
  → **ネイティブへの距離**

***

### ⑤ Feedback Generation

**役割**

- ユーザに返すフィードバック生成

**出力**

- スコア
- 一言アドバイス

**生成方法**

- ルールベース（優先）
- LLM（フォールバック）

**例**

- “Relax the ‘r’ sound.”
- “Reduce stress on the second word.”

**設計意図**

- MVPは**超短文・即行動**
- 説明ではなく「修正指示」

***

### ⑥ State Update

**役割**

- 学習状態の更新

**更新対象**

- SpeechSession（履歴）
- Pronunciation Map（弱点）

**MVP**

- ローカル保存のみ

**将来**

- ユーザプロファイル
- 長期トラッキング

***

### ⑦ Output

**最終出力**

```
{
  score: Int,
  categoryScores: {},
  advice: String,
  updatedPronunciationMap: optional
}
```

***

## 3. パイプラインの特徴（Accent Fit特有）

### ① 超短ループ設計

- 10秒以内で完結
- UX優先

***

### ② 非正誤評価

- ❌ correct / incorrect
- ⭕ fit / distance

***

### ③ 軽量フィードバック

- 1文
- 即実行可能

***

### ④ 分解可能な構造

- Whisper → wav2vec2 置換可能
- ルール → ML に進化可能

***

## 4. MVP構成（現実的な最小）

```
Audio
 ↓
Whisper（STT）
 ↓
簡易スコアリング（テキスト一致 + ルール）
 ↓
ルールベースアドバイス
 ↓
結果返却
```

***

## 5. 将来拡張（Core）

```
Audio
 ↓
wav2vec2 / alignment
 ↓
phonemeレベル評価
 ↓
カテゴリ別スコア
 ↓
LLMアドバイス補完
 ↓
Pronunciation Map更新
 ↓
推薦エンジン
```

***

## 6. この設計の狙い

- MVPを**最短で成立**
- そのまま**精度を段階的に上げられる**
- UX（10秒ループ）を壊さない

***