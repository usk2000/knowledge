# Custom Font


カスタムフォントを追加する

[Xcode - カスタムフォントを追加して使用する方法 - iOS アプリの開発 - iOS 開発入門](https://softmoco.com/basics/how-to-add-custom-fonts.php)

[Adding a Custom Font to Your App | Apple Developer Documentation](https://developer.apple.com/documentation/uikit/text_display_and_fonts/adding_a_custom_font_to_your_app?language=objc)

1. ファイルを追加する
2. Info.plistに登録する


フォント名がわからない時は、以下を使う。
```swift
for family in UIFont.familyNames.sorted() {
    let names = UIFont.fontNames(forFamilyName: family)
    print("Family: \(family) Font names: \(names)")
}
```

## SwiftUI

全てのViewに適用する場合
[ios - SwiftUI - Override the system font with multiple styles - Stack Overflow](https://stackoverflow.com/questions/63529909/swiftui-override-the-system-font-with-multiple-styles)

SwiftUIで実装する場合
https://developer.apple.com/documentation/swiftui/font/custom(_:size:relativeto:)

```swift
    static func myFont(_ style: TextStyle) -> Font {
        return .custom(myFontName, size: 1.0, relativeTo: style)
    }
```


[Applying custom fonts to text | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/applying-custom-fonts-to-text)
