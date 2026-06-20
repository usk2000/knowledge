# fastlane dsym


https://docs.fastlane.tools/actions/download_dsyms/
https://docs.fastlane.tools/actions/upload_symbols_to_crashlytics/

[app storeにdSYMダウンロードボタンが出なかった話](https://zenn.dev/y_murakami/articles/205558bb4bbd37)
[BitriseでAppStoreConnectからdSYMを安定してダウンロードする #iOS - Qiita](https://qiita.com/watanave/items/12de88678d7ed34c667a)
[[iOS] Firebase + fastlaneでdSYMアップロード #iOS - Qiita](https://qiita.com/usk2000/items/6188969dd112ed6aad22)
[Crashlytics ダッシュボードで読み取り可能なクラッシュ レポートを取得する  |  Firebase Crashlytics](https://firebase.google.com/docs/crashlytics/get-deobfuscated-reports?hl=ja&platform=ios)

### fastlaneを使う

```sh
% brew install fastlane
% fastlane init
```

あとはlaneを書いていき、Appfileをカスタマイズ

`upload-symbols`はデフォルトでは利用できないので、コピーする。
[How to Upload dSYM to Firebase using upload_symbols_to_crashlytics and SPM | Sarunw](https://sarunw.com/posts/upload-dsym-to-firebase-with-fastlane/)


```sh
% fastlane dsym
```
アカウント情報を聞かれるので、入力


Xcode 15からは、Bitcodeはなくても良くなったので、archiveに存在する。
→いちいち見つけるのも大変なので、何かしらのスクリプトを作成する
Archive時にスクリプトを起動したい