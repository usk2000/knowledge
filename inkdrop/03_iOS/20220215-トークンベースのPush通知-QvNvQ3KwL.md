# トークンベースのPush通知

[サイレントPush通知について調べる](inkdrop://note/mGI4djpHA)

* [ ] トークンベースのPush通知を試してみる。

## APNsと通信を確率する
[Establishing a Token-Based Connection to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns)
こちらはTokenベース。証明書ベースとは異なる。

### JWT token生成
[Establishing a Token-Based Connection to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token-based_connection_to_apns)
[JWT の生成と検証](https://nodejs.keicode.com/nodejs/jwt-basics.php)
[【JWT（JSON Web Token）】Node.jsで実際に使ってみた - Qiita](https://qiita.com/sa9ra4ma/items/67edf18067eb64a0bf40)

### 通信

[RFC7540 日本語訳](https://summerwind.jp/docs/rfc7540/)
[Node.jsのhttp2モジュールを使ってServer Pushの送信/受信を試す – STDOUT](https://stdoutblog.com/posts/20200511-node-http2-server-push/)
[HTTP/2 | Node.js v17.5.0 Documentation](https://nodejs.org/api/http2.html#class-http2session)

HTTP/2でないと受け付けないかも。本を探そう。

[A Complete Guide to HTTP/2 in Node.js (With Example Code)](https://www.sohamkamani.com/nodejs/http2/)
