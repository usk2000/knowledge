# ForEachで中身を変えたい


[Views do not update inside the For… | Apple Developer Forums](https://developer.apple.com/forums/thread/121966)

indicesを使う
id: \.selfを設定する

```swift
                HStack(spacing: 16) {
                    HStack {
                        Image(systemName: $children[index].gender.wrappedValue == Gender.male ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(.blue)
                        Text(Gender.male.description)
                    }.onTapGesture {
                        $children[index].$gender = Gender.male
                    }
                    HStack {
                        Image(systemName: $child.gender.wrappedValue == Gender.female ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(.blue)
                        Text(Gender.female.description)
                    }.onTapGesture {
                        $children[index].$gender = Gender.female
                    }
                }
```


Boolならできそう。
[Editable Bindings / Mutating a List via ForEach in SwiftUI](https://www.ralfebert.com/swiftui/mutating-foreach/)

[[SwiftUI]ForEachで配列のValueと共にIndexも使用する方法](https://zenn.dev/chiii/articles/ea0b2f80dd1f9b)

