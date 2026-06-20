# SwiftUI ProgressView


ProgressView

.progressViewStyle
https://note.com/dngri/n/n7460b74f53c7
scaleEffectを使う（高さ調整注意）
色を使う

https://link.medium.com/VN5RdjBMnib
自分で作る方法
→OSSにしてみる
→**結構時間がかかりそうなので、後回しにする**
→少しずつやろう。1時間ずつくらい

アニメーション画像
https://developer.apple.com/documentation/uikit/uiimage/1624094-animatedimagenamed
https://loadingapng.com
https://loading.io
この機能で使えそう。SwiftUIにはなさそう。
カスタムViewStyleを作りたい。できるかな。
https://www.fivestars.blog/articles/custom-view-styles/
→後でやってみる

Animatable
https://qiita.com/takehito-koshimizu/items/786dac0741e19552907b
https://www.hackingwithswift.com/books/ios-swiftui/animating-simple-shapes-with-animatabledata

## カスタムProgressViewやりたいこと

- typeで切り替え
- Shapeを作る
  - Ring
    - 固定の角度
    - 角度を変えながら
  - RingMulti : MultiColorリング

## 機能

CircularProgressViewStyle(tint: Color)
で色を変える

ProgressView(label: () -> Label)
で文字を変える

