# Native / Cross-platform / hybrid app


ポイント
* パフォーマンス
* コスト
  * 人的コスト
  * 技術的コスト
* 採用の難しさ
* 



前提として、Nativeの機能を使う必要がある

[Native vs. Cross-Platform Mobile App Development: 9 Factors to Consider](https://www.scnsoft.com/blog/9-factors-to-consider-when-choosing-a-mobile-platform)
[Flutter vs React-Native: comparison in depth](https://vvsevolodovich.dev/flutter-vs-react-native-comparison-in-depth/)
[Mobile App Security: Native v.s. Flutter](https://www.linkedin.com/pulse/mobile-app-security-native-vs-flutter-rick-wu)
[Flutter vs Native Comparison - Surf](https://surf.dev/flutter-vs-native/)
[【Flutter入門】100画面を超える規模のアプリを開発してみた感想 | 東京のアプリ開発会社](https://pentagon.tokyo/app/2937/#toc_id_1_2)
[Flutter FAQ 🇯🇵. よく目にするFlutterに関する疑問への私感 | by mono  | Flutter 🇯🇵 | Medium](https://medium.com/flutter-jp/faq-f885a6494a8)
[Flutter vs. React Native: Which is Better in 2023 | Backendless](https://backendless.com/flutter-vs-react-native-which-is-better-in-2023/#pros-and-cons)
[クロスプラットフォーム FlutterとReact Native を徹底比較 | DS SOLUTION, INC.](https://www.dssolution.jp/ja/compare-flutter-react-native-cross-platform/)

### メンテナンス性
- Native機能を使っているか
- 3rd party SDKを利用している場合、そのクオリティ
- Major Updateへの対応, Flutterはまだ多い。React Nativeはsteep

メンテナンス性についてまとめる


### 3rd party SDK
nativeもflutter/RNもどれもFramework/SDKが豊富。
しかし、flutter/RNでカバーしていない機能のFramework/SDKがあったり、flutterではメンテナンス・品質が悪いものがある。


### Slack Channelで

Which App Features are Better Suited to Native
App Development?
React Native
■
If the goal is to build an Android-only app, then it
is better to go native. Currently iOS has better
support than Android.
■
If Bluetooth is a must-have feature in your
desired app build, this can be more complex
than anticipated to implement.
■
Not a good choice for developing an app that
requires many interactions, animations, screen
transitions or complex gestures. However,
there’s a gesture responder system that runs
the life cycle of all gestures in the app.
■
When it comes to screens with complex
gestures, developers might face some
difficulties as the Android and iOS touch
subsystems are too different for using a unified
API.
Flutter
■
The design of the app needs to be platform-specific.
■
A requirement of the app is that it must be small
in size, such as instant apps.
■
No Dart programming skills in the developer
team.
■
Bluetooth connection via an app can also be
difficult.
■
If you intend to use a specific native library not
available in the Flutter repository during app
development then customized platform
channels, separate for Android and iOS, will
have to be implemented by developers.
■
Developing AR/VR applications. Using Unity3D
or Unreal Engine tools is a better choice since
they support numerous devices, which allow
you to develop such apps faster and with more
support.

----
Separation of Concerns: Because in Flutter there is no clear separation between your business logic and your UI code, so you have to manage that yourself.
UI State Management: For Bigger apps, UI is usually a bit too complex to manage. In such cases, to manage the state of your UI, you need to have a good understanding of Packages like provider to help you write better UI Code that is reactive to data changes and gives your app a smooth User Experience.
Manage dependencies, flutter version and native SDKs get harder and harder when major updates are released
