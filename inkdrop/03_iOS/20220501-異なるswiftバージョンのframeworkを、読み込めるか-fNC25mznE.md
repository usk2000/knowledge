# 異なるswiftバージョンのframeworkを、読み込めるか

試す
おそらく古いxcframeworkを使う分は大丈夫。
binaryTargetはできるのか。

* [ ] ReactSwift使ってみる
* [ ] SPMでswiftバージョンは指定できるのか

SPM

[SPMでbinary framework dependency](inkdrop://note/CQOq5yPot)


バージョン違いでエラーが発生している
[marketing cloud - MarketingCloudSDK SPM Module not supported by newer compilers - Salesforce Stack Exchange](https://salesforce.stackexchange.com/questions/366593/marketingcloudsdk-spm-module-not-supported-by-newer-compilers)

[SPM this sdk is not supported by the compiler - Google 検索](https://www.google.com/search?client=safari&rls=en&q=SPM+this+sdk+is+not+supported+by+the+compiler&ie=UTF-8&oe=UTF-8)

RxSwiftをCarthageでダウンロードしてきて、SPMに移動する。