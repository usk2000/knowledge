# NavigationViewをPreviewで使う


https://www.hackingwithswift.com/quick-start/swiftui/how-to-preview-your-layout-in-a-navigation-view

例えば、DestinationViewのプレビューでNavigationBarの見た目もプレビューしたい場合。

```swift
struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DestinationView()
        }
    }
}
```