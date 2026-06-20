# ListにBindingを渡す方法


[[SwiftUI] SwiftUIのList内にBinding変数を渡す方法 | SmallDeskSoftware](https://software.small-desk.com/development/2021/06/24/swiftui-pass-binding-to-list/)

```swift
ForEach.init($texts, id: \.self) { $text in
                                  
}
```