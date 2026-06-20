# SwiftUIのNavigationLink


NavigationLinkのdestinationですぐに初期化されてしまう。
https://stackoverflow.com/questions/57594159/swiftui-navigationlink-loads-destination-view-immediately-without-clicking

- 初期化で処理をしている場合は先に呼ばれてしまう
  - 特に、Combine等でsubscribeしている場合は影響が出てしまう
- onAppearは何回も呼ばれる可能性がある

対策
- Lazyにする
- onAppearで注意深く呼ぶ


アウトプットする