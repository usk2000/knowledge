# Preview中を判定


APIの実行を、プレビュー中はやめたい。

https://stackoverflow.com/questions/70757140/has-swift-compilation-condition-for-swiftui-preview-environment

```swift
ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
```
今のところ、これしか方法がない