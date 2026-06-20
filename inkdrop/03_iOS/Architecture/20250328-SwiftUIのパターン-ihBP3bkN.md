# SwiftUIのパターン



- View + ViewModelに加え、コンテンツ表示用のContentModelを追加する


```swift

struct SomeView: View {
 
  @StateObject private var viewModel = SomeViewModel(content: .initialContent)
  
  var body: some View {
      SomeContentView(content) { action in
         viewModel.sendAction(action)
      }        
  }
  
}

struct SomeContentView: View {
  
   var content: ContentModel
   var onAction: (Action) -> Void
  
   var body: some View {
     .....
   }
}

```