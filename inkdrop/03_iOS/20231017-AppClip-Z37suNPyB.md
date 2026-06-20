# AppClip

調べる、実装してみる

- ログインできるか？
- Safari以外でもできるか？
- 今あるアプリに追加してみる

https://zenn.dev/d_date/articles/1a9539b7818729dfc228

[App Clipの概要 - Apple Developer](https://developer.apple.com/jp/app-clips/)

App Clipは1つのタスクをすばやく実行することに特化しています。そのため、ユーザーが数秒間のうちにタスクを開始して完了できることが理想的です。
ユーザーが完全版のアプリを簡単にダウンロードできるよう、App Clip内で適切なタイミングでダウンロードのオプションを表示することをおすすめします。

起動方法
- NFC
- AppClipコード・QRコード
  - AppClipコードは円形
  - QRコードもできそうか？
- App Clipリンク（メッセージ/他のアプリ）
- Smart App Banner
- マップ

[App Clipのリソース](https://developer.apple.com/jp/app-clips/resources/)

[App Clip Design](https://developer.apple.com/jp/design/human-interface-guidelines/app-clips/)


[App Clipの起動体験の構成](https://developer.apple.com/jp/documentation/app_clips/configuring_your_app_clip_s_launch_experience/)
> ユーザーがApp Clipに対応するAppをインストールすると、App Clipは完全版Appに置き換えられます。その時から、呼び出しを実行するとApp Clipの代わりに完全版Appが起動するようになります。そのため、完全版AppもWebサイトと関連付ける必要があります。また、完全版Appはすべての呼び出しに対応し、App Clipが持つ機能を提供する必要があります。

App Clipと完全版Appでは同じUniversal Linkで行けそう


ToDo
できるかどうか確認する
- ログイン
- Bluetooth接続
- Full Appへのリンク
- Pass parameter to App Clips
- 位置情報


作成してみる
[Xcodeを使ったApp Clipの開発](https://developer.apple.com/jp/documentation/app_clips/creating_an_app_clip_with_xcode/)

<https://developer.apple.com/documentation/app_clips/associating_your_app_clip_with_your_website>
ここの説明から、１つのURLに複数のAppClipをassociationできる？
AppClipとFull Appのつながりは？

### AppClip Code
[Creating App Clip Codes | Apple Developer Documentation](https://developer.apple.com/documentation/app_clips/creating_app_clip_codes)
[Encoding a URL in an App Clip Code | Apple Developer Documentation](https://developer.apple.com/documentation/app_clips/creating_app_clip_codes/encoding_a_url_in_an_app_clip_code)

### 使えるフレームワーク

[Choosing the right functionality for your App Clip | Apple Developer Documentation](https://developer.apple.com/documentation/app_clips/choosing_the_right_functionality_for_your_app_clip)

> However, the following frameworks provide no functionality at runtime: [App Intents](https://developer.apple.com/documentation/appintents), [Assets Library](https://developer.apple.com/documentation/assetslibrary), [Background Tasks](https://developer.apple.com/documentation/backgroundtasks), [CallKit](https://developer.apple.com/documentation/callkit), [CareKit](https://developer.apple.com/documentation/carekit), [Contacts](https://developer.apple.com/documentation/contacts), [Contacts UI](https://developer.apple.com/documentation/contactsui), [Core Motion](https://developer.apple.com/documentation/coremotion), [EventKit](https://developer.apple.com/documentation/eventkit), [EventKit UI](https://developer.apple.com/documentation/eventkitui), [File Provider](https://developer.apple.com/documentation/fileprovider), [File Provider UI](https://developer.apple.com/documentation/fileproviderui), [HealthKit](https://developer.apple.com/documentation/healthkit), [HomeKit](https://developer.apple.com/documentation/homekit), [Media Player](https://developer.apple.com/documentation/mediaplayer), [Messages](https://developer.apple.com/documentation/messages), [Message UI](https://developer.apple.com/documentation/messageui), [Nearby Interaction](https://developer.apple.com/documentation/nearbyinteraction), [PhotoKit](https://developer.apple.com/documentation/photokit), [ResearchKit](https://researchkit.org/), [SensorKit](https://developer.apple.com/documentation/sensorkit), and [Speech](https://developer.apple.com/documentation/speech).

とあるので、これらは使えない。他は使える。


### 使っているサービス
[コカ・コーラ自販機が、アップルの謎のミニアプリ｢App Clip｣対応した理由 | Business Insider Japan](https://www.businessinsider.jp/post-241542)
[ミニアプリ時代が日本にも到来？ 「App Clips」を東京のカフェで使ってみた | Coral Capital](https://coralcap.co/2020/10/app-clips-and-miniapps/)
