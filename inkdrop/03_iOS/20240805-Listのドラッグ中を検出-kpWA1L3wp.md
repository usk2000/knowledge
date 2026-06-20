# Listのドラッグ中を検出


[DragGesture](https://developer.apple.com/documentation/swiftui/draggesture)
[Adding interactivity with gestures](https://developer.apple.com/documentation/swiftui/adding-interactivity-with-gestures)

[【SwiftUI】DragGestureを使って画面タップを可視化する #iOS - Qiita](https://qiita.com/SNQ-2001/items/bb7c029c86750b16491d)
→DragGestureはやりたいことではなさそう


## onDragとonDropを使う

[Drag and drop](https://developer.apple.com/documentation/swiftui/drag-and-drop)
[Transferable](https://developer.apple.com/documentation/CoreTransferable/Transferable)
[Defining file and data types for your app](https://developer.apple.com/documentation/UniformTypeIdentifiers/defining-file-and-data-types-for-your-app)

[iOS 16からのDrag & Dropのやり方](https://zenn.dev/zunda_pixel/articles/7dd3a47b0a3998)
[【SwiftUI】Grid内のImageをDrag&Dropで移動させる方法](https://zenn.dev/oka_yuuji/articles/dc308f8fc9ae10)
[[Swift] DropDelegate で画面外に放したアイテムを検知する #iOS - Qiita](https://qiita.com/hcrane/items/efa0c0b79c468ddb9262)


### Draggable

[iOS 16からのDrag & Dropのやり方](https://zenn.dev/zunda_pixel/articles/7dd3a47b0a3998)


> Type "com.example.person" was expected to be declared and exported in the Info.plist of DropDownListSample.app, but it was not found.
> 

[[iOS] Info.plistにカスタムUTIを追加し、iOSがデフォルトで認識できないタイプのファイルを受け取れるようにする | DevelopersIO](https://dev.classmethod.jp/articles/ios-adding-a-custom-uti/)
→Info.plistに追加が必要
[Defining file and data types for your app](https://developer.apple.com/documentation/UniformTypeIdentifiers/defining-file-and-data-types-for-your-app)

Person
com.example.person
public.data
の３つのデータ

```swift
extension Profile: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .profile)
        ProxyRepresentation(exporting: \.name)
    }
}
```
[ProxyRepresentation](https://developer.apple.com/documentation/CoreTransferable/ProxyRepresentation)
これを使う理由は？
Stringなどに使いそう。

[CodableRepresentation](https://developer.apple.com/documentation/coretransferable/codablerepresentation)

### DragGestureでドラッグ中かどうかを検出

ドラッグ中のみ特定のViewを表示したい。
`.draggable`と一緒に`.gesture`を使用してみる。

```swift
.gesture(
  DragGesture()
    .updating($isDragging) { value, state, transaction in
      state = true
    }
)
.draggable("Drag me!")
```

一緒に使うと、DragGestureが認識されていなさそう。
なので、`onDrag`を使う方向に変更


### .onDragと.onDragEndedを併用する

```swift
.onDrag {
  isDragging = true
  return NSItemProvider(object: item as NSString)
}
.onDragEnded {
  isDragging = false
}
```
→これは複雑。onDragEndedをUIViewでやらなければならない。

[【SwiftUI】View を簡単にドラッグして移動したい #iOS - Qiita](https://qiita.com/chanzmao/items/414496b24f2b8ad60f1f)

→難しい

### .draggableを使用しつつ、ドラッグ中を検出する方法

[SwiftUI, Notification about the end, the cancellation of a drag operation - Stack Overflow](https://stackoverflow.com/questions/68776363/swiftui-notification-about-the-end-the-cancellation-of-a-drag-operation)

### NSItemProviderWritingを使う方法

`.onDrag`を使うときは、`NSItemProviderWriting`を適用する必要がある。`class`で定義する必要がある。

### onDragとonDropを使ってみる

`NSItemProvider`を使った方法はできていそうだが、`.draggable`よりは複雑な実装になる。
ドラッグ中かどうかは判定できなさそう。

→これで子タスクができそう。ゴミ箱は出来なさそう。
[onDrop(of:delegate:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/view/ondrop(of:delegate:)-6lin8)



### DragGestureとListを同時に使う

[Composing SwiftUI gestures](https://developer.apple.com/documentation/swiftui/composing-swiftui-gestures)
[SwiftUI Gesture](inkdrop://note/R579mfzaz)


Listは使えないかも？
https://x.com/ShoheOhtani/status/1589138964220641282
[Reorder items with Drag and Drop using SwiftUI](https://canopas.com/reorder-items-with-drag-and-drop-using-swiftui-e336d44b9d02)

LazyVStackとonDrag, onDropで実装できそう。
[DropInfo | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/dropinfo)
[init(operation:) | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/dropproposal/init(operation:))
ここら辺で何かできそうか？

NSItemProviderの掘り下げ
[NSItemProviderのloadObjectをasync/awaitに対応させてみると、うんともすんとも言わなくなって困った話 | DevelopersIO](https://dev.classmethod.jp/articles/load-object-untomo-suntomo/)


このエラーが出ている

> Instance method 'loadObject(ofClass:completionHandler:)' requires that 'MyData' conform to '_ObjectiveCBridgeable'
> 

オブジェクトをそのまま渡すのは難しいかも。

### onDrag/onDropとonMoveを同時に使えるか
使えなさそう


### onDrag/onDropで並び替え、特定のViewへDropを行う

[ios - SwiftUI | Using onDrag and onDrop to reorder Items within one single LazyGrid? - Stack Overflow](https://stackoverflow.com/questions/62606907/swiftui-using-ondrag-and-ondrop-to-reorder-items-within-one-single-lazygrid)

これを参考にする

Listは特別な処理をしていそう。onMoveを使っていそう。
ScrollView/LazyVStack/ForEachを使う


バグ？onDropの後にonDragが呼ばれる
https://stackoverflow.com/questions/79216776/why-is-the-ondrag-closure-called-after-dropping-an-item-in-swiftui
onDrag/onDropが２つずつあるから？

