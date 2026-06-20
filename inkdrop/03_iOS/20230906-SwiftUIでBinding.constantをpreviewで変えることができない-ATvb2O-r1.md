# SwiftUIでBinding.constantをpreviewで変えることができない


[Using .constant for @Binding values in SwiftUI Previews | DeveloperMemos](https://developermemos.com/posts/binding-values-swiftui-previews)

[How to preview a custom View that … | Apple Developer Forums](https://developer.apple.com/forums/thread/118589)

[How to preview a custom View that … | Apple Developer Forums](https://developer.apple.com/forums/thread/118589)

PreviewProvider内で
```swift
@State static var currentTab: Int = 0
```

などを宣言して使う
→この方法は出来なさそう

[SwiftUI BindingのあるViewのプレビューを正しく表示する - Qiita](https://qiita.com/hyuga_amazia/items/e674c2daf42c30b660d1)
ー＞この方法が公式のようだ。
https://developer.apple.com/videos/play/wwdc2020/10149/


問題点
- PreviewでBinding.constantを使うと、表示はできるがBindingを変えることができない
- Bindingにより表示・動きを変える実装は無視される。constantだから

