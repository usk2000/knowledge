# OGP生成のタイミング変更


Firestoreリスナー登録
https://cloud.google.com/firestore/docs/samples/firestore-listen-query-changes?hl=ja

Pet情報を別テーブルにするか→あまり現実的でない
userの情報監視で、petの変更を検知する

## 方針
Cloud Functionを使う。
タイムアウト・メモリについて設定可能にする
変更のあったpetのみを対象とする


## 詳細
Cloud Function
[Firebase Functionsでタイムアウト・メモリを変更](inkdrop://note/vuEqDIBTD)
- 実装はそこまで難しくなさそう
- 確認に時間がかかりそう
- お金がかかりそう

仕様
- usersを監視
- pet情報で差分を見る（対象の項目Only）
- 生成

## 実装
- Firebaseプロジェクト作成
- Cloud Function実装
- テスト