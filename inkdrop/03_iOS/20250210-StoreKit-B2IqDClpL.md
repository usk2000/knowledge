# StoreKit


### RevenueCat
[SDK Quickstart – RevenueCat](https://www.revenuecat.com/docs/getting-started/quickstart)


[はじめてのRevenueCat - \(1\) SDK稼働確認に必要なApp Store Connectでの対応 #iOS - Qiita](https://qiita.com/maktag/items/072a137e73be49a7456f)

[はじめてのRevenueCat - (2) ダッシュボードでの設定と実装 #iOS - Qiita](https://qiita.com/maktag/items/12cb2e93a907d8229df0)


### StoreKit

[StoreKit 2によるiOSのアプリ内課金のチュートリアル](https://www.revenuecat.com/blog/engineering/ios-in-app-subscription-tutorial-with-storekit-2-and-swift-jp/)

[StoreKit Testing Improvements in iOS 14](https://www.revenuecat.com/blog/engineering/storekit-testing-in-xcode/)

`StoreKit Configuration`でテストか簡単になる


### 復元

https://chatgpt.com/g/g-p-6764fd42c430819184395898622948c8-sohutouea/c/67b2964d-2e50-800a-b2dd-73f345cff6ec

方法	適したケース
Transaction.latest(for:)	特定のアイテムの最新の購入状態をすぐに知りたいとき
Transaction.all	すべての購入履歴を取得して、複数のアイテムの状態をチェックしたいとき

### 状態の監視

Transaction.updatesで監視する