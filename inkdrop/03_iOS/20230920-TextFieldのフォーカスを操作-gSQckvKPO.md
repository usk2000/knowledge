# TextFieldのフォーカスを操作


https://stackoverflow.com/questions/73514361/how-to-set-the-focus-of-a-textfield-when-it-appears-on-the-view-in-swiftui
https://thwork.net/2021/11/19/swiftui_focusstate/

複数のTextFieldがあるときに、toolbarを設定するとうまくいかない問題がある。

[ios - Duplicate toolbar in SwiftUI - Stack Overflow](https://stackoverflow.com/questions/71279700/duplicate-toolbar-in-swiftui)
ここでも指摘されている

toolbar modifierは使わないほうが良いかな

[SwiftUI TextField — events, focus, keyboard | Medium](https://fatbobman.medium.com/advanced-swiftui-textfield-events-focus-keyboard-c99bc9f57c91)
これを読んで、サンプルを作って試してみる。


- sub View２つにそれぞれTextField
- １つのViewで２つのTextField
- toolbar modifierを２つ
- FocusManagerが必要そう
- TextFieldを識別する必要がある？

[swift - How to detect when a TextField loses the focus in SwiftUI for iOS? - Stack Overflow](https://stackoverflow.com/questions/58406224/how-to-detect-when-a-textfield-loses-the-focus-in-swiftui-for-ios)
FocuseStateが使えそうか


### FocusStateの使い方

[【SwiftUI】@FocusStateの使い方 | thwork](https://thwork.net/2021/11/19/swiftui_focusstate/)

Listの中で使うとき、
[SwiftUI List with @FocusState and focus change handling - Stack Overflow](https://stackoverflow.com/questions/73111917/swiftui-list-with-focusstate-and-focus-change-handling)

FocusStateの一般的な使い方として、同じView(異なるSub viewに分かれていない)で複数ある時を想定していそう。
複数Viewに分けると途端にややこしくなる。


### Toolbarの使い方

それぞれのTextFieldに対して、toolbarを設定することはできる。
しかし、ひとまとめにはできない。

iOS17で表示できない問題
https://developer.apple.com/forums/thread/736040
どうやら、NavigationStackが必要

たまに表示されない場合もある
[SwiftUI - Placing ToolbarItem on .… | Apple Developer Forums](https://developer.apple.com/forums/thread/736040)
これはiOS側のバグ