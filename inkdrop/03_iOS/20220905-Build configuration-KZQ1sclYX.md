# Build configuration


https://ali-akhtar.medium.com/managing-different-environments-using-xcode-build-schemes-and-configurations-af7c43f5be19

https://dev.classmethod.jp/articles/xcode-build-environment-adding-scheme/

https://tanaschita.com/20220214-managing-different-ios-environments-in-xcode/

https://medium.com/@danielgalasko/change-your-api-endpoint-environment-using-xcode-configurations-in-swift-c1ad2722200e

https://qiita.com/hirothings/items/7f6943db609ff88c10be
Configuration fileを元に、SchemeごとにDebug/Releaseで設定する
→Dev Debug/Dev Releaseとかconfigurationを作らなくて済む
Scheme１つにつきAPI endpoint１つとか
→アウトプットしてみる

https://softmoco.com/devenv/how-to-manage-multiple-environment-settings-in-xcode.php

xcconfigを書き出す。
https://qiita.com/gin0606/items/64855bb96570d875f231
https://github.com/toshi0383/xcconfig-extractor
→使えなさそう

XcodeGen
https://github.com/yonaskolb/XcodeGen
https://blog.mothule.com/ios/xcodegen/ios-xcodegen-settings
https://qiita.com/hcrane/items/501100ee9abd5d3b1295
まだxcodeporjからymlはできなさそう

結論
Configurationを自動で取り出しファイル化するのは時間がかかりそう。
コマンドを使うよりも、自分で作成する。（xcconfig-extractorのアイディアは使う）


### xcconfig
https://help.apple.com/xcode/mac/11.4/#/dev745c5c974
- まずはここから読んでいく
  - 必要な設定を手動でできるように
- XcodeGenを学んでいく
  - 設定の自動化
