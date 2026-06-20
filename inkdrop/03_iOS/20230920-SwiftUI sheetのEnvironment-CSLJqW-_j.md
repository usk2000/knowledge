# SwiftUI sheetのEnvironment


[シートを実装する際は isPresented と dismiss を利用する。 · YusukeHosonuma/Effective-SwiftUI · Discussion #14 · GitHub](https://github.com/YusukeHosonuma/Effective-SwiftUI/discussions/14)

```swift
@Environment(\.dismiss) var dismiss
@Environment(\.isPresented) var isPresented
```

これを使うことで、明示的にBindingを渡さなくても良い