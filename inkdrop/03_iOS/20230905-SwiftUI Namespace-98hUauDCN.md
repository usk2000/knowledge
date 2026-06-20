# SwiftUI Namespace


https://zenn.dev/yamajyn/articles/473f2ae123769d

[Namespace | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/namespace)

[matchedGeometryEffect と @Namespaceを使ったアニメーション - Qiita](https://qiita.com/hoshi005/items/83cafdc3270bd0e248c0)

[Namespace.ID | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/namespace/id)
Equatable, Hashable,Sendable


[[SwiftUI]Custom Animation Tab（下線移動式タブ）](https://zenn.dev/chiii/articles/748093ee3b0bf8)

geometryEffectのpropertiesは何か、withAnimationだとアニメーションがおかしくなる場合があることを調べる

[Matched Geometry Effect - SwiftUI Handbook - Design+Code](https://designcode.io/swiftui-handbook-matched-geometry-effect)
[How to synchronize animations from one view to another with matchedGeometryEffect() - a free SwiftUI by Example tutorial](https://www.hackingwithswift.com/quick-start/swiftui/how-to-synchronize-animations-from-one-view-to-another-with-matchedgeometryeffect)


[matchedGeometryEffect(id:in:properties:anchor:isSource:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/view/matchedgeometryeffect(id:in:properties:anchor:issource:))

基準となるframeがあるところはisSource=trueとし、
移動するべきところはisSource=falseとする。
IDを変える。

IDを変える方法と変えない方法がありそう
- IDを変える場合：.backgroundで設定している場合
- IDを変えない場合：Viewそのものの移動