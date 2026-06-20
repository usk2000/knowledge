# Web viewのios26対応


navi viewの後ろまで来るようにできるか
サンプルアプリを作る
→Zennにアウトプットする

https://zenn.dev/spacemarket/articles/9aac1301286dc8

ios26の標準のものを使う

https://developer.apple.com/videos/play/wwdc2025/231/


## サンプル作成
- 通常のWebページ
- ローカルWebページ
- Custom URL scheme
- Navigation events
- backward, forward遷移
- Javascriptを使う
- ScrollView Position change

## technical notes

https://developer.apple.com/documentation/webkit/webpage/backforwardlist-swift.struct

何も考えずに表示するだけなら
```swift
    WebView(url: URL(string: url))
            .frame(width: 150, height: 100)
```

イベントを受け取る方法は、以下が良さそう
```swift
for try await event in webPage.load(url) {
  
}
```

### Javascriptを使えるように
