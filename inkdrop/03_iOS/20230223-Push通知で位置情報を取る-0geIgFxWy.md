# Push通知で位置情報を取る

位置情報を取る実装をテスト

- アプリ側の実装をする
- 端末BにコマンドラインからPush通知を送る。レスポンスを見る
  - [Push通知をコマンドラインから送る](inkdrop://note/3AwE37J-w)
- 端末BにBackend/Firebaseから位置情報リクエストを送る
  - 端末Bからログを取れそう？
- 端末Aから端末Bに位置情報をリクエストし、位置情報を取得、そして端末Aに結果を戻す
  - Backendが必要？Firebase Cloud Messagingで行けそう？

[Sending Notification Requests to APNs | Apple Developer Documentation](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/sending_notification_requests_to_apns)
apns-push-typeでlocationを設定すると送れそう

[Push通知オプション](inkdrop://note/X9tWr55Jb)

やることが多そうなので、時間があるときに調べる

https://github.com/usk-sample/PushNotificationSample-iOS
このサンプルをベースにする。

