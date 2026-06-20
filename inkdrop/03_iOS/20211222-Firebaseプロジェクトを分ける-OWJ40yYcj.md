# Firebaseプロジェクトを分ける


prod, staging, develop, qa, mockなどの環境がある。
iOS/Androidでそれぞれのスキームor
(mockについてはFirebaseを使わないので、必要ないと考えられる)

→サンプルを作ってみる

## 全て分ける場合
全ての環境ごとに分けると管理が大変になる

- Firebaseプロジェクト自体
- バンドルID
- Push通知証明書(iOS)

## 一部分ける場合
大きく分けて本番・開発に分ける

- Firebaseプロジェクトは２つ
- バンドルIDも２つ
- Push通知証明書も２つ
- staging, develop, qaはScheme or Flavorで分ける
- どの環境かをコードで指定しないと

## 補足
- APIエンドポイント数はFirebaseのプロジェクト数とは別に考える。１対１で考える必要がない。
- 

