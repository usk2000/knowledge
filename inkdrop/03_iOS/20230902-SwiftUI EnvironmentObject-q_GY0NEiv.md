# SwiftUI EnvironmentObject


DIの中心を渡すのはどうだろうか。
AppResolverみたいなもの
ViewModelに対しては、AppResolverから何かしらのオブジェクトを注入する

```swift
class ViewModel: ObservableObject {
  
  @Published var service: SomeService
  
  init(resolver: AppResolver) {
    self.service = resolver.provideResolver()
  }
  
}
```

[SwiftUIでViewModelをDIしてみる｜TAAT](https://note.com/taatn0te/n/n0ab7d562eabb)

- ObservableObjectはprotocol化しないほうが良さそう
- ViewModelをEnvironmentObjectにすると、悪さしそう
- 独自のDI機構を設けた方が良いか
- ViewModelに対しては、デフォルトを実装することとMock化できるようにする

[SwiftUIをジェネリクスでプレビューしやすくする - Qiita](https://qiita.com/rymshm/items/a5469671194701e36861)
この方法は使えるかどうか確認

ViewModelに対してInjectableプロトコルを適用し、デフォルト実装を試す