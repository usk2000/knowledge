# Button Border


[ios - Button border with corner radius in Swift UI - Stack Overflow](https://stackoverflow.com/questions/58928774/button-border-with-corner-radius-in-swift-ui)

[ButtonBorderShape | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/buttonbordershape)

- 角丸
- ボーダー
- 中身とボーダーの色が違う
- 

上記のボタンを作るときは
![スクリーンショット 2023-03-25 21.17.52](FpTO4_nxI-スクリーンショット_2023-03-25_21.17.52.png)

```swift
  Button("ログイン", action: { })
            .frame(width: 240, height: 44)
            .foregroundColor(.black)
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.orange, lineWidth: 2)
            )
            .background(RoundedRectangle(cornerRadius: 22).foregroundColor(.white))
            .shadow(radius: 4, x: 0, y: 1)
```

- 高さは固定したほうが良い
- overlayで角丸の囲い線（オレンジ）
- backgroundで背景の白（角丸）
- shadowでドロップシャドウ
- ViewModifierでまとめておいた方が良い

他の実現方法
[How to draw a border around a view - a free SwiftUI by Example tutorial](https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-a-border-around-a-view)


[SwiftUI 3.0 で追加されたButtonの引数やプロパティを色々試してみた – .NET ゆる〜りワーク](https://www.yururiwork.net/archives/1845)

一通りの形状がある
![simulator_screenshot_1090BBDD-EFBE-444C-9C9E-5293F605E470-768x1662](bOC-WNVL_-simulator_screenshot_1090BBDD-EFBE-444C-9C9E-5293F605E470-768x1662.png)
