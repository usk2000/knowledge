# Listで入れ子構造のView更新


入れ子構造で、中身をアップデートできるか？
表示する値は、ただ渡しているだけの場合

Listのchildrenを使えばいけそう？
[SwifData and List with children – SwiftUI – Hacking with Swift forums](https://www.hackingwithswift.com/forums/swiftui/swifdata-and-list-with-children/23552)
[init(_:children:selection:rowContent:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/list/init(_:children:selection:rowcontent:)-2pt7r)

通常であればアップデートできる。
しかし、TabViewも使っている場合かつObservableObjectから取得する値を使っている場合は更新できなさそう。

Listの中のForEachを使っているとアップデートされないこともあるかもしれない。
→onMoveが使えなくなる

今だに、異なるEnvironmentObjectでの共有の問題がありそう。
即時に反映してくれないかも。

片方のEnvironmentObjectでは更新されていて、もう片方では更新されていない。
原因は？
- Thread問題？→ない
- ファイル書き込みの問題？
  - 書き込みは問題なさそう
  - 読み込みで以前の状態が保存されてしまっている
- ロジックの問題？
  - なさそう

[Manually publishing ObservableObject changes - a free Hacking with iOS: SwiftUI Edition tutorial](https://www.hackingwithswift.com/books/ios-swiftui/manually-publishing-observableobject-changes)

試しに、EnvironmentObjectを渡してファイル読み込みしてみた→できた
→いや、表示が更新される時とされない時があるな。
[swift - SwiftUIで＠Publishedの配列が即時に反映されない - スタック・オーバーフロー](https://ja.stackoverflow.com/questions/82490/swiftui%E3%81%A7-published%E3%81%AE%E9%85%8D%E5%88%97%E3%81%8C%E5%8D%B3%E6%99%82%E3%81%AB%E5%8F%8D%E6%98%A0%E3%81%95%E3%82%8C%E3%81%AA%E3%81%84)
→structにしているので、書かれていることが原因ではない。更新は検知できている。


childrenで使えるかどうか。

[List | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/list)
[Displaying data in lists | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/displaying-data-in-lists)
[DisclosureGroup | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/disclosuregroup)
DisclosureGroupが使えそう

[swift - How to make a custom DisclosureGroup (drop down) in SwiftUI? - Stack Overflow](https://stackoverflow.com/questions/73358999/how-to-make-a-custom-disclosuregroup-drop-down-in-swiftui)
[ios - List or OutlineGroup expanded by default in SwiftUI - Stack Overflow](https://stackoverflow.com/questions/62832809/list-or-outlinegroup-expanded-by-default-in-swiftui)
[28. Building an Expandable List View Using OutlineGroup · Mastering SwiftUI Book for iOS 17 and Xcode 15 - Sample](https://www.appcoda.com/learnswiftui/swiftui-expandable-list.html)
[28. Building an Expandable List View Using OutlineGroup · Mastering SwiftUI Book for iOS 17 and Xcode 15 - Sample](https://www.appcoda.com/learnswiftui/swiftui-expandable-list.html)

これで行けそう
```swift
List(items) { item in
                DisclosureGroup(
                    isExpanded: .constant(true),
                    content: {
                        ForEach(item.subItems) { sub in
                            Text(sub.text)
                        }
                    },
                    label: { Text(item.text) }
                )
            }
```

`.tint(.clear)`でDisclosureを調整できそう

[【SwiftUI】DisclosureGroupを使ってみた #Swift - Qiita](https://qiita.com/SNQ-2001/items/71cdc63dcc4ec8c2effc)
