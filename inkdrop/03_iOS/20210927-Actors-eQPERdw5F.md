# Actors

アウトプット
https://zenn.dev/usk2000/articles/e8a8b42b7d1536

[Swift.org](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html#ID645)
[Protect mutable state with Swift actors](https://developer.apple.com/videos/play/wwdc2021/10133/)
[Actors](https://github.com/apple/swift-evolution/blob/main/proposals/0306-actors.md)

https://qiita.com/koher/items/8b162940991a8bbff5f2


swiftではlet(値の意味論の型,value-semantic types)を推奨する
[Value-Semantics](inkdrop://note/QHQRxktK7)
https://github.com/apple/swift/blob/main/docs/proposals/ValueSemantics.rst

[並行処理と並列処理](https://zenn.dev/hsaki/books/golang-concurrency/viewer/term)
→定義を確認した方が良いかも

# データ競合
- データ競合の回避
- ２つのスレッドからアクセス（１つ以上の書き込みを含む）することで起きます
- 

# 現状の問題
## classの場合
`class`は参照型です。
https://qiita.com/koher/items/bcdbf6578b6edd1f9e0c

```swift
class Counter {
  var value = 0
  func increment() -> Int {
    value = value + 1
    return value
  }
}

let counter = Counter()
Task.detached {
  print(counter.increment()) //2
}

Task.detached {
  print(counter.increment()) //2
}

```

タスクが順番に呼ばれることは非確定なので、[1,1], [1,2], [2,1], [2,2]が表示される可能性がある

## structの場合
`struct`は値型です。
```swift
struct Counter {
  var value = 0
  mutating func increment() -> Int {
    value = value + 1
    return value
  }
}

let counter = Counter()
Task.detached {
  print(counter.increment()) //2  
}

Task.detached {
  print(counter.increment()) //2
}

```
コンパイラがエラーを出す。

```swift
var counter = Counter()

Task.detached {            
  print(counter.increment()) //1        
}
          
Task.detached {            
  print(counter.increment()) //2        
}
```
競合状態が残ってしまうが、コンパイラがエラーを出す。

```
Mutation of captured var 'counter' in concurrently-executing code
```



detachedについてはこちら
[Task.detached](inkdrop://note/O2gxN0RQm)

## actor
- 並列アクセスをしないようになる
- クラスと同じ参照型

※手動でロック・アンロックしなくても良い

```swift
actor Counter {
  var value = 0
  func increment() -> Int {
    value = value + 1
    return value
  }
}

let counter = Counter()
Task.detached {
  print(await counter.increment()) //1
}

Task.detached {
  print(await counter.increment()) //2
}
```

結果は[1,2], [2,1]のどちらか

## actor reentrancy

再入可能性

- 時間のかかる処理（画像ダウンロードなど）でキャッシュの上書きが発生する

```swift
actor ImageDownloader {
  private var cache: [URL: Image] = [:]
  
  func image(from url: URL) async throws -> Image? {
    if let cached = cache[url] {
      return cached
    }
    
    let image = try await downloadImage(from: url)
    
    cache[url] = image
    return image
    
  }
}
```

- ①ダウンロードをリクエスト（サーバの画像は１）
- ②ダウンロードをリクエスト（サーバの画像は２）
- ①ダウンロードが完了（画像は１）
- ②ダウンロードが完了（画像は２）

データの競合は起きないが、`cache[url]`の上書きが発生してバグとなりえる。


```swift
actor ImageDownloader {
  private var cache: [URL: Image] = [:]
  
  func image(from url: URL) async throws -> Image? {
    if let cached = cache[url] {
      return cached
    }
    
    let image = try await downloadImage(from: url)
    
    cache[url] = image
    return image
    
  }
}
```

```swift
actor ImageDownloader {
  private var cache: [URL: Image] = [:]
  
  func image(from url: URL) async throws -> Image? {
    if let cached = cache[url] {
      return cached
    }
    
    let image = try await downloadImage(from: url)
    
    cache[url] = cache[url, default: image]
    return image
    
  }
}
```

`Dictionary`のデフォルト用サブスクリプトを使う。
https://developer.apple.com/documentation/swift/dictionary/2894528-subscript

- awaitの後に確認する必要がある

## actor isolation

隔離
プロトコルなどとどう相互作用するか
`@Sendable`

```swift
actor LibraryAccount {
  let idNumber: Int
  let booksOnLoan: [Book]
}

extension LibraryAccount: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(idNumber)
  }
}

```

隔離されたactorの外からアクセスできてしまうため、エラーとなる。
> Actor-isolated instance method 'hash(into:)' cannot be used to satisfy a protocol requirement
> 

`nonisolated`にするとできる。非隔離。

```swift
actor LibraryAccount {
  let idNumber: Int
  let booksOnLoan: [Book]
}

extension LibraryAccount: Hashable {
  nonisolated func hash(into hasher: inout Hasher) {
    hasher.combine(idNumber)
  }
}
```

`nonisolated`をつけると、actor外として扱われるので、`let`のみアクセスできる。
`var`はデータ競合を引き起こすため、アクセスできない。

## Sendable

> Sendable type are safe to share concurrently

`Sendable`とは、同期的に共有できるタイプのことです。

- 値をある場所から別の場所にコピーし、両方の場所で変更しても互いに干渉しないこと
- 値型、actor、一部のclass（注意深く実装された場合）

### Sendable protocol
https://developer.apple.com/documentation/swift/sendable/
Sendableであることを保証する。
例えば、
- Bool
- Int
- Float
- Double

などがある。

カスタムの`struct`にも明示的につけることができる。Sendableではない場合はエラーが出る
```swift
struct Book: Sendable {
  var title: String
  var authors: [Author]
}

class Author {
    var name: String = ""
}

```

次のエラーが出る
```
Stored property 'authors' of 'Sendable'-conforming struct 'Book' has non-sendable type '[Author]'
```

`Author`をstructに変えるとエラーは出なくなる。つまりSendableになる。
```swift
struct Author {
  var name: String
}
```

### @Sendable
- 関数を`Sendable`に適合しているかどうかチェックする
- クロージャでキャプチャした変数が`Sendable`であるかどうかチェックする
- `actor`で定義した関数に`await`がついているかチェックする

例えば`Task.detached`
```swift
@discardableResult static func detached(priority: TaskPriority? = nil, operation: @escaping @Sendable () async -> Success) -> Task<Success, Failure>
```

https://developer.apple.com/documentation/swift/task/3856788-detached

前述の`struct Counter`の場合でエラーが起きていたのは、これが原因。

## MainActor
- UIスレッドで実行できる。DispatchQueue.mainのような感じ。
- var, func, classにつけることができる
- UIのアップデートを行う処理にはつけるべき

https://developer.apple.com/videos/play/wwdc2021/10254

追加。
https://zenn.dev/koher/articles/swift-concurrency-cheatsheet#💼-case-18-(actor%2C-observableobject)%3A-共有された状態の変更（非同期処理結果の反映）


```
Property 'authorizationStatus' isolated to global actor 'MainActor' can not be mutated from a non-isolated context
```

```swift
extension ViewModel {
    
    func requestAccessToReminder() {
        Task.detached {
            await self.manager.requestAccess()
            await self.updateStatus()
        }
    }
    
}

private extension ViewModel {
    
    @MainActor
    func updateStatus() async {
        self.authorizationStatus = await self.manager.authorizationStatus
    }
    
}
```
こうするとエラーが出なくなるけど、これで良いのかな。