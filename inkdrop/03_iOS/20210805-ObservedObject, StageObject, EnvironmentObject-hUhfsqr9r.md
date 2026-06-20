# ObservedObject, StageObject, EnvironmentObject

違いは？
https://blog.personal-factory.com/2021/01/23/how-to-use-propertywrapper-in-swiftui/
https://tokizuoh.dev/posts/td152tqrb7iflicp/

戦略として、
ObservedObject/StateObjectはViewに対して１つ、あとはBindingを渡す。
EnvironmentObjectはDIのみなど使用を限定する。

タイトル：StateObjectの挙動から戦略を考える

- 子のViewではObservedObject/StateObjectは使わない
  - Bindingで値を渡す
- パフォーマンスが悪かったり部分更新に拘りたい場合、子のViewでもObservedObject/StateObjectを使うが多用しない。使っても２〜3個まで。

## State/StateObjectの挙動
https://developer.apple.com/documentation/swiftui/stateobject

- 親View
  - 子View1
  - 子View2

子View1を更新しても子View2は更新されない

→アウトプットする。qiitaやmedimumにも？
→サンプルを改善