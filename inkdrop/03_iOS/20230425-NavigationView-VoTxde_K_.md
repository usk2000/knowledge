# NavigationView


https://tech.nri-net.com/entry/change_title_and_color_on_navigationview_and_navigationstack

- NavigationView
- NavigationStack


https://dev.classmethod.jp/articles/ios16-swiftui-navigation-stack/
NavigationStackの方が最新のようだ。

[How to customize the background color of navigation bars, tab bars, and toolbars - a free SwiftUI by Example tutorial](https://www.hackingwithswift.com/quick-start/swiftui/how-to-customize-the-background-color-of-navigation-bars-tab-bars-and-toolbars)

背景色を設定
```swift
.toolbarBackground(.white)
```

TintColorを設定
https://dev.classmethod.jp/articles/ios16-navigationbar-backbutton-color/
```swift
NavigationView {
}.tint(.black)
NavigationStack {
}.tint(.black)
```

戻るボタン
[【SwiftUI】戻るボタンをカスタマイズする方法 – .NET ゆる〜りワーク](https://www.yururiwork.net/archives/1899)
```swift

```

ViewModifierでエラーが出る
```swift
struct NavigationTitleModifier: ViewModifier {
    
    var title: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarTitle(Text(title).font(.myFont(.title)), displayMode: .inline)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

=> Only unstyled text can be used with navigationTitle(_:)
```

さらに、フォントも適用されないみたい
[SwiftUIで NavigationViewのタイトルにカスタムフォントが反映されない - アプリ開発の逆引き辞典](https://recipe.ch3cooh.net/entry/swiftui/navigationview/custom_fonts_are_not_reflected_in_the_title_of_the_navigationView)

UIKitを使用する
[【SwiftUI】NavigationView及びNavigationStackのタイトルや背景色を変更する方法 - NRIネットコムBlog](https://tech.nri-net.com/entry/change_title_and_color_on_navigationview_and_navigationstack)
→できない

fontとかを使用する
[How do you customize the NavigationStack in SwiftUI in 2023? | by Mark Moeykens | Medium](https://medium.com/@mark.moeykens/how-do-i-customize-the-navigationview-in-swiftui-ef90a530e1aa)
→できない

[How to change a navigation bar color in SwiftUI on iOS 16 | Sarunw](https://sarunw.com/posts/swiftui-navigation-bar-color/)
→これもできない

[.navigationBarTitle deprecated](inkdrop://note/4koLWXLaQ)

NavigationStackでカスタムfont・colorは難しそうなので、独自実装することにする