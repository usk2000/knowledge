# Auth0


https://github.com/auth0/Auth0.swift
https://auth0.com/docs/quickstart/native/ios-swift/00-login

* [x] 無料で使えそうなので、使ってみる。
* [x] Backendも含めた開発
* [ ] アウトプット
* [ ] nativeでの実装


hasegawa.allround@gmail.com


- 他の端末ログインで自動ログアウトが実現できるか

v2がリリース準備中みたい
https://github.com/auth0/Auth0.swift/issues/637
これを待つか？いつになるかわからないので、とりあえず機能を確認していく。

## セットアップ
- ログイン(Googleとか) 
- リージョン選択、Japan
- テナントIDを入力

## アプリ作成
- Create Application
- Native
- Auth0.plistを追加
- Info.plistに追加


## 実装

### ログイン
[Auth0 iOS Swift SDK Quickstarts: Login](https://auth0.com/docs/quickstart/native/ios-swift/00-login)

### 認証状態の確認
[Auth0 iOS Swift SDK Quickstarts: User Sessions](https://auth0.com/docs/quickstart/native/ios-swift/03-user-sessions)
- CredentialsManager


### API呼び出し
[Auth0 iOS Swift SDK Quickstarts: Calling APIs](https://auth0.com/docs/quickstart/native/ios-swift/04-calling-apis)

Backendの準備
[Auth0 Node (Express) API SDK Quickstarts: Authorization](https://auth0.com/docs/quickstart/backend/nodejs)
こちら実行中

[Node.jsアプリをGAEにデプロイ](inkdrop://note/j8KFPdpph)


* [x] Get the User's Access Token
* [x] Attach the Access Token
* [x] Send the Request

### Authorization
[Auth0 iOS Swift SDK Quickstarts: Authorization](https://auth0.com/docs/quickstart/native/ios-swift/05-authorization)

ここのページにルールを追加する
https://manage.auth0.com/dashboard/jp/usk-auth0-sample/rules/new


### Linking Accounts
[Auth0 iOS Swift SDK Quickstarts: Linking Accounts](https://auth0.com/docs/quickstart/native/ios-swift/07-linking-accounts)

### Touch ID Authentication
[Auth0 iOS Swift SDK Quickstarts: Touch ID Authentication](https://auth0.com/docs/quickstart/native/ios-swift/08-touch-id-authentication)

### Multi-Factor Authentication
[Multi-Factor Authentication (MFA)](https://auth0.com/docs/secure/multi-factor-authentication)

### Token Expiration
トークンの期限切れの際にどうするか。

Access Token
[Update Access Token Lifetime](https://auth0.com/docs/secure/tokens/access-tokens/update-access-token-lifetime)
default: 24hr
max: 30days

Refresh Token
[Configure Refresh Token Expiration](https://auth0.com/docs/secure/tokens/refresh-tokens/configure-refresh-token-expiration)
Default	2,592,000 seconds (30 days)
Minimum	1 second
Maximum	31,557,600 seconds (1 year)


[Native Login](https://auth0.com/docs/authenticate/login/native-login)
[Centralized Universal Login vs. Embedded Login](https://auth0.com/docs/authenticate/login/universal-vs-embedded-login)
Universal Loginを推している

## Credential

Credentialを保存できる。

[Auth0.swift: Credentials Manager](https://auth0.com/docs/libraries/auth0-swift/auth0-swift-credentials-manager)
