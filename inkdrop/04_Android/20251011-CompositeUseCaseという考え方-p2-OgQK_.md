# CompositeUseCaseという考え方


アーキテクチャ上、ViewModelの中でUseCaseが多く使われることがよくある。
ViewModelが複雑化するというデメリットがあるので、この中間のレイヤーを挟むことを考える

- 意味のある単位でまとめる
  - Stateのための情報をまとめる
  - 一連のシーケンスの中で複数UseCaseを使う時

これを行うことで、ViewModelが見やすくなる。
さらに、KPMなどでViewModelをiOS/Androidで実装できる

- メリット
  - View Lifecycleに対応しやすくなる
  - ViewModelのコードが少なくなる
- デメリット
  - ViewModelについて同じコードを書くことになる