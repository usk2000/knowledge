# Kotlin Multiplatform

https://kotlinlang.org/docs/multiplatform.html
https://kotlinlang.org/lp/mobile/
https://kotlinlang.org/docs/mobile/getting-started.html
https://engineering.mercari.com/blog/entry/2018-12-18-114010/

# 解決したいこと
- APIについて共通化

# 結論
やらない。


# TODO
* [x] セットアップ
* [x] サンプルアプリ作成
* [x] structure理解
* [ ] 単独Moduleの作成
  * [ ] プラグインによるModule作成
  * [ ] SPMインポート
* [ ] github search APIモジュール作成
  * [ ] Android用
  * [ ] iOS用SPM
* [ ] Firebaseモジュールの作成
  * [ ] Android用
  * [ ] iOS用SPM

# セットアップ
## 環境
- macOS
- Android Studio 4.2以上→プラグインのバグがあるので最新に
- Xcode 11.3以上→12.5以上にする

## プラグインのインストール
Preferences > Plugins
Marketplaceから`Kotlin Multiplatform Mobile`をインストール

# サンプルアプリ作成
File > New > New Project
`KMM Application`を選択
![](https://kotlinlang.org/docs/mobile/images/kmm-project-wizard-1.png =250x)
パッケージ設定を行う→Finish
時間が結構かかる。
![](https://kotlinlang.org/docs/mobile/images/kmm-project-wizard-3.png)


structure viewをAndroidからProjectに変更

> Please specify Xcode project location in xcodeproj property of gradle.properties
> 
https://android.benigumo.com/20210210/error-please-specify-xcode-project-location-in-xcodeproj-property-of-gradle-properties/
https://kotlinlang.org/docs/mobile/kmm-plugin-releases.html#release-details

> Android Gradle plugin requires Java 11 to run. You are currently using Java 1.8.
> 
https://qiita.com/takahirom/items/5e8d7b69e873edb3dcaf

> Using different JDK locations on different processes might cause Gradle to
			spawn multiple daemons
      


# 単独のModuleの作成
このpluginが使えそう。
https://github.com/ge-org/multiplatform-swiftpackage
https://johnoreilly.dev/posts/kotlinmultiplatform-swift-package/
→使えない。クソが。

共有するときは、このサンプルを元に作成するしかなさそう。
