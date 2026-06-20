# 値つきenumの比較

https://stackoverflow.com/questions/51300121/how-to-make-a-swift-enum-with-associated-values-equatable

```swift
enum State: Equatable {
    case initial
    case main
    case error(message: String)
}
```

Equatableをつけるだけで良い。
Swift4.1以降

つけないと、以下のようなエラー
```
Binary operator '==' cannot be applied to two 'State' operands
```