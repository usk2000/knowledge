# 複数Listの更新


- TabView
  - List - 1
  - List - 2
  - List - 3
のような構造を考える

List1だけを更新したりしたいときを考える

それぞれのListにViewModelを持たせる
DataStore, RepositoryはEnvironmentObjectで持たせる
viewAppearで処理をする

### やりたいこと
- `List`を横に並べてスワイプで切り替える
- それぞれの`List`ごとのデータを保持する
- それぞれの`List`にデータを追加する

イメージとしては、
階層構造で横への流れのMaster-Detailパターンがあるが、今回はDetailだけをSwipeで切り替えたい。

### 達成するために
- `EnvironmentObject`でデータを保持
  - ファイルやCloudもあるが、今回はメモリで保持する
- それぞれの`List`に対して個々の`ViewModel`を`StateObject`で持つ
- `ViewModel`は親Viewから渡す
  - データを追加する場所は`List`があるstruct以外のところの方が、データ追加のためのUIを組みやすい
  - もちろん状況によっては、`List`があるstructのみでデータが追加できるように限定することも考えられる
- `ViewModel`を使ったデータの読み込みは、`onAppear`で行う
  - `ViewModel`の初期化パラメータとして`EnvironmentObject`を渡すことができない
  - `onAppear`では`EnvironmentObject`があることが確定できるので、挙動の把握が難しい`init`よりは無難

### 実装

環境
- Xcode 15.0
- iOS 17.0

`data struct`と`data store`を定義
```swift
struct Item: Identifiable {
    var id: String
    var title: String
    
    .....
  
}

class DataStore: ObservableObject {
    
    var data: [String: [Item]] = [:]
        
    func getData(id: String) -> [Item] {
        .....
    }
    
}

```

`DataStore`は`EnvironmentObject`として使用し、全てのViewで共通のものを使います。

ViewModelを定義
```swift
class ListViewModel: ObservableObject, Hashable, Identifiable {
    
    var id: String
    
    @Published var items: [Item] = []
    
    var dataStore: DataStore!

    .....
  
    func loadItems(store: DataStore) {
        
        self.dataStore = store

        items = dataStore.getData(id: id)
        
    }
    
    func addItem(title: String) {
        .....
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    static func == (lhs: ListViewModel, rhs: ListViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
```

ここで、データを読み込むときに`EnvironmentObject`の`DataStore`を渡しています。これは、`ListViewModel`クラスが初期化されているときに、`EnvironmentObject`の`DataStore`が注入されていない、つまりオブジェクトが存在しないからです。

最後にViewを定義します。

```swift
struct ListView: View {
    
    @StateObject var viewModel: ListViewModel
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        List {
            ForEach($viewModel.items) { item in
                Text(item.title.wrappedValue)
            }
        }
        .onAppear {
            self.viewModel.loadItems(store: dataStore)
        }
    }
}

struct ContentView: View {
    
    @State var selectedTab = 0
    
    @State var listViewModels: [ListViewModel] = [
        ListViewModel(),
        ListViewModel(),
        ListViewModel()
    ]
    
    var body: some View {
        VStack {
            
            TabView(selection: $selectedTab) {
                ForEach(Array(listViewModels.enumerated()), id: \.element) { index, viewModel in
                    
                    ListView(viewModel: viewModel)
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
            
            HStack {
                Button("add new task") {
                    debugPrint("current: \(selectedTab)")
                    
                    listViewModels[selectedTab].addItem(title: "new task")
                    
                }
                Spacer()
            }.padding()
          
        }
    }
}

```

`TabView`で並列に`ListView`を並べます。それぞれの`ListViewModel`を`ContentView`で保持しています。このようにすることで、`ListView`のコンテンツ変更・更新を`ListView`以外で行うことができます。例えば、`.fullScreenCover`を使い別Viewでコンテンツ変更もできます。

### 終わりに
本来であれば、`ListViewModel`を別Viewで使うのは良くない(気持ち悪い)ですね。`DataStore`のみ更新すれば良いと思いましたが、実装してみると更新がうまく行かなかった問題がありました。具体的には、更新された値をうまく読み取れなかった。原因が解明されれば、`ListViewModel`は`ListView`のみで使うこともできます。

