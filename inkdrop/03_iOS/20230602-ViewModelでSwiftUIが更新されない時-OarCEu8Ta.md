# ViewModelでSwiftUIが更新されない時


[[SwiftUI] [Combine] Observable/@Published でも ビューが更新されない時 | SmallDeskSoftware](https://software.small-desk.com/development/2021/03/04/why-swiftui-view-is-not-updated/)


ObservableObject内のPublishedを更新してもViewが更新されない

[ios - SwiftUI @Published property not updating views - Stack Overflow](https://stackoverflow.com/questions/66921673/swiftui-published-property-not-updating-views)

Arrayが問題となっている？
Equatableに指定れば問題なさそう。
余計なBindingはイラなさそう。

どうやらWaterfallGridが問題かも
→一旦他のものにする