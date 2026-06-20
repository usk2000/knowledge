# UIViewやUIStackViewでレイアウトマージンをつけたい場合


https://stackoverflow.com/questions/32551890/how-to-add-leading-padding-to-view-added-inside-an-uistackview

```swift
view.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
view.isLayoutMarginsRelativeArrangement = true
```

Interface Builderでできないかな。