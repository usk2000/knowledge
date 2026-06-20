# SwiftUIでListの背景を変える


[SwiftUIのListで `.listRowBackground()` を指定してもセルの背景色が反映されたり反映されなかったりする問題](https://zenn.dev/ch3cooh/articles/ios_listrowbackground_doesnot_work)

そうしないと、RowのBackgroundに隙間ができてしまう
→まだある

[[SwiftUI]リスト(List)のセクション(section)の背景色(background color)を変えるには？ | ちょげぶろぐ](https://www.choge-blog.com/programming/swiftuilistsectionbackgroundcolor/)


listRowInsetsを0にしてみる
```swift
.listRowInsets(EdgeInsets())
```