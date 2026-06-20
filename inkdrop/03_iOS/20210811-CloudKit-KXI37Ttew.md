# CloudKit

https://developer.apple.com/documentation/cloudkit

## CloudKitを使うべきか
https://developer.apple.com/documentation/cloudkit/determining_if_cloudkit_is_right_for_your_app

- ファイルとして保存
  - 同期するファイルをきめ細かく制御できる
  - 比較的簡単
- Key-Value
  - 少数のデータ保存に最適
  - 型は限られる
- CloudKit with CoreData
  - オブジェクトとして
  - CoreDataのように使える
  - 細かい制御しない
  - 個人データのみの同期
- CloudKit
  - オブジェクトとして
  - どのデータを同期するかなどの細かい制御ができる
  - 他社とデータが共有できる


- 保存形式：ファイル・Key-Value・オブジェクト
- 制御：細かくする・しない
- 他社と共有する
- 他アプリと共有する

## テキストベースのスキーマ編集
[CloudKit Schema Language](inkdrop://note/5-xKjdqK8)

## アカウント関係
iCloudが使えるかどうか
https://developer.apple.com/documentation/foundation/filemanager/1408036-ubiquityidentitytoken

アカウントステータス
https://developer.apple.com/documentation/cloudkit/ckcontainer/1399180-accountstatus


## 編集
https://developer.apple.com/documentation/cloudkit/local_records
https://developer.apple.com/documentation/cloudkit/ckmodifyrecordsoperation

### IDから複数レコードを取得

https://stackoverflow.com/questions/42338849/fetching-multiple-records-by-record-name

### サポートされているPredicate

https://developer.apple.com/documentation/cloudkit/ckquery

# 調べること
- [ ] recordZone


# つまずき

NSPredicateでnil比較できない
https://stackoverflow.com/questions/39970928/ckquery-using-nspredicate-searching-for-nil-always-throws-an-invalid-expression
→Boolにする

Widgetからアクセスすると
```
Bad Container" (5/1014); "Couldn't get container configuration from the server for container
```


ここかな
```swift
CKContainer.default().publicCloudDatabase
```
defaultを使っているから。
https://developer.apple.com/documentation/cloudkit/ckcontainer/1399193-init
→これを使おう。

weak selfで定義したロジック部分で、nilになる
→呼び出し元がTimelineProviderなどの`struct`の場合、変数として持っていないとならない。
func内で使っている場合、selfがnilになる。

Boolはないので、Intでどうにかする
```swift
struct SampleModel {  
  var archived: Int  
}

extension SampleModel {
  var isArchived: Bool {
    set { self.archived = newValue ? 1 : 0 }
    get { return self.archived != 0 }
  }
}
```
