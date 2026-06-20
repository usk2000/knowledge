# Firebase Javascript SDKの追加方法

[Firebase を JavaScript プロジェクトに追加する](https://firebase.google.com/docs/web/setup?hl=ja#create-firebase-project-and-app)
V9から大きく変わったみたい。

> ESM を使用していて、ブラウザ モジュールを使用する場合は、すべての import 行を次のパターンで置き換えてください。
import { } from 'https://www.gstatic.com/firebasejs/9.0.2/firebase-SERVICE.js' 
（SERVICE は firebase-firestore などの SDK 名です）。
ブラウザ モジュールは手軽な方法ですが、本番環境ではモジュール バンドルを使用することをおすすめします。

この方法を使う。

[Firebase SDKの読み込みを遅らせる](https://firebase.google.com/docs/web/learn-more?hl=ja#delay-sdks-cdn)

グローバル変数を定義してfirebaseを使いたい。
https://stackoverflow.com/questions/51547745/access-variables-defined-in-script-tag-with-type-module
→script moduleを直さなくてはならないので、やらない？

https://zenn.dev/mktu/articles/3905b13500ffb6
→compat形式の方法を使う。
CDNではどうやるんだろう。compatのURL探さなくちゃ。

https://engineering.linecorp.com/ja/blog/you-dont-need-default-export/



