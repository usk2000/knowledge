# Non-constant range: argument must be an integer literal


Non-constant range: argument must be an integer literal
[SwiftUI ForEachのNon-constant range警告 - ・λ・](https://blog.hikaru.run/2022/06/07/swiftui-foreach-warning.html)

解決策
```swift
orEach(0 ..< myArray.count, id: \.self) { index in
    ...
}
```
