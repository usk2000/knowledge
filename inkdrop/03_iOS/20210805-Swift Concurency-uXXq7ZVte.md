# Swift Concurency

https://speakerdeck.com/shiz/the-first-step-of-swift-concurrency?slide=3
https://zenn.dev/akkyie/articles/swift-concurrency
https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html

debounce
https://developer.apple.com/documentation/combine/fail/debounce(for:scheduler:options:)

https://developer.apple.com/documentation/swift/task

`@MainActor`をつける

AsyncImage
https://developer.apple.com/documentation/swiftui/asyncimage

Taskの中のエラー処理、上手くできないかな。

## actorについて
https://zenn.dev/akkyie/articles/swift-concurrency#mainactor
https://dev.classmethod.jp/articles/try-async-await-actor-in-swift/

> 今回はmessageというプロパティをUIで参照します。UIで参照するときは、メインスレッドでアクセスする必要があります。
そのためにMainActorの宣言をしました。

- `ObservableObject`に`@MainActor`を使った方が良い。
- ViewModel(ObservableObject)に処理をまとめ、View側にはロジックを入れない？
- ApiClientには`actor`をつけたほうが良いか→変化する変数がないから別に良いかな。

actorを使ったサンプルを作ってみる。
sleepとかを使う。スレッドをランダムでクリエイト
一時ソース
https://developer.apple.com/videos/play/wwdc2021/10133/
