# Android課金テスト仕様メモ

## 結論

Android の Google Play Billing は、**PC から直接インストールしたアプリでは安定してテストできないことがある**。  
今回の確認では、Billing 接続自体は成功しているが、ProductDetails が空で返ってきた。

そのため、**課金テストは internal test に配布し、Play Store 経由でインストールして確認するのが推奨**。

***

## 今回確認できたこと

### 取得処理

Android 版では以下のタイミングで Play Store から課金情報を取得している。

- queryPurchases(IN\_APP / SUBS)
  - 購入済み情報の取得
- getProducts(IN\_APP / SUBS)
  - 商品詳細情報の取得

### ログ結果

起動時ログでは以下が確認できた。

- BillingClient への接続は成功
- 商品IDの問い合わせは実行されている
- しかし details= が空

例:

`getProducts start type=IN_APP productIds=[course001, course002, course003, course004, course005, course006, course007, course-bulk] getProducts success type=IN_APP details= getProducts start type=SUBS productIds=[lab-standard] getProducts success type=SUBS details=`

### 解釈

これは以下を意味する。

- Play Billing API には接続できている
- アプリ側の product ID 送信もできている
- ただし Play Store 側が商品情報を返していない

***

## product ID

### IN\_APP

- course001
- course002
- course003
- course004
- course005
- course006
- course007
- course-bulk

### SUBS

- lab-standard

***

## 直接インストール時の扱い

### 原則

**直接インストールだけでは、課金テストが正常に動かないことがある。**

### 補足

Google 公式では、License tester に登録したアカウントであれば、sideload / debug build でもテストできるケースがある。  
ただし実際には、以下条件が揃わないと商品情報取得が失敗することがある。

- package name が Play Console 上のアプリと一致している
- 端末の Play Store アカウントがテスター登録済み
- Play 側の反映が完了している
- 商品が Play Console 上で公開済み / 有効

### 今回の判断

今回のように details= が空のままなら、**直接インストールでの確認は信頼せず、Play Store 経由に切り替えるべき**。

***

## 推奨テスト方法

## 1. License tester に登録

Play Console で対象の Google アカウントを License testing に追加する。

手順:

1. Play Console を開く
2. Settings
3. License testing
4. テスト用 Google アカウントを追加
5. 保存

***

## 2. internal test を設定

Play Console で internal test を作成し、対象アカウントをテスターに追加する。

手順:

1. Testing
2. Internal testing
3. Testers タブ
4. テスター用 Google アカウントを追加
5. AAB をアップロードして release を作成
6. 配布を開始

***

## 3. opt-in する

internal test 配布後、Play Console に表示される **opt-in URL** を使ってテスター参加する。

手順:

1. Play Console で internal test の opt-in URL を取得
2. Android 端末でその URL を開く
3. テスター参加を承認する

注意:

- 端末で使っている Google アカウントが、登録したテスターアカウントと一致している必要がある

***

## 4. Play Store からアプリを入れ直す

### 重要

**PC から直接入れたアプリはアンインストールして、Play Store 経由で入れ直す。**

理由:

- Play Billing のテストでは、Play Store 配布版であることが重要
- internal test に参加していても、直接インストール版だと期待どおりに商品情報が返らないことがある

***

## 5. ログ確認

Play Store から入れた後、以下のログを確認する。

### 商品取得開始

`getProducts start type=IN_APP productIds=[...] getProducts start type=SUBS productIds=[...]`

### 商品取得結果

`getProducts success type=IN_APP details=... getProducts success type=SUBS details=...`

### 正常時に期待する状態

- details= が空ではなく、商品情報が出る
- 価格やタイトルが取得できる
- 購入フローでテスト決済手段が表示される

***

## 切り分けポイント

### queryPurchases は成功するが getProducts が空

疑う点:

- internal test 未参加
- Play Store 経由でインストールしていない
- テスターアカウント不一致
- product ID 未公開 / 非アクティブ
- Play 側反映待ち

### 端末に複数 Google アカウントがある

注意:

- Play Store / 購入に使われるアカウントが、想定アカウントと異なる場合がある

***

## 実務上の結論

Android 課金の確認は、以下を標準手順にする。

1. License tester 登録
2. internal test 配布
3. opt-in
4. **Play Store からインストール**
5. Logcat で getProducts / queryPurchases を確認
6. テスト購入で動作確認

***

## 参考

- [Test your Google Play Billing Library integration](https://developer.android.com/google/play/billing/test)
- [Test in-app billing with application licensing](https://support.google.com/googleplay/android-developer/answer/6062777?hl=en)
- [Set up an open, closed, or internal test](https://support.google.com/googleplay/android-developer/answer/9845334?hl=en)
