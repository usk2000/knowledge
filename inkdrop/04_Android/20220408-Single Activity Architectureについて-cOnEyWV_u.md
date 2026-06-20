# Single Activity Architectureについて


理想の方法をまとめる。


[Reasons to use Android Single-Activity Architecture with Navigation Component | OOZOU](https://oozou.com/blog/reasons-to-use-android-single-activity-architecture-with-navigation-component-36)
[Android Developers Blog: Use Android Jetpack to Accelerate Your App Development](https://android-developers.googleblog.com/2018/05/use-android-jetpack-to-accelerate-your.html?m=1)

https://developer.android.com/topic/libraries/architecture/viewmodel?hl=ja#sharing
Fragmentを複数使うことで、画面間での情報のやり取りをうまくやる。
→そもそも画面間での情報のやり取りがあるのが設計としておかしい。最小限に留め、画面の独立性を高める。

## デメリット
[A Single-Activity Android Application. Why not?! | by Dmitriy Rabetckiy | @RosberryApps | Medium](https://medium.com/rosberryapps/a-single-activity-android-application-why-not-fa2a5458a099)
[Jetpack Compose and the fall of Fragments |セドリック・F・ミディアム](https://sonique6784.medium.com/jetpack-compose-and-the-fall-of-fragments-54bf9977da1a)
[7 Common Mistakes Easily Made with Android Fragment | by Elye | Mobile App Development Publication | Medium](https://medium.com/mobile-app-development-publication/7-common-mistakes-easily-made-with-android-fragment-6fc85c44e783)

Single Acitivityにするべきかの質問
- Single Activityをするだけの十分な時間があるかどうか
- 画面遷移を全てテストできるかどうか
- 画面の状態を保存・復元できるか

Single Activityの方が1.5倍の工数がかかる
Multiの方がリソース消費が優れている。メモリ効率とか。
Singleの方がUXが優れている。画面遷移など。


* [ ] SharedViewModelを使おうと思えば全体で使えない？

## メリット


## 考慮するべきこと
- 画面間の依存関係
- 不必要なオブジェクト保持（つまりメモリーリーク）、バックスタックでのメモリ消費
- 1つのActivityに複数のFragmentを詰め込みすぎると、以下のことが難しくなる
  - Navigation Graph
  - ステート管理
  - 状態の復元
- 上記のことは可能なだけシンプルにするべき
- 実装するための時間もかかること
- テストするための時間がかかること

困難なこと
- テーマの適用

ナビゲーショングラフをどのようにするかが重要。

### Shared ViewModel

メリット
- ViewModelを利用すると、異なる画面間でステートを管理できるから便利

デメリット
- 管理が大変になる
- テストが大変になる
- スコープを誤ると大変になる

ユースケース
- List -> Detailパターン
- ギャラリー表示パターン：グリッド・リスト表示などの切り替え


[Fix your Android Memory Leaks in Fragments](https://engineering.procore.com/fix-your-android-memory-leaks-in-fragments/)

```
Google acknowledges the Fragment API’s flaws and is currently working on a solution to consolidate the two lifecycles into a single lifecycle. This solution may be released in the AndroidX Fragment 1.3.0 library. Depending on how they accomplish this, the solution described here may, in time, become obsolete.
```

  
  