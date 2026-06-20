# 縦方向の分け方もまとめておく



- UI
- Features Module
  - Divide by feature
  - Business Logic
  - API, DataStore, etc
- Infrastructure
  - Common API
  - Common DataStore
  - Common SDK Usage

→zennとかにまとめてみる

- 水平方向への分割はSPM, Gradleともにやりやすい
- 垂直方向の分割は、SPMはできる（PackageとProductを分ける）、Gradleはできないのでフォルダで分けるしかない
- 名称はDomainとInfrastructureで良いかな
- Github APIサンプルを作ってみよう

考えてみると、APIパッケージでプロダクトを分ける方法が良いかも。CRTSは。
androidも同様か？でも、プロダクトで分けることができないので、ここでの分け方の方が良さそう。ただし機能が少ない場合。
機能が大きのであれば、ドメインでまとめてしまうのが良いか？
まずは垂直方向が良い。