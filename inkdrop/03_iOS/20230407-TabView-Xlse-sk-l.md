# TabView


背景色を変える方法
https://sarunw.com/posts/swiftui-tabview-color/
iOS16以降

```swift
.toolbarBackground(Color.yellow, for: .tabBar)
```

ただし、スクロールするなどしてコンテンツがtabbarの下に来た場合のみ
→間違っているようだ。

https://developer.apple.com/documentation/swiftui/menu/toolbarbackground(_:for:)

```swift
.tabItem {
  Label.init("記録", systemImage: "star")
}
.toolbarBackground(Color.white, for: .tabBar)
.toolbarBackground(.visible, for: .tabBar)
```

上記はtabItemに対してのみ適用される。
全てに提供するためには
```swift
TabView {
  Group {
    Text("hello")
    .tabItem {
       Text("title")
    }
  }
  .toolbarBackground(Color.white, for: .tabBar)
  .toolbarBackground(.visible, for: .tabBar)  
}
```
とする。


アクセントカラーを変えるためには
https://sarunw.com/posts/swiftui-tabbaritem-color/
Assetsで変える
iOS16以降


