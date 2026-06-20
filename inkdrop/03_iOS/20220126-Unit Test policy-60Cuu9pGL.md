# Unit Test policy

## TODO
- CodeCoverage(iOS/Android)を調べてアウトプット
- テスト結果も


## 基本項目
- インプットとなる値
  - 同値分割：分割されたグループ
  - 境界値
  - 単項目チェック：組み合わせの場合。マトリックスにする
  - とり得る値を過不足なく網羅する
- ロジック網羅性
  - Code Coverage
- アウトプット
  - 出力結果の確認

## 方法
- Tool
  - iOS: XCTest, Android: JUnit
  - Library: ?
  - mock library
    - iOS: XCTest, 
    - Android: mockito

## 用語
- スタブ：ダミーの結果を返す
- モック：ダミーの結果を返す＋回数を記録する
- スパイ：２つの本物のクラスの間に挟み、回数などを記録する

## 方針
- 入出力を網羅する
- ロジックを網羅する
- 外部はモック/スタブとする（APIレスポンス、位置情報など）

## 大きな方法
- テスト方針を決める
- テストを書く
  - 仕様から
  - 想定されるクラスのメソッドから
- プロダクトコードを書く
- テストコードを修正する
- PRを出す

## Tool

### Code Coverage
iOS
https://zenn.dev/yorifuji/articles/xcode-code-coverage
https://medium.com/xcblog/xccov-xcode-code-coverage-report-for-humans-466a4865aa18
→ここら辺が良さそう

Android
https://qiita.com/keidroid/items/adc4f065b84d8a2cd17a
https://github.com/Kotlin/kotlinx-kover
→これ使えそう

