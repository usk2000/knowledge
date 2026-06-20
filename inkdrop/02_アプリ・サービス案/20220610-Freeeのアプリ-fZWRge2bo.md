# Freeeのアプリ


https://developer.freee.co.jp/reference

### 人事ろうむ
[人事労務API 概要 - freee Developers Community](https://developer.freee.co.jp/reference/hr)

- 打刻
  - 出勤・退勤
  - brb: 15min
  - 休憩：0.5h
  - お昼休み：1h
- 月時勤怠
  - 表示
  - 編集

CoreNFCを使って勤怠を管理するのも良いかも


### 会計
[会計API 概要 - freee Developers Community](https://developer.freee.co.jp/reference/accounting)


# 開発

### 開発用アカウント
本番用には、事業所名とかをきちんとする。
「開発用テストアプリ」でまずは進める。

### 認証
[OAuth対応](inkdrop://note/UTh8-BBWU)

### 最初のアクセストークン
ae8d9952367f8233fcc322f34f525131ae9d7e13c0865508a63ec9d49ebd6c85

## スタートガイド

[freee API スタートガイド - freee Developers Community](https://developer.freee.co.jp/startguide)

## Auth認証

ログイン後
```
https://accounts.secure.freee.co.jp/public_api/authorize?client_id=fa3a4abfbe4bac1a0c8ea81ad87070769e7b284a55f10dd3e3ab5ddbd6fc8f17&redirect_uri=https%3A%2F%2Fapp.secure.freee.co.jp%2Fdevelopers%2Fstart_guides%2Fapplications%2F18173%2Ftoken%3Fcompany_id%3D3802560&response_type=token
```

許可後
```
https://app.secure.freee.co.jp/developers/start_guides/applications/18173/token?company_id=3802560#access_token=88195867c052620690630d4219359c97aafa82001aaec9d15c5cd7fced6d9484&token_type=bearer&expires_in=86400
```

このURLは、callback URLで設定したものになっている。
1. 独自ページにリダイレクトする？
2. それか、このまま使用するか

ここでは、callback URLを渡すようにして、後ほど変えることができるようにする


- 認可コード(authorize API)
- アクセストークン
  - [アクセストークンを取得する - freee Developers Community](https://developer.freee.co.jp/startguide/getting-access-token)
  - リフレッシュトークンもここで取れる

もう一度やってみる



## ドキュメント
DocCでドキュメント書いてみる
[Swift DocC](inkdrop://note/St21gSaKq)
