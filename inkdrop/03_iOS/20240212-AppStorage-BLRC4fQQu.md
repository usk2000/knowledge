# AppStorage


[SwiftUI: @AppStorageをもう少し理解する](https://zenn.dev/kabeya/scraps/949e2551f6c75f)

[【SwiftUI】@AppStorageとは？UserDefaultsにデータを保持する方法](https://appdev-room.com/swift-appstorage)

[[SwiftUI]UserDefaultsを使用せず@AppStorageでデータを永続的に保存する方法と注意点](https://zenn.dev/oka_yuuji/articles/887bff664d4637#observableobject%E3%81%AB%E6%BA%96%E6%8B%A0%E3%81%95%E3%81%9B%E3%81%9Fclass%E3%81%A7%E3%83%87%E3%83%BC%E3%82%BF%E3%82%92%E4%BF%9D%E6%8C%81%E3%81%99%E3%82%8B)


TabViewでタブを記憶する場合に使える。

しかし、Multi Scenesの場合を考えると、`AppStorage`よりは`SceneStorage`の方が良さそう
[SceneStorage and TabView - SwiftUI Advanced Handbook - Design+Code](https://designcode.io/swiftui-advanced-handbook-scenestorage)
[iOS 14 における SwiftUI の新機能: @AppStorage, @SceneStorage, SwiftUI app #Swift - Qiita](https://qiita.com/mashunzhe/items/40bf67cdd709c17b599f)
