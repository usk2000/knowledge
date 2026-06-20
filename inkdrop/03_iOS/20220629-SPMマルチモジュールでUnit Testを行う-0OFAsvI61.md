# SPMマルチモジュールでUnit Testを行う



- SPMモジュールごとにUnit Test(.testTarget)を設定する
- CodeCoverageを出力する場合
- 

CodeCoverageをall targetにするとうまく取れるが、targetを指定するとうまくいかない。

[Xcode doesn't gather code coverage from packages when set to "some targets" - Using Swift - Swift Forums](https://forums.swift.org/t/xcode-doesnt-gather-code-coverage-from-packages-when-set-to-some-targets/37220/4)
Outputするときに注意が必要。

https://github.com/fastlane-community/xcov
xcovでは、--exclude_targetsが使えそう


全てのSPMをテストするために
- メインアプリでUnit Testを全て追加する

Slatherを使う方法
[XcodeのコードカバレッジをHTMLなどで出力する方法 - Qiita](https://qiita.com/uhooi/items/e1e464777d2163286c59)

```
[14:56:33]: Unable to find any .xccoverage file.
[14:56:33]: Make sure you have enabled 'Gather code coverage' setting on your scheme settings.
[14:56:33]: Alternatively you can provide the full path to your .xccoverage file.
```
なぜかうまくいかない。

あとで調べる。bundleで試してみる。


どうやら、Code Coverage設定を変更してから、一度Testしないとならないみたい。
→xcov自体はテストしないから

注意点
- Code CoverageをONにしてからテストする
- 以前のレポート(-oで指定したディレクトリ)は削除する
- メインアプリだけgather code coverageをONにする。all targets
- 
