# StoreKit / IAP トラブル対応ログ

## 🧠 Short Context
- `Product.products(for:)` で商品取得できなかった
- `.storekit` 有無どちらでも失敗
- 原因は **App Store Connect 側の状態不備 + Agreement未締結**

---

## 📌 Decision Log

### D1. `.storekit` ではなく App Store Connect を優先して確認
- 理由：TestFlight / 実機は `.storekit` を使わないため

---

### D2. Paid Applications Agreement を締結
- 状態：未締結 → 締結
- 結果：反映後、商品取得可能になった

---

### D3. サブスク / IAP のステータスを修正
- Before:
  - `Developer Action Needed`
  - `Rejected`
- After:
  - `Waiting for Review`
- 結果：取得可能になった

---

### D4. 反映待ちを許容（約30分）
- 即時反映されない前提で運用

---

### D5. `.storekit` Sync 再実行
- 結果：正常に商品取得できるようになった

---

## 🔍 Root Cause

### Primary
- Paid Applications Agreement 未締結

### Secondary
- IAP / サブスクのステータス不備
  - Developer Action Needed
  - Rejected

### Tertiary
- App Store Connect の反映遅延

---

## ✅ 再発防止チェックリスト

### App Store Connect

- [ ] Paid Applications Agreement が有効
- [ ] IAP / サブスクのステータスが正常
  - 最低でも `Waiting for Review`
- [ ] Product ID がコードと一致
- [ ] 価格設定済み
- [ ] ローカライズ済み
- [ ] サブスクグループ設定済み

---

### Xcode / StoreKit

- [ ] `.storekit` は Dev Scheme のみ設定
- [ ] 本番 / Archive Scheme では未設定
- [ ] `.storekit` Sync 成功している

---

### 実行環境

- [ ] 反映待ち（30分〜）
- [ ] アプリ再起動
- [ ] 必要なら端末 / Simulator リセット

---

## 🧪 Troubleshooting Guide

### Case 1: 商品が1つも取得できない

```swift
let products = try await Product.products(for: ids)