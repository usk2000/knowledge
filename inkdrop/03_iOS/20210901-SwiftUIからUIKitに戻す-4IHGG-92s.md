# SwiftUIからUIKitに戻す

https://mokacoding.com/blog/how-to-migrate-from-swiftui-to-uikit-life-cycle/

- SwiftUIでは実現したい操作、見た目は難しいな


さらにStoryboardベースに戻すために
- Main.storyboardを追加
- ViewControllerを作成しstoryboardで実装。Initial View Controllerにチェックマークをつける
- Info.plistにMain storyboard file base nameを追加
- Application Scene Manifest > Scene Configuration > Application Session Role > Item 0にStoryboard Nameを追加

https://engineering.mercari.com/blog/entry/20201216-4043b38af1/
