# SwiftUIでNavigationViewにボタンを設置


https://ios-docs.dev/swiftui-navigationview/

```swift
struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Text("りんご")
                Text("みかん")
                Text("スイカ")
            }
            .navigationTitle("フルーツ")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        print("左のボタンが押されたよ")
                    }) {
                        Image(systemName: "ellipsis.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("右のボタンが押されたよ")
                    }){
                        HStack {
                            Image(systemName: "trash")
                            Text("削除")
                        }
                    }
                }
            }
        }
    }
}
```