# SPMでレイヤーごとに切り分ける


- UI
- Domain
- Infra
- Data

の４つに分ける方法についてサンプルを作成し、記事を書く。zennとmedium
Infraについては、File, APIに分けても良いかも。
DomainにはFile, APIのみ依存させる。
APIにAlamofireなどを追加する→プロジェクト設定で行けるか？→行けなかったので、Package.swiftに直接記載

[Swift Package](inkdrop://note/UncFZO4kW)

- 概念図を作成し、概要の説明
- 実装の説明
- テストについて
- トラブルシューティング

## メモ
- ローカルパッケージ関連で何かあれば、Files > Reset Package Cachesを試す。
- UI - Domaiの間にもう一つ、protocolとstructを定義したものを使う必要があるか。
- dependenciesを追加した際は、targets > dependenciesにも追加する必要がある。

## 参考
https://zenn.dev/darquro/articles/09b1fea1dc1c96
https://tech.timee.co.jp/entry/2021/08/24/160205
https://medium.com/captain-ios-experts/theawesomeapp-develop-multi-module-ios-app-with-ease-7a8b01366812



## テストについて
- それぞれのパッケージでテストを書いても、実行はできるのだろうか。

https://developer.apple.com/forums/thread/133495

Test Planの使い方。
https://qiita.com/akatsuki174/items/286d2c9a99385b4a222b

test planの方法と、メインアプリのテストにモジュールをincludeする方法がある。

### test planの方法
- Product > Test Plan > New Test Plan

- メリット：モジュールごとにテストを明確に分けることができる。
- デメリット：設定が少し複雑。難しくはない。

https://medium.com/trendyol-tech/get-the-most-out-of-ui-tests-with-xcode-test-plans-d089a2252ba2
https://bamboo-hero.com/entry/manage-tests-with-xcode-test-plans
https://useyourloaf.com/blog/xcode-test-plans/


### メインアプリのUnit Testに分割したモジュールを追加する
- Test Target > Build Phases > Dependenciesに追加する

- メリット：少しの設定変更でシンプルにテストできる
- デメリット：メインアプリのUnit Testのコードがかなり増える


## 資料
[Android既存のアプリをマルチモジュール化](https://droidkaigi.github.io/codelab-2020/ja/index.html#0)


### モジュールとは
[モジュールとは](https://www.itmedia.co.jp/im/articles/0912/19/news008.html)
ソフトウェアを機能的に意味あるまとまりに整理することで、ソフトウェアシステムの構成要素同士の相互依存性を低くする存在として提唱された単位がモジュールである。

[モジュールとは？ライブラリ、コンポーネントとの違い](https://medium-company.com/モジュール/)
似たような言葉としてコンポーネントがある。コンポーネントは「単独では使用せず、他の部品と組み合わせて使うもの」、モジュールは「部品単独でも動作し、他の部品と組み合わせて使う」

[コード生成を用いたiOSアプリマルチモジュール化のための依存解決](https://techlife.cookpad.com/entry/2021/06/16/110000)
[Sansan iOS アプリのマルチモジュール化推進方法](https://buildersbox.corp-sansan.com/entry/2021/12/23/110000)



## レイヤードアーキテクチャ

https://martinfowler.com/architecture/
https://martinfowler.com/bliki/PresentationDomainDataLayering.html
