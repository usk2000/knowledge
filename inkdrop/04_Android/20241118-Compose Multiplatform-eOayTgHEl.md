# Compose Multiplatform


KMP(Kotlin Multiplatform)でJetpack Composeが使えるようになる。

[Compose Multiplatform UI フレームワーク | JetBrains](https://www.jetbrains.com/ja-jp/compose-multiplatform/)
[Create your multiplatform project | Kotlin Multiplatform Development Documentation](https://www.jetbrains.com/help/kotlin-multiplatform-dev/compose-multiplatform-create-first-app.html)
→セットアップ

## Setup
### Environment

- latest Android Studio
- [Kotlin Multiplatform Plugin](https://plugins.jetbrains.com/plugin/14936-kotlin-multiplatform)
- latest Xcode and launch it at least once

[Compatibility guide for Kotlin Multiplatform ](https://kotlinlang.org/docs/multiplatform-compatibility-guide.html)
→ここに書いてあるものと実際のバージョンが違う

### Create project

https://kmp.jetbrains.com
ここでSharedUIを選択する


### Troubleshoot

iOSビルド時に
Java 17が必要になる

```sh
% brew install openjdk@17
% sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
```

gradle.properties
```
org.gradle.java.home=/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home
```
→これは必ず必要ではない。

### Navigation

[Navigation and routing | Kotlin Multiplatform Development Documentation](https://www.jetbrains.com/help/kotlin-multiplatform-dev/compose-navigation-routing.html)

### Resource
[Setup and configuration for multiplatform resources | Kotlin Multiplatform Development Documentation](https://www.jetbrains.com/help/kotlin-multiplatform-dev/compose-multiplatform-resources-setup.html)
リソース関係の共通化
なかなかResクラスに反映されない。
サンプルと見比べる
