# Test実践

Github APIの検索APIを使い、テストを実践する。
なるべくライブラリは使わない

## 機能
- Github Search APIを使用
- Combineを使用
- 文字列から検索を行う
  - 文字列は３文字以上
  - 文字を数秒打たなかったら検索開始
- 検索結果をリスト表示
  - ページングも可能
- リポジトリ詳細画面に遷移する
- ユーザ画面に遷移する
- LICENSE画面に遷移する

## テスト項目

### Model
* [x] サンプルデータによるDecoding

### API
* [x] HTTPStubによる通信処理差し替え
* [x] 正常系
* [x] 正常系（別のクエリ）
* [x] 異常系

### ViewModel
* [x] Protocolによる通信処理のスタブ
* [x] 結果の確認
* [ ] さらに読み込む機能


### E2Eテスト
* [x] Github APIとの疎通確認
* [x] UITest

### その他
* [ ] エラーの変更

## 参考
https://qiita.com/hcrane/items/4778d7951cd0e1611f5b

Combineのハンドリング
https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine
→この記事だけでも１つの記事がかけるな。

Just
https://developer.apple.com/documentation/combine/just
Failure
https://developer.apple.com/documentation/combine/fail

Result.Publisher
https://developer.apple.com/documentation/swift/result/publisher

Error Type変更
https://stackoverflow.com/questions/60689807/how-to-change-error-type-from-never-to-error-in-combine
https://www.donnywals.com/changing-a-publishers-failure-type-in-combine/
→後でやってみる
mapErrorが使えそう

## 所感
- APIのスタブクラス・Protocolは作成しない。HTTPStubsで十分
- E2Eはコストが高いので、Unit Testをメイン、UIの表示テストは行う
- 