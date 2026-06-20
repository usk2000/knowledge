# BitriseでXcode Archiveエラー


Provisioningをマニュアルで設定する必要がある。


error: Signing for "" requires a development team. Select a development team in the Signing & Capabilities editor.

[Xcode Build Settings](https://xcodebuildsettings.com/)

Bitrise Xcode Archiveで、Build settings (xcconfig)
のところで、DEVELOPMENT_TEAMを入力する


error: No profiles for '' were found: Xcode couldn't find any iOS App Development provisioning profiles matching ''. Automatic signing is disabled and unabled to generate a profile.

[No profiles for 'xxxx.app.developm… | Apple Developer Forums](https://developer.apple.com/forums/thread/683756)

[Creating a signed IPA for Xcode projects - Bitrise Docs](https://devcenter.bitrise.io/en/code-signing/ios-code-signing/creating-a-signed-ipa-for-xcode-projects.html)

[iOS code signing with manual provisioning - Bitrise Docs](https://devcenter.bitrise.io/en/code-signing/ios-code-signing/managing-ios-code-signing-files---manual-provisioning.html)
[Simplifying automatic code signing on Bitrise | Bitrise](https://blog.bitrise.io/post/simplifying-automatic-code-signing-on-bitrise)

→xcconfigではうまくいかなかった

このステップでやってみる？
[cupojoe/bitrise-step-update-xcode-project-provisioning: Bitrise step to update Xcode's project file signing config to use a specific certificate and provisioning profile](https://github.com/cupojoe/bitrise-step-update-xcode-project-provisioning)
→やってみる
https://github.com/cupojoe/bitrise-step-update-xcode-project-provisioning/issues/3
1.1.0では問題があるみたい。1.0.0を使う

全て戻して、もう一度ローカルPCでやってみたらこのようになった
このようなエラーになった
> ipatool failed with an exception:

この方法を使ってみる
[Xcode 12 archive failed: ipatool f… | Apple Developer Forums](https://developer.apple.com/forums/thread/662947)
Xcode archiveでCLANG_ENABLE_CODE_COVERAGE = NOとしてやってみる
→できなかった
ENABLE_BITCODE = NOでうまくいった
どうやら、3rd party libがBitcode対応していない
[bitrise-steplib/steps-xcode-archive: Xcode Archive for iOS step](https://github.com/bitrise-steplib/steps-xcode-archive)

## まとめ
- StepでCertificate and profiler installer、Update Xcode Project Provisioning(1.0.0)を追加する
  - Manual設定、DEVELOPMENT_TEAMの設定、Provisioning Profile Specifierの設定を行う
- XCode archiveでCLANG_ENABLE_CODE_COVERAGE = NO, ENABLE_BITCODE = NOを行う



## その他

Info.plistバージョンがうまくいかない
[Set-xcode-build-number not works Xcode 13 project - Question & Answer - Bitrise Discussions](https://discuss.bitrise.io/t/set-xcode-build-number-not-works-xcode-13-project/19138/2)
→set xcode build numberのステップを利用する
→うまくいかない

[Technical Q&A QA1827: Automating Version and Build Numbers Using agvtool](https://developer.apple.com/library/archive/qa/qa1827/_index.html)

```
xcrun agvtool new-version -all "${BITRISE_BUILD_NUMBER}"
```
