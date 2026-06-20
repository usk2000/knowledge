# ObservableObjectの中のプロパティが更新された時


[【SwiftUI】ObservableObjectについて（クラス、入れ子、配列など） | thwork](https://thwork.net/2021/08/31/swiftui_observableobject/#toc7)

ObservableObjectの中の普通のvariableを変更した時、EnvironmentObjectとしているObservableObjectの更新の通知を行いたい。

```swift
dataStore.objectWillChange.send()
```

objectWillChangeで更新されたことを通知できる

これをすることで、ObservableObjectのなかの普通のプロパティの更新もできる。
Publishedはどうか後で調べる。
もしかしたらObservableObjectの中のPublishedは自動的に変更が伝播するのかもしれない。
