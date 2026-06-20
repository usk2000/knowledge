# OptionSetとSet<T>


[【Swift】複数のフラグを管理する場合に Set を使う - Qiita](https://qiita.com/takehito-koshimizu/items/65776bcd257dafbe854d)

OptionSetよりは、Setを使う

- CaseIterableのenum
- Set

```swift
enum ShippingOptions: CaseIterable {
    case nextDay
    case secondDay
    case priority
    case standard
}

var options = Set<ShippingOptions>()
options.formUnion([.nextDay, .priority])

if (options == [.nextDay, .priority]) {
    print("お急ぎ")
}

```
  
[Set | Apple Developer Documentation](https://developer.apple.com/documentation/swift/set)

調べて試してみる