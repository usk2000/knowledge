# Transitionアニメーション


関連：[SwiftUI overlay表示](inkdrop://note/CemJNOfUG)

[【SwiftUI】トランジション（transition）の使い方 | カピ通信](https://capibara1969.com/2442/)


`.fullScreenCover`と一緒には使えなさそう。
[ios - How to change transition in fullScreenCover in SwiftUI? - Stack Overflow](https://stackoverflow.com/questions/74262995/how-to-change-transition-in-fullscreencover-in-swiftui)


ZStackでアニメーションできない不具合
https://stackoverflow.com/questions/57730074/transition-animation-not-working-properly-in-swiftui
→Previewのバグみたい

I found a bug in swiftUI_preview for animations. when you use a transition animation in code and want to see that in SwiftUI_preview it will not show animations or just show when some view disappears with animation. To solve this problem you just need to add your view in preview in a VStack. like this :

```swift
struct test_UI: View {
    @State var isShowSideBar = false
    var body: some View {
        ZStack {
            Button("ShowMenu") {
                withAnimation {
                    isShowSideBar.toggle()
                }
                
            }
            if isShowSideBar {
                SideBarView()
                    .transition(.slide)
            }
        }
    }
}
struct SomeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
           SomeView()
        }
    }
}
```