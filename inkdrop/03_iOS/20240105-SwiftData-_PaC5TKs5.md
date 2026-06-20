# SwiftData


[SwiftData - Xcode - Apple Developer](https://developer.apple.com/xcode/swiftdata/)

[WWDC2023 SwiftDataセッションまとめ #Swift - Qiita](https://qiita.com/kagaffy/items/cb1f6254215f8b2dbecd#%E3%83%9E%E3%82%A4%E3%82%B0%E3%83%AC%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E6%99%82%E3%81%AE%E5%AF%BE%E5%BF%9C)
[【Swift】SwiftDataでenumを保存する方法 #Swift - Qiita](https://qiita.com/Ri__/items/9ff876c557ae4b521085)
[SwiftDataめっちゃええやん。 #Swift - Qiita](https://qiita.com/Ri__/items/0c46c432b2e873ceeb04)

## Apple Doc

[SwiftData | Apple Developer Documentation](https://developer.apple.com/documentation/swiftdata)


## Preserving your app’s model data across launches
https://developer.apple.com/documentation/swiftdata/preserving-your-apps-model-data-across-launches

### Macro
- @Attribute
  - Model classのプロパティのマクロ
  - デフォルトの動作で十分だが、振る舞いをカスタマイズしたい時に使う
  - [Schema.Attribute.Option | Apple Developer Documentation](https://developer.apple.com/documentation/swiftdata/schema/attribute/option)
- @Relationship
  - 関係するモデルの動作を定義するマクロ
  - 関係するモデルがある場合、デフォルトではモデル削除後に関係するプロパティはnilになる
  - カスタマイズするときにこのマクロを設定する
  - [Defining data relationships with enumerations and model classes | Apple Developer Documentation](https://developer.apple.com/documentation/swiftdata/defining-data-relationships-with-enumerations-and-model-classes/)
- @Transient
  - このマクロは、データベースに保存したくないときに使う
  - 今後の旅行の目的地の現在の天気など、保存の必要のない一時的なデータしか含まれていない場合、など
- @Query


### Storage Setup

[アプリのモデルデータを起動時に保存する | Apple Developer Documentation](https://developer.apple.com/documentation/swiftdata/preserving-your-apps-model-data-across-launches)

デフォルトのストレージ設定
[modelContainer(for:inMemory:isAutosaveEnabled:isUndoEnabled:onSetup:) | Apple Developer Documentation](https://developer.apple.com/documentation/SwiftUI/View/modelContainer(for:inMemory:isAutosaveEnabled:isUndoEnabled:onSetup:)-18hhy)

デフォルトの使い方
```swift
@main
struct TripsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    Trip.self,
                    Accommodation.self
                ])
        }
    }
}
```

カスタムの設定もできる
- メモリ内のみのストレージ
- 読み取り専用のストレージ
  - これは事前にアプリに組み込んでいる場合など？
- 特定のアプリグループでの共有

### SwiftUI modifier

[modelContainer(for:inMemory:isAutosaveEnabled:isUndoEnabled:onSetup:) | Apple Developer Documentation](https://developer.apple.com/documentation/SwiftUI/View/modelContainer(for:inMemory:isAutosaveEnabled:isUndoEnabled:onSetup:)-18hhy)
→主にこちらを使う

[modelContext(_:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/view/modelcontext(_:))

> The environment’s [`modelContext`](https://developer.apple.com/documentation/swiftui/environmentvalues/modelcontext) property will be assigned `myContext`. All implicit model context operations in this view, such as `Query` properties, will use the environment’s context.

とあるので、`.modelContext`は使わなくても`@Environment`を設定すれば自動でViewにContextが設定されていそう。

### Data Model

[Dive deeper into SwiftData - WWDC23 - Videos - Apple Developer](https://developer.apple.com/videos/play/wwdc2023/10196/)


### 値を取得する

```swift
struct ContentView: View {
    @Query(sort: \.startDate, order: .reverse) var allTrips: [Trip]
    
    var body: some View {
        List {
            ForEach(allTrips) {
                TripView(for: $0)
            }
        }
    }
}
```

ここでは、modelContextがないけど、表示だけなら問題ない。

`@Query`の中身でよく使いそうなものは以下の２つ
[init(_:transaction:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftdata/query/init(_:transaction:))
[init(filter:sort:order:transaction:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftdata/query/init(filter:sort:order:transaction:)-2bx9a)

２つ目は、単純なクエリーに使う。１つ目は`FetchDescriptor`を使っているので、複雑なクエリーが可能。

Dynamic Queryはできるか
→今はstaticしかできない。今後はわからない。
[swift - SwiftData query with dynamic properties in a View - Stack Overflow](https://stackoverflow.com/questions/76526517/swiftdata-query-with-dynamic-properties-in-a-view)

`.startDate`がないと怒られる。
> Cannot infer key path type from context
> 

→`\Trip.startDate`のようにする。


Viewの外の場合、以下を使う
```swift
let context = container.mainContext


let upcomingTrips = FetchDescriptor<Trip>(
    predicate: #Predicate { $0.startDate > Date.now },
    sort: \.startDate
)
upcomingTrips.fetchLimit = 50
upcomingTrips.includePendingChanges = true


let results = context.fetch(upcomingTrips)
```

ViewModelを定義していた場合、このように使えそう。
Dynamic Queryが定義できないので、フィルタ条件を変えるなどのDynamicに取得する場合、この手法でできそう。

[FetchDescriptor | Apple Developer Documentation](https://developer.apple.com/documentation/swiftdata/fetchdescriptor)

疑問、これをFirestoreとかにも適用できるのかしら？

### Adding and Editing



### ModelConfiguration

[CoreDataからSwiftDataへデータの引き継ぎ](https://zenn.dev/muhiro12/articles/swift-coredata-to-swiftdata)

`ModelConfiguration.url`に`default.sqlite`として情報が保存されている。
→これを元にRead-onlyを作れるかも。

### Schema Migration
[SchemaMigrationPlan | Apple Developer Documentation](https://developer.apple.com/documentation/swiftdata/schemamigrationplan)
[Model your schema with SwiftData | WWDC NOTES](https://www.wwdcnotes.com/notes/wwdc23/10195/)
[LinkedInのMajid Jabrayilov: This is how schema migration plan works in SwiftData. You define…](https://www.linkedin.com/posts/meciddjabrayilov_this-is-how-schema-migration-plan-works-in-activity-7072544000745832450-Aqkb)

### PreviewでSwiftData Modelを表示させたいとき

[Build your first app with SwiftUI and SwiftData – Hacking with Swift](https://www.hackingwithswift.com/articles/263/build-your-first-app-with-swiftui-and-swiftdata)


### Fetch中のステートはあるのか？


### @QueryでRelationshipをソートする時

[How to sort SwiftData queries using key paths or SortDescriptor - a free SwiftData by Example tutorial](https://www.hackingwithswift.com/quick-start/swiftdata/how-to-sort-swiftdata-queries-using-key-paths-or-sortdescriptor)

```swift
@Query(sort: [SortDescriptor(\name), SortDescriptor(\Movie.releaseDate, order: .reverse), SortDescriptor(\Movie.director.name)]) var movies: [Movie]
```


### バイナリーデータを保存するとき

[blob - How to store variable of type Data in SwiftData - Stack Overflow](https://stackoverflow.com/questions/77419816/how-to-store-variable-of-type-data-in-swiftdata)
[externalStorage | Apple Developer Documentation](https://developer.apple.com/documentation/swiftdata/schema/attribute/option/externalstorage)

このように定義する。どのように保存されるかの挙動がわからない。
画像とかを想定している？

`CLLocationCoordinate2D`や`Color`などは直接保存できない。
代わりに、独自なものを定義する
[How to use `CLLocationCoordinate2D` and `Color` data types in Swift Data? - Stack Overflow](https://stackoverflow.com/questions/77633315/how-to-use-cllocationcoordinate2d-and-color-data-types-in-swift-data)


[SwiftDataをiCloudとApp Groupsに対応して利用する](https://zenn.dev/himara2/articles/88d4d873d4078d)
