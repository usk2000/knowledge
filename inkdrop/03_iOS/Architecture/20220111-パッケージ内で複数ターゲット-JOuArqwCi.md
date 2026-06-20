# パッケージ内で複数ターゲット

Firebaseを真似してみる。アーキテクチャに活かせるかも。
マルチターゲット。
これを縦横のマトリックスでモジュールを作成できそう


https://forums.swift.org/t/spm-custom-framework-with-multiple-targets/47650/3

[Swift Package](inkdrop://note/UncFZO4kW)

https://github.com/firebase/firebase-ios-sdk/blob/master/Package.swift

問題点
* [ ] 同じPackage内で、targetを複数設定しても、それぞれで依存関係を記述しなくてもimportできてしまう。

## モジュールとコンポーネント
- SPMでモジュール・コンポーネントを表現する
- モジュールは機能が単体で完結しており単独で使用できる、コンポーネントは単体で完結しているが単独では使用しないとする
- モジュール：SPMのPackage
- コンポーネント：Packageのproduct（ターゲット）
- 依存関係を複雑化させないために、１つのproductに対して１つのtargetとする
  - 場合によっては、１つのproductに対して複数のtargetを指定することもできる。
  - →これはサンプルを作ってみる価値はありそう。

## 複数ターゲットを作る
Package内に複数ターゲットを作成する、つまり複数のモジュールを追加する。
- モジュール群：フレームワーク・レイヤーに相当する
- ここでは、モジュール群を1つのPackageとして表現する
- モジュール郡の例として、`Infra`Packageを作成する。
- `targets`で`.target`を追加する。
  - 例えば`.target(name: "Api", dependencies: []),`
- `products`に`.library`を追加する
  - 例えば`.library(name: "Api", targets: ["Api"]),`
  - `targets`の中は、`.target`で定義したものにする
- `Sources`配下に`.target`の`name`と同じディレクトリを作成する
  - 例えば`Api`
  - 適当にクラスを作成する

## ターゲットごとに使用する
- 例として、`Domain`Packageで`Infra`Package内のターゲット(モジュール)を使用する
- `dependencies`に`.package`を追加する
  - `.package(name: "Infra", path: "../Infra")`
- `targets`にモジュールを追加する

```swift
.target(
  name: "Domain",              
  dependencies: [                
    .product(name: "Api", package: "Infra"),                
    .product(name: "Store", package: "Infra")            
  ]),
```

## Domainを分ける
ロジックに相当する`Domain`を将来的な拡張を見据えて機能ごとに分割する。


## 考察
- サンプルでは、`DataStore`に機能ごとのパラメータが入ってしまうので、本当は分割した方が良いと思われる。
- サンプルでは、水平方向を中心に分割しているが、場合によっては垂直方向に分割した方が良い
- モジュールとして定義するSPMパッケージが多数になってしまう場合、１つのproductに対して複数のtargetを指定することでSPMパッケージを減らすのも手かも。

https://martinfowler.com/bliki/PresentationDomainDataLayering.html




