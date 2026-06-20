# SwiftUI overlay表示


単純にZStackを使うのが良いかも。
https://www.hfoasi8fje3.work/entry/2021/08/13/%E3%80%90SwiftUI%E3%80%91%E3%83%9D%E3%83%83%E3%83%97%E3%82%A2%E3%83%83%E3%83%97%EF%BC%88%E3%82%AA%E3%83%BC%E3%83%90%E3%83%BC%E3%83%AC%E3%82%A4%EF%BC%89%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B
> 
### 全画面表示の場合
[【SwiftUI】フルスクリーンでモーダル表示する【fullScreenCover】 – .NET ゆる〜りワーク](https://www.yururiwork.net/archives/1177)

`.fullScreenCover`を使う
```swift
        .fullScreenCover(isPresented: $isPresented) {
            CustomAlertView(isPresented: $isPresented)
                .background(BackgroundCleanerView())
        }
```

アニメーションさせたくない時、
[SwiftUI: fullScreenCover with no animation? - Stack Overflow](https://stackoverflow.com/questions/69712759/swiftui-fullscreencover-with-no-animation)

```swift
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
```

背景を透過させたい時
[【SwiftUI】sheetの背景を透過させる方法 | DevelopersIO](https://dev.classmethod.jp/articles/swiftui-mr-transparent/)
[[Resolve]-Is there a way to set a fullScreenCover background opacity?](https://www.appsloveworld.com/coding/ios/133/is-there-a-way-to-set-a-fullscreencover-background-opacity)

標準のものはないので、UIViewRepresentableを使う

```swift
        .fullScreenCover(isPresented: $isPresented) {
            CustomAlertView(isPresented: $isPresented)
                .background(BackgroundCleanerView())
        }

struct BackgroundCleanerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct BackgroundCleanerView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCleanerView()
    }
}
```



SwiftUIライブラリ化出来ないかな
- chainするところ
- disable animationして独自アニメーション（浮き上がる感じ）


### 現在の問題
- 戻る時にcloseアニメーションが入ってしまう

→これで解決できる
```swift
var transaction = Transaction()
transaction.disablesAnimations = true
withTransaction(transaction) {
  self.showMenu = true
}
```


https://zenn.dev/usk2000/scraps/99df702068c223
presentationBackgroundが使えそう
→アウトプット
