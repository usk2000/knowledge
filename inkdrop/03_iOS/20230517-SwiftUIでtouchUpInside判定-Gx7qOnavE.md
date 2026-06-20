# SwiftUIでtouchUpInside判定



effectであれば、
[Craft that perfect SwiftUI button effect](https://iosexample.com/craft-that-perfect-swiftui-button-effect/)

```swift
struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Capsule()
                .foregroundColor(configuration.isPressed ? Color.primary.opacity(0.75) : Color.primary))
            .scaleEffect(configuration.isPressed ? CGFloat(0.85) : 1.0)
            .rotationEffect(.degrees(configuration.isPressed ? 0.0 : 0))
            .blur(radius: configuration.isPressed ? CGFloat(0.0) : 0)
            .animation(Animation.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1))
    }
}
```


touchUpInsideにするためには
https://developer.apple.com/forums/thread/119831
```swift
```


そもそもButtonのactionはtouchUpInsideなのか？
→touchUpInsideのようだ

