# SwiftUI Animations


https://developer.apple.com/documentation/swiftui/animations

[Animation | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/animation)

Basic Usage
```swift
struct ContentView: View {
    @State private var scale = 0.5


    var body: some View {
        VStack {
            Circle()
                .scaleEffect(scale)
                .animation(.easeIn.repeatCount(3), value: scale)
            HStack {
                Button("+") { scale += 0.1 }
                Button("-") { scale -= 0.1 }
            }
        }
        .padding()
    }
}
```

Advanced usage
```swift
struct ContentView: View {
    @State private var isTrailing = false


    var body: some View {
       VStack(alignment: isTrailing ? .trailing : .leading) {
            Image(systemName: "box.truck")
                .font(.system(size: 64))


            Toggle("Move to trailing edge",
                   isOn: $isTrailing.animation(.linear))
        }
    }
}
```

アニメーションについて調べてサンプルアプリを作って公開する。
