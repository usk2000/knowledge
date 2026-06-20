# rootViewControllerの取得


iOS15以降

['windows' was deprecated in iOS 15.0... と言う警告を消す](https://zenn.dev/paraches/articles/windows_was_depricated_in_ios15)

```swift
let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let window = windowScene?.windows.first
```