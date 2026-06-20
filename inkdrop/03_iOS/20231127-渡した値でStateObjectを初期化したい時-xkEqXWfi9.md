# 渡した値でStateObjectを初期化したい時


[StateObjectのwrappedValueはイニシャライザのclosure内で初期化した方が良い話 #Swift - Qiita](https://qiita.com/fuziki/items/d9e231f5748743071a2c)
→公式のやり方なのだろうか？

もう一つは、ViewModel自体を渡す方法かな。

[swift - How to use EnvironmentObject to initialize State Property in SwiftUI? - Stack Overflow](https://stackoverflow.com/questions/65739352/how-to-use-environmentobject-to-initialize-state-property-in-swiftui)

onAppearの後が良さそう


そもそもSingletonの方が良いのでは？
[ObservableObject as a singleton vs… | Apple Developer Forums](https://developer.apple.com/forums/thread/704622)

[【SwiftUI】@EnvironmentObjectはシングルトンにした方が良い話 #Swift - Qiita](https://qiita.com/osyou84/items/6742d095c742b1514357)
最低限、１つのsingletonが良いのでは？

なぜなら、EnvironmentObjectとStateObject/ObservedObjectとのやりとりは想定されていないから

[ios - SwiftUI Using @StateObject and @EnvironmentObject at the same time - Stack Overflow](https://stackoverflow.com/questions/75847407/swiftui-using-stateobject-and-environmentobject-at-the-same-time)


それか、ViewModel自体をEnvironmentObjectにするか。

[ViewModelは@EnvironmentObjectを使わない方がいい？？ in SwiftUI - テコテック開発者ブログ](https://tec.tecotec.co.jp/entry/2022/11/30/090000)

