# UI testのLaunch Performance


[Testing App Launch Time](https://useyourloaf.com/blog/testing-app-launch-time/)

[Reducing Your App’s Launch Time | Apple Developer Documentation](https://developer.apple.com/documentation/xcode/reducing-your-app-s-launch-time)
Profile Your App’s Launch Time

- UI testのmeasureは、６回の軌道の合計時間を表す
- Idle状態になるまでの時間、つまりユーザーが簡単に操作できるまでの時間？

テストプロセス
- Open
- Launch
- Setting up automation session
- wait to idle


[(3) iOS 13 - Test Your App Performance and Memory Metrics | LinkedIn](https://www.linkedin.com/pulse/ios-13-test-your-app-performance-memory-metrics-avi-tsadok/)


- テスト後、コードの`measure`のところを見るとわかりやすい
- viewDidAppearが呼ばれるまで



