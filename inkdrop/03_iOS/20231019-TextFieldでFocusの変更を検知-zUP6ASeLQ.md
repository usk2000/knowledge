# TextFieldでFocusの変更を検知


Focus状態によって、Viewの表示を変えたい
子ViewにTextFieldがあり、Focus状態によって親Viewの表示を変えたい

- isFocusedは使えるか→使えない。変更を検知できない
- ObservableObjectとEnvironmentObjectを使う
  - onChangedで編集状態を検知

[Focus | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/focus)


サンプルを確認する。できるのかもしれない。

[SwiftUI: Replace onEditingChanged in TextField with FocusState - Stack Overflow](https://stackoverflow.com/questions/74306794/swiftui-replace-oneditingchanged-in-textfield-with-focusstate)

これを元に、編集が終わったか検知できる。