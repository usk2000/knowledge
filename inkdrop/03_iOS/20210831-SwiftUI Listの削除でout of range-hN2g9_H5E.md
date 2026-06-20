# SwiftUI Listの削除でout of range

https://stackoverflow.com/questions/60316727/got-fatal-error-index-out-of-range-show-index-in-list-item-for-swiftui

https://www.yururiwork.net/archives/1295
→classにするしかない？

```
Index out of range: file Swift/ContiguousArrayBuffer.swift, line 500
```

```swift
struct Row: View {
    
    @Binding var fruit: Fruit
    var onToggle: () -> Void
    
    var body: some View {
        HStack {
            Text(fruit.name)
                .foregroundColor(self.fruit.visible ? .black : .gray)
            Spacer()
            Toggle("", isOn: $fruit.visible)
        }
        
    }
}
```

こうすることで、Deleteでクラッシュするようになる。

```swift
struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(self.viewModel.fruits.indices, id: \.self) { index in
                    Row(fruit: $viewModel.fruits[index])
                }.onDelete(perform: { indexSet in
                    self.viewModel.delete(indices: indexSet)
                })
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct Row: View {
    
    @Binding var fruit: Fruit
    
    var body: some View {
        HStack {
            Text(fruit.name)
                .foregroundColor(self.fruit.visible ? .black : .gray)
            Spacer()
            Toggle("", isOn: $fruit.visible)
        }
        
    }
}

class ViewModel: ObservableObject {
    
    @Published var fruits: [Fruit] = [
        .init(name: "Apple", visible: true),
        .init(name: "Banana", visible: true),
        .init(name: "Cherry", visible: true),
        .init(name: "Durian", visible: true),
        .init(name: "Grape", visible: true),
        .init(name: "Kiwi", visible: true),
    ]
    
}

extension ViewModel {
    
    func delete(indices: IndexSet) {
        fruits.remove(atOffsets: indices)
    }    
    
}

struct Fruit {
    let name: String
    var visible: Bool
}

```

onChange
https://www.hackingwithswift.com/forums/swiftui/toggle-control-action/5624

Rowの中のBindingを使っている箇所を変更する

```swift
struct Row: View {
    
    @Binding var fruit: Fruit
    var onToggle: () -> Void
    
    @State var isOn: Bool = false
        
    var body: some View {
        HStack {
            Text(fruit.name)
                .foregroundColor(self.fruit.visible ? .black : .gray)
            Spacer()
            Toggle("", isOn: $isOn)
                .onChange(of: isOn, perform: { value in
                    if isOn != fruit.visible {
                        debugPrint("=> changed")
                        onToggle()
                    }
                })
        }.onAppear {
            self.isOn = self.fruit.visible
        }
        
    }
}
```

ポイントは、
- Toggleに使用するBindingの値を@Stateで定義する
- 変更を検知し、コールバック（今回はonToggle）を呼ぶ


追加で、Environmentも使わない方が良さそう