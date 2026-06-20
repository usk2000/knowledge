# SwiftUIでアニメーションが動かない場合がある


- 親Viewでmodifierを設定している場合
  - →関係ないかも
- transaction.disablesAnimationsをtrueにしている場合

[SwiftUI におけるアニメーションの基本的な実装方法について iOS 15 から deprecated になるものも交えて紹介 - Qiita](https://qiita.com/kalupas226/items/153fdaf783379e7d865a)

[SwiftUI: fullScreenCover with no animation? - Stack Overflow](https://stackoverflow.com/questions/69712759/swiftui-fullscreencover-with-no-animation)

これで行ける
```swift
var transaction = Transaction()
transaction.disablesAnimations = true
withTransaction(transaction) {
   showModal.toggle()
}
```

`View.transaction`で
```swift
.transaction { transaction in
  transaction.disableAnimations = true
}  
```
としても良いが、この問題点はSubViewのアニメーションも止めてしまうこと。