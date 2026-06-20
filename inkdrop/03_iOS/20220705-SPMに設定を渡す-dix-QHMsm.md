# SPMに設定を渡す


[pkgConfig | Apple Developer Documentation](https://developer.apple.com/documentation/packagedescription/package/pkgconfig)
これは使えなさそう。

[swift-package-manager/Usage.md at main · apple/swift-package-manager](https://github.com/apple/swift-package-manager/blob/main/Documentation/Usage.md#setting-the-build-configuration)

[How to use a custom build configuration in a Swift Package? - Using Swift - Swift Forums](https://forums.swift.org/t/how-to-use-a-custom-build-configuration-in-a-swift-package/36259/17)
[SwiftSetting | Apple Developer Documentation](https://developer.apple.com/documentation/packagedescription/swiftsetting)
[Creating a Standalone Swift Package with Xcode | Apple Developer Documentation](https://developer.apple.com/documentation/xcode/creating-a-standalone-swift-package-with-xcode)

Build設定を渡すのは、あまり良くなさそう。


[Defining Your Own Settings in Xcode Build Settings | by Hassan Ahmed Khan | Medium](https://medium.com/@hassanahmedkhan/defining-your-own-settings-in-xcode-build-settings-1bd71539ea4f)
[iOSで開発向け機能の実装する時に使うテクニック - Qiita](https://qiita.com/t_osawa_009/items/6080037f20acdec1b239)
[Swift: リリース版でのみ処理を行う](https://zenn.dev/kyome/articles/0b6a689776c9c69b4026)
[Compilation conditions and swift packages - Using Swift - Swift Forums](https://forums.swift.org/t/compilation-conditions-and-swift-packages/34627/3)

Active Compilation Conditions

定義したものが実際に判定できるかどうか
→渡せない

素直に、動的に切り替えるしかないか。