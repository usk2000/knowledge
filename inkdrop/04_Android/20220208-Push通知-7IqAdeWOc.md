# Push通知

* [x] 通常通知が表示されない件。マニュアルしかないのか？システムトレーにも来ないのは調べる必要がある
* [x] 通知からアクティビティを起動するを読む
* [x] アプリキル状態の受け取りを調べる
* [x] もしかしたらGCMが必要か調べる→ない
* [x] マルチモジュールで定義をInfraに持ってこれるか。Domainの下に持ってくる。依存関係でapp/Manifest.xmlで定義しなくてはならなさそう
* [x] 通知用のServiceからアプリ本体に伝えることはできるのだろうか
* [ ] 通知パターンを記事にする。foreground、background、ペイロード有無
* [ ] 通知の種類、表示
* [ ] 通知を拒否した場合の挙動


## 実装
[Android で Firebase Cloud Messaging クライアント アプリを設定する](https://firebase.google.com/docs/cloud-messaging/android/client?hl=ja)
[メッセージを受信](https://firebase.google.com/docs/cloud-messaging/android/receive?hl=ja)
https://qiita.com/nk5jp/items/841096efa0903cb72d58

[click_action](https://firebase.google.com/docs/cloud-messaging/http-server-ref?hl=ja#notification-payload-support)
[通知を作成する](https://developer.android.com/training/notify-user/build-notification)
[ブロードキャスト](https://developer.android.com/guide/components/broadcasts)
[通知チャネルを作成して管理する](https://developer.android.com/training/notify-user/channels)

> FirebaseMessagingService を継承したサービス。これは、バックグラウンド時にアプリで通知を受け取る処理よりも高度なメッセージ処理を行う場合に必要になります。フォアグラウンド時のアプリで通知を受け取る、データ ペイロードを受信する、アップストリーム メッセージを送信するなどの場合は、このサービスを継承する必要があります。
> 

バックグラウンド時でも受け取れそう。

- フォアグラウンド：`onMessageReceived`が呼ばれる。
- バックグラウンド：Tap時にMainActivity.onCreateで呼ばれる。
  - `FirebaseMessagingService.handleIntent`が呼ばれるが、これは使わない方が良さそう
- アプリキル状態：？
  - おそらく、FirebaseMessagingServiceは動き続ける。adbをdetachなどはbootした状態に近い
  - https://stackoverflow.com/questions/68325361/firebasemessagingservice-doesnt-restart-after-device-reboot-or-after-app-is-kil
- `handleIntent`を実装している時は、自前で表示実装する必要がある
  - PendingIntentで呼ぶ画面もしくは処理を決定する


アプリキル時の受け取り
```
broadcast intent callback: result=CANCELLED forIntent { act=com.google.android.c2dm.intent.RECEIVE
```
https://stackoverflow.com/questions/39480931/error-broadcast-intent-callback-result-cancelled-forintent-act-com-google-and
→いまいちよくわからないが、とりあえず`Service`は動き続けていると仮定する。


### 異なるActivityを起動する
[通知からアクティビティを起動する](https://developer.android.com/training/notify-user/navigation?hl=ja)
`FirebaseMessagingService.handleIntent`の実装が必要

## アクションボタン付き
[アクションボタンを追加する](https://developer.android.com/training/notify-user/build-notification#Actions)

Push通知で追加するためには、`handleIntent`の実装が必要
https://stackoverflow.com/questions/37458202/add-action-to-firebase-notification

方針としては、
- 通知を受け取る
- handleIntentで処理する
- カスタムアクション付きの通知をアプリ内で作成する

受け取ったら２通りの処理。
- BroadcastReceiverで処理だけ
- 通常のIntentで画面起動

----


https://qiita.com/nk5jp/items/841096efa0903cb72d58
https://developer.android.com/guide/topics/ui/notifiers/notifications?hl=ja
https://www.orefolder.net/2020/11/silent-notification/

[バックグラウンド アプリの通知メッセージの処理](https://firebase.google.com/docs/cloud-messaging/android/receive?hl=ja#backgrounded)

https://stackoverflow.com/questions/39777977/firebasemessagingservice-intent-putextra-does-not-work-if-app-is-not-running
バックグラウンドでもできそう？

https://irimasu.com/how-to-set-up-silent-and-alert-notifications-in-firebase-cloud-messaging
→Androidでは、アプリが動いていない状態だと何もできないかも。

サービス常駐
https://developer.android.com/guide/components/services?hl=ja
https://firebase.google.com/docs/cloud-messaging/android/receive?hl=ja#restricted
https://akira-watson.com/android/service.html
https://stackoverflow.com/questions/49376609/run-intentservice-in-background-in-android-o
難しそう、Android O以降で制限される。


https://stackoverflow.com/questions/30797193/handle-parse-push-notifications-while-app-is-not-running-android

https://stackoverflow.com/questions/61321878/handle-android-push-notification-when-app-is-not-running-like-whatsapp-twitter
https://stackoverflow.com/questions/44790495/push-notifications-when-app-is-closed-wakefulbroadcastreceiver-not-running-in-a
できそうかな。

## Action付きNotification

https://developer.android.com/training/notify-user/build-notification?hl=ja#Actions
https://firebase.google.com/docs/cloud-messaging/android/receive?hl=ja#backgrounded
https://stackoverflow.com/questions/41907144/push-notification-with-action-button-is-not-working

## ダイレクトブート関係
[ダイレクト ブート モードをサポートする](https://developer.android.com/training/articles/direct-boot)
https://firebase.google.com/docs/cloud-messaging/android/receive?hl=ja#receive_fcm_messages_in_direct_boot_mode

## マルチモジュールのInfraに置く場合

- appのAndroidManifest.xmlにサービスの定義を書く必要がある？→これが一番確実そう
- そうなると、InfraにFirebaseMessagingServiceのサブクラスを作る→Domainで先程のサブクラスをさらにサブクラスにする
- 

[複数のマニフェスト ファイルをマージする](https://developer.android.com/studio/build/manifest-merge?hl=ja)
[公開するリソース](https://developer.android.com/studio/projects/android-library#PrivateResources)


## ServiceからActivityに伝える
[バインドされたサービスの概要](https://developer.android.com/guide/components/bound-services?hl=ja)
https://android.keicode.com/basics/services-bound-with-ibind.php

通常はこの方法だが、Firebaseの場合うまくいかないので、こちらの方法を使う
https://stackoverflow.com/questions/62708466/firebasemessagingservices-onbind-method-is-final-how-make-it-bound-service

