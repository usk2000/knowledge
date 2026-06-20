# SwiftUI TextとTextFieldをListの中に入れても、アップデートしない


- まずはListの外でできるかどうか
- Listに入れてどのようにできないか


- Listの中に入れる際
  - Boolによる出し分け
  - TextだけにonTapをつけることができるか

https://zenn.dev/usk2000/articles/c3cb598db80b9c
結局、ObservableObjectのプロパティで、`objectWillChange.send()`を呼ぶだけでよかった

[ObservableObjectの中のプロパティが更新された時](inkdrop://note/xPLJsteNs)
