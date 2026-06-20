# SwiftData ModelとRouterパターンを使うと、EXC_BAD_ACCESSが発生する

https://zenn.dev/usk2000/articles/c50e49589851ec

RouterパターンとSwiftDataを使った場合に`EXC_BAD_ACCESS`が発生する。
- RouterパターンとSwiftDataを使っている場合
- 追加・保存した後にViewを閉じようとするとCrashする
  - 

```swift
extension Identifiable where Self: Hashable {
    typealias ID = Self
    var id: Self { self }
}
```
ここの`var id: Self { self }`で`EXC_BAD_ACCESS`が発生する。

[sheetの出し分け](inkdrop://note/idNsY-GpG)

### 仮定と解決策

`extension Identifiable`が、SwiftDataに影響している可能性。

SwiftDataの`PersistentModel`を調べると、
[PersistentModel | Apple Developer Documentation](https://developer.apple.com/documentation/swiftdata/persistentmodel)

```swift
protocol PersistentModel : AnyObject, Observable, Hashable, Identifiable
```

とあるので、Routerで使っている`Hashable, Identifiable`と一緒になっている。

Routerのサンプル

```swift
enum ContentRouter: View, Hashable, Identifiable {
    
    case first
    case second(text: String)
    
    var body: some View {
        switch self {
        case .first: return AnyView(FirstView())
        case .second(let text): return AnyView(SecondView(text: text))
        }
    }
    
}
```

つまり、
```swift
extension Identifiable where Self: Hashable
```
の部分が`PersistentModel`に影響されていると考えられる。

なので、`extension Identifiable`の部分を修正する。やりたいこととしては、Routerの時のみに`Identifiable`をextensionする。

```swift
protocol Router: Hashable {}

extension Identifiable where Self: Router {
    typealias ID = Self
    var id: Self { self }
}

enum ContentRouter: View, Router, Identifiable {
    ...
}

```