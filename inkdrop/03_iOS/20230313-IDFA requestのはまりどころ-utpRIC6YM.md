# IDFA requestのはまりどころ


[【時間が無い人のXcode】 | ATT対応とは？](https://utro-develop.com/att/)


何故、`viewDidLoad`で呼ばれない？
[requestTrackingAuthorization(completionHandler:) | Apple Developer Documentation](https://developer.apple.com/documentation/apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization)

`UIApplicationStateActive`の場合にしか呼ばれない。

[【Swift】App Tracking Transparencyでアップル審査Rejectされた - Qiita](https://qiita.com/YingZheng/items/cc92602a3f5a6aa17ed7)

調べた限り、一番最初に表示されるViewControllerのviewDidLoadでのUIApplicationStateは`.inactive`

viewDidAppearでも、場合によっては`.inactive`となっている。
`UIApplicationDelegate.applicationDidBecomeActive`の方が確実か。
→promptのところで２回呼ばれてしまう。問題ないが、気持ち悪い。UIAlertControllerを出しているからか。

