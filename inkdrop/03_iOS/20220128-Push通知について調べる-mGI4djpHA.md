# Push通知について調べる


その場合もタイトルを出すかどうか。
どのような処理が必要かどうか。
ボタンの処理を調べる：iOS/Android
マトリックスを作る
https://qiita.com/chocoyama/items/56cd3ac2daaf69dffa0f

https://mobilefirstplatform.ibmcloud.com/blog/2020/07/21/rich-push-notifications/

* [x] iOS Silent Pushについては、後ほどFCMを介さない方法で調べ直す。Node.jsで送信する
* [ ] Silent Pushについて、記事を確認してFCMで試す
* [x] Androidについては調べる
* [ ] 記事にする。Foreground、Background、通知タップした時の状態（アプリキル・バックグラウンド）・通知タップしなかった場合の挙動
* [ ] どのような通知タイプがあるかまとめる
* [x] 通知を許可しなかった時の挙動
* [ ] 
調べて作れたらマネタイズしたいな。

# iOS

Push通知タイプ
https://zenn.dev/attomicgm/articles/about_ios_push_type

Push通知を簡単に送る
https://qiita.com/koogawa/items/85c0dd0abd2f1970c5fc

[User Notifications](https://developer.apple.com/documentation/usernotifications/)
https://developer.apple.com/documentation/usernotifications/unusernotificationcenterdelegate

### Server-side implementation
[Generating a Remote Notification](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification)
[Sending Notification Requests to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns)
[Handling Notification Responses from APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/handling_notification_responses_from_apns)

> Use the production server for your shipping apps and the development server for testing. When sending many remote notifications, you can establish multiple connections to these servers to improve performance. For example, if you have multiple provider servers, each one can establish its own connection.
> 

複数サーバからコネクションを貼ることで、パフォーマンスを上げることができる

### バックグラウンド通知について
[Implementing Background Push Notifications](https://developer.apple.com/documentation/usernotifications/implementing_background_push_notifications)
[Pushing Background Updates to Your App](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/pushing_background_updates_to_your_app)

https://stackoverflow.com/questions/31450403/didreceiveremotenotification-not-working-in-the-background

https://developer.apple.com/forums/thread/652649
シミュレータではできなさそう。

didReceiveNotificationが呼ばれるタイミング。Background Modesで挙動が違いそう。
https://stackoverflow.com/questions/32061897/ios-push-notification-how-to-detect-if-the-user-tapped-on-notification-when-the
- フォアグラウンド状態
- タップしたかどうか
- バックグラウンドモード有無
- タスクキル状態かどうか
- Notification Centerにあるかどうか→やらない方が良い
 
あくまで即時反映のためにPush通知は使うべき

- Background Modeなし
  - Foreground
    - 通知時：willPresent
    - タップ時：didReceived
  - Background
    - 通知時：なし
    - タップ時：didReceived
- Background Modeあり（実機のみ）（予想）
  - Foreground
    - 通知時：willPresent
    - タップ時：didReceived
  - Background
    - 通知時：didReceived
    - タップ時：didReceived



[FCMセットアップ](https://firebase.google.com/docs/cloud-messaging/ios/first-message?hl=ja#send_a_notification_message)
[FCMサイレントプッシュ](https://firebase.google.com/docs/cloud-messaging/ios/receive?hl=ja#handle_silent_push_notifications)

後で調べること
- BGAppRefreshTaskについて
- APNsの詳細仕様
  - [Sending Notification Requests to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns)


## リッチPush通知
[Handling Notifications and Notification-Related Actions](https://developer.apple.com/documentation/usernotifications/handling_notifications_and_notification-related_actions)
[Declaring Your Actionable Notification Types](https://developer.apple.com/documentation/usernotifications/declaring_your_actionable_notification_types)
[Modifying Content in Newly Delivered Notifications](https://developer.apple.com/documentation/usernotifications/modifying_content_in_newly_delivered_notifications)

- 最初に定義する必要がある。つまり、動的に指定はできない
- 途中でカテゴリを変更できるかどうか
- テキストフィールドも入力できそう
- UNNotificationActionOptions
- メディアとかの追加
  - https://qiita.com/jollyjoester/items/70bc862c64384de8b082
  - 

データを編集する時は、デバイスロックが外れているチェックが必要
> If your response to an action involves accessing files on disk, consider a different approach. Users can respond to actions while the device is locked, which would make files encrypted with the complete option unavailable to your app. If that happens, you may need to save changes temporarily and integrate them into your app’s data structures later.
> 

> Call this method at launch time to register your app’s actionable notification types. This method registers all of your categories at once, replacing any previously registered categories with the new ones in the categories parameter. Typically, you call this method only once.
> 

Internationalizationができない？
> title
> The localized string the system displays to the user.
> 

なので、動的なInternationalization変更はできなさそう。アプリ起動時のタイミングのみ

[[SiriKit] Intent App Extension](inkdrop://note/QqnW-Y4cL)

# Android
[Push通知](inkdrop://note/7IqAdeWOc)

# FirebaseでPush通知
https://firebase.google.com/docs/cloud-messaging

トークンは定期的に更新する必要がありそう。
https://firebase.google.com/docs/cloud-messaging/manage-tokens?authuser=0#update-tokens-on-a-regular-basis

[Firebase CloudMessagingのログの監査](https://firebase.google.com/support/guides/cloud-audit-logging/firebase-cloud-messaging)
あまり役に立たないかも。特にAPNs。

## iOS
[セットアップ](https://firebase.google.com/docs/ios/setup)
- Firebaseプロジェクトにアプリ追加、初期化まで
- P12ファイルの作成: https://qiita.com/natsumo/items/d5cc1d0be427ca3af1cb#7-apns用証明書p12-の作成
- Firebaseにp12を登録
- keyの方が良いかも

SwiftUIでは@mainで定義したところのinitializerで`FirebaseApp.configure`を実行するしかない？
→`@UIApplicationDelegateAdaptor`で定義して実行する


### メッセージ配信のBigQueryへの連携
https://firebase.google.com/docs/cloud-messaging/understand-delivery?authuser=0&platform=ios#enable-message-delivery-data-export

## サーバ側からREST API
https://firebase.google.com/docs/cloud-messaging/server?authuser=0
https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages?authuser=0#apnsconfig

curlで送信する
https://firebase.google.com/docs/cloud-messaging/migrate-v1?hl=ja
https://firebase.google.com/docs/cloud-messaging/send-message?hl=ja#send_using_the_fcm_v1_http_api
https://firebase.google.com/docs/admin/setup?hl=ja

共通データ
- message.notification.title
- message.notification.body
- message.data

プラットフォーム固有のデータ
https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages?hl=ja

細かいオプション
https://firebase.google.com/docs/cloud-messaging/http-server-ref

## サイレントプッシュ

https://qiita.com/shiba1014/items/099f8e7aa37d5e2540da

```
`Invalid JSON payload received. Unknown name "content_available" at 'message.apns': Cannot find field.`
```
https://stackoverflow.com/questions/40807397/firebase-fcm-silent-push-notifications-for-ios

調査の結果、FCMからではSilent Pushは送ることができていなそう。
Appleのドキュメントをよく読む必要がある。

[Firebase Cloud Messasingでのサイレント通知とアラート通知の送り分け方法](https://irimasu.com/how-to-set-up-silent-and-alert-notifications-in-firebase-cloud-messaging)
→余計な設定が不要なのかも。