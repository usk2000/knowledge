# SwiftUI Gesture


[Composing SwiftUI gestures](https://developer.apple.com/documentation/swiftui/composing-swiftui-gestures)

`LongPress`の後に`Drag`などのコンビネーションができる


Listの中のVStack/HStackでタップ領域を正しく設定するためには
```swift
            List(samplePeople) { person in
                HStack {
                    Text(person.name)
                    Spacer()
                }
                .background()
                .gesture(longPressDrag)
            }
```

`.background()`の意味→
[SwiftUIの.background(〜)系まとめ](https://zenn.dev/samekard_dev/articles/5737c837b8c4a4)
ShapeStyle.background
[background | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/shapestyle/background)

ListとLongPress+Dragは動いていそう。


### DragGesture.Value

[DragGesture.Value](https://developer.apple.com/documentation/swiftui/draggesture/value)

- startLocation: CGPoint
- location: CGPoint
- translation: CGSize
  - total translation from start to location



