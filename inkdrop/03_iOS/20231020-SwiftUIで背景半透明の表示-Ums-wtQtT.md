# SwiftUIで背景半透明の表示


[Transitionアニメーション](inkdrop://note/qE56OkxZs)
[SwiftUI overlay表示](inkdrop://note/CemJNOfUG)
https://zenn.dev/usk2000/scraps/99df702068c223

SwiftUIで背景半透明のViewを表示したい。
具体的には、カスタムalert viewやdrawer menu。
考えられる方法としては２つある。
１つ目の方法の実装とメリット・デメリット
２つ目の方法の実装とメリット・デメリット
２つの方法を比べてみて、状況ややりたいことによってどちらを使えば良いかのガイドになれれば嬉しい。

表示したいもの
- カスタムalert view
- drawer menu
どちらも背景が半透明

考えられる方法
- `.fullScreenCover`
  - Modifierでできる
  - iOS16.4以降と未満では実装方法が異なる
  - アニメーションをdisableにするのがベスト
  - drawer menuなどのスライドアニメーションはできない
- ZStack
  - ベーシックな実装方法
  - 様々なアニメーションができる

https://zenn.dev/usk2000/articles/9f276edfd9008a



