# Bitriseをローカルで実行

https://github.com/bitrise-io/bitrise

ローカルでアプリを追加
[Adding a new app from a CLI - Bitrise Docs](https://devcenter.bitrise.io/en/bitrise-cli/adding-a-new-app-from-a-cli.html)
→今はできなさそう

ローカルでワークフローエディタ
[Installing and upgrading the offline Workflow Editor - Bitrise Docs](https://devcenter.bitrise.io/en/bitrise-cli/installing-and-upgrading-the-offline-workflow-editor.html#starting-the-offline-workflow-editor)

ビルドを実行する
[Running your first local build with the CLI - Bitrise Docs](https://devcenter.bitrise.io/en/bitrise-cli/running-your-first-local-build-with-the-cli.html#running-your-first-local-build-with-the-cli)

シークレットを管理
[Managing Secrets locally - Bitrise Docs](https://devcenter.bitrise.io/en/bitrise-cli/managing-secrets-locally.html)

[How to experiment with Bitrise configs locally, on your Mac/Linux | Bitrise](https://blog.bitrise.io/post/how-to-experiment-with-bitrise-configs-locally-on-your-maclinux)

[Can not run Bitrise CLI at local - Issues - Bitrise Discussions](https://discuss.bitrise.io/t/can-not-run-bitrise-cli-at-local/3098)
[Installed bitrise CLI but can't get it to build my project - Question & Answer - Bitrise Discussions](https://discuss.bitrise.io/t/installed-bitrise-cli-but-cant-get-it-to-build-my-project/4352/10)
- ANDROID_HOMEとANDROID_SDK_ROOTを設定する必要がある。~/.zshrc

```
Failed to install licenses using $(sdkmanager --licenses) command
```
→実行してみる。JAVA_HOMEが足りないみたい

```
JAVA_HOME=/Applications/Android Studio.app/Contents/jre/Contents/Home
```
ここの値を入れるとできた。


### 環境変数について
外から与えることはできないか
bitrise run --json-paramsで使えそう

https://devcenter.bitrise.io/en/api/triggering-and-aborting-builds.html#specifying-environment-variables
これでできそう？まだできていない。
→Secret