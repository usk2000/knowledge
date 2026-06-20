# TabViewをProgramaticallyに変える時、アニメーションをさせる

https://zenn.dev/usk2000/articles/68c4c1ec7944fe

https://stackoverflow.com/questions/61827496/swiftui-how-to-animate-a-tabview-selection
https://developer.apple.com/forums/thread/722475
https://zenn.dev/chiii/articles/748093ee3b0bf8


```swift
                TabView(selection: $currentTab) {
                    
                    ForEach(dataStore.holders.indices, id: \.self) { index in
                        TaskListView()
                            .tag(index)
                    }
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: currentTab)
```

- TabView
- スワイプで変えられる
- プログラム的にアニメーションで変えることができる

環境：

[SwiftUIのTabViewでボタンアクションによるスライド切り替え｜TAAT](https://note.com/taatn0te/n/n32043362ac1e)
[Animate transition between views o… | Apple Developer Forums](https://developer.apple.com/forums/thread/722475)
https://developer.apple.com/documentation/swiftui/pagetabviewstyle
