# Listで選択状態になる

https://stackoverflow.com/questions/60139184/swiftui-navigationlink-macos-default-selected-state
https://stackoverflow.com/questions/63998759/swiftui-list-items-are-not-deselected

## 固定Listの場合

- NavigationLinkに`.id(UUID())`を加える。
- ObservableObjectでPublishedを１つ作る（参照しなくて良い）
- onAppear or onDisappearでPublishedの値を変える



