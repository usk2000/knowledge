# Bitrise + AWS CodeCommitセットアップ


https://discuss.bitrise.io/t/integrating-aws-codecommit-with-bitrise/158
https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-notify-lambda.html

# AWS
以下の5つを使用します。
- CodeCommit
- IAM
- Lambda
- EventBridge
- CloudWatch

## 前提
- CodeCommitにリポジトリ、Lambdaにfunctionが作成されている。
- AWSでの適切な権限が与えられている
  - CodeCommit, Lambda, IAM, EventBridge, CloudWatchにアクセスでき、編集できる
- Macを使用している

## SSHキー
SSHを使ってCodeCommitに接続する。
- ローカルでSSHキーペアを作成
- 自分用、CICD用の２つを作成する

### ローカルでSSHキーを作成
SSHを使ってCodeCommitに接続するため、SSHキーをローカルで生成する。

[Linux、macOS、または Unix での AWS CodeCommit リポジトリへの SSH 接続の設定手順 - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/setting-up-ssh-unixes.html#setting-up-ssh-unixes-keys)

デフォルトではOPENSSHになっているので、RSAにする。
```
% ssh-keygen -m PEM -t rsa -b 4096 -P '' -f ~/.ssh/bitrise-ssh
```
ファイル名は、自分用(例: id_rsa)、CICD用(例: bitrise-ssh)など適宜変更する。

AWSパタメータストアもあり、そこに保存することもできる。
[AWS Systems Manager Parameter Store - AWS Systems Manager](https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/systems-manager-parameter-store.html)

### IAMでSSHキーの登録とCICD用のユーザーの作成
自身のユーザーはすでに作成されている。

[Using IAM with CodeCommit: Git credentials, SSH keys, and AWS access keys - AWS Identity and Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_ssh-keys.html)

#### SSHキーの追加
- IAM > ユーザー > 該当ユーザを選択
- 「認証情報」タブ > SSHパブリックキーのアップロード
- 生成したSSH公開鍵を登録
- 登録後、SSHキーIDをメモしておく（１）


#### CICD用のユーザーの作成
[AWS アカウントでの IAM ユーザーの作成 - AWS Identity and Access Management](https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/id_users_create.html)

- 今回はBitriseという名前で追加
- AWS認証情報タイプに「アクセスキー」を選択
- アクセス許可の設定
  - ユーザーをグループに追加の場合：CodeCommitを選択する（すでに設定されているもの）。推奨
  - 既存のポリシーを直接アタッチする場合：AWSCodeCommitPowerUser
- ユーザー作成を完了
- SSH Keyを追加（２）
  - 前述と同じ手順
  - SSH鍵は個人のものとは別のものを使用する

CodeCommitグループは「AWSCodeCommitPowerUser」とブランチ制限のポリシーが追加されているもの。

### ソースコードをローカルにクローンしてみる

[Linux、macOS、または Unix での AWS CodeCommit リポジトリへの SSH 接続の設定手順 - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/setting-up-ssh-unixes.html#setting-up-ssh-unixes-keys)

設定ファイル(`~/.ssh/config`)に設定を追加する。
```sh
Host git-codecommit.*.amazonaws.com
  User APKAEIBAERJR2EXAMPLE
  IdentityFile ~/.ssh/codecommit_rsa
```

ソースをクローンする。
```sh
% git clone ssh://Your-SSH-Key-ID@git-codecommit.us-east-2.amazonaws.com/v1/repos/MyDemoRepo my-demo-repo
```
`YOUR-SSH-Key-ID`はローカルの場合とCICDの場合で異なる。
また、リージョン`us-east-2`とリポジトリ`MyDemoRepo`も適宜置き換える。

## EventBridge
CodeCommit標準のトリガーではPull Requestに対応していないため、`EventBridge`を使用してトリガーイベントを作成する。
[What Is Amazon EventBridge? - Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html)
[Amazon EventBridge および Amazon CloudWatch Events の CodeCommit イベントのモニタリング - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/monitoring-events.html)

### ルールの作成
- EventBridge > ルール > ルールを作成 を選択する
- ルール名を入力
- 「イベントパターンを持つルール」を選択する
- イベントソース：AWS

イベントパターンは次のようなJSON
```json
{
  "source": ["aws.codecommit"],
  "detail-type": [
    "CodeCommit Pull Request State Change",
    "CodeCommit Repository State Change"
  ],
  "resources": ["arn:aws:codecommit:[region]:[***]:[repository name]"]
}
```

この設定を行うことで、主に以下のイベントを受け取ることができる（他にもイベントはあるが、使用しないので割愛）

- pullRequestSourceBranchUpdated: ソースがアップデートされた
- pullRequestCreated: PR作成された
- pullRequestMergeStatusUpdated: マージされた
- referenceCreated: branch作成、タグの作成
- referenceUpdated: コミット更新

次にターゲットを設定する。ここではすでに作成されている`Lambda`関数を選択する。
作成を完了する。

## Lambda
EventBridgeからCICDへトリガーするために、`Lambda`を使用する。

ここでは、EventBridgeからのイベントから判断する。

`app.js`
```javascript
var aws = require("aws-sdk");
var codecommit = new aws.CodeCommit({ apiVersion: '2015-04-13' });



```


### Bitriseに追加を始める

- SSH_KEY_ID: IAM user ID(SSH Key ID)
- REPO_URL

### SSH手動追加

private keyをコピペする

```
Error: Failed to store the SSH Keys - Invalid SSH key.
```

[Bitriseで自分の作った秘密鍵を登録する🔑 - Qiita](https://qiita.com/Jung0/items/13cd9f6313b7137ac8c6)

## トリガーについて

参考
https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-notify-lambda.html
https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-notify-lambda.html
→１つ目が参考になる。

> CodeCommitにはGithubのようにpush時のイベントなどのwebhookは提供されていない。
> 代わりに、他のAWSサービスとの連携で実現できる
> 

- CodeCommit
- AWS Lambda
- [Bitrise Trigger API](https://devcenter.bitrise.io/en/api/triggering-and-aborting-builds.html)

1. CodeCommitにコードをpush
2. Lambda Functionが呼び出される
3. AWSからBitriseにトリガー情報を送る
4. Bitriseでトリガーに従いビルドが実行される

参考コード
https://github.com/danielmklein/AWSCodeCommitBitrise/blob/master/TriggerBitriseBuild.py


### Lambda Functionの生成
- すでに作成されている
- CodeCommitのトリガーを追加
- customDataにslugとかを追加
  - Bitrise側でslugとAPI tokenを取得する
- 設定＞アクセス権限＞ポリシーにlambda:InvokeFunctionを追加する
- 設定＞アクセス権限＞実行ロールからIAMに移動し、AWSCodeCommitPowerUserを追加




ログの確認にはCLoud Watchを使用する。
/aws/lambda/{関数名}

[Python の Lambda 関数ハンドラー - AWS Lambda](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/python-handler.html)

環境変数に`APP_SLAG`, `API_TOKEN`を使用する。
[AWS Lambda 環境変数の使用 - AWS Lambda](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/configuration-envvars.html)

```javascript
let region = process.env.AWS_REGION
```

テストにCodeCommitテンプレートを利用する。
JSON内容はカスタマイズする。

[例: AWS CodeCommit 関数用の AWS Lambda トリガーを作成する - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-notify-lambda.html)
トリガーに`AWSCodeCommitPowerUser`を追加する。

[AWS CodeCommit リポジトリのトリガーをテストする - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-notify-test.html)
→トリガーのテスト


サンプルコードは少し古いので、こちらを読んで試す。
[Triggering and aborting builds - Bitrise Docs](https://devcenter.bitrise.io/en/api/triggering-and-aborting-builds.html)

API Tokenを確認する
[Authenticating with the Bitrise API - Bitrise Docs](https://devcenter.bitrise.io/en/api/authenticating-with-the-bitrise-api.html)

- /apps - アプリを確認

ビルドするところまで完了。

## トリガーの確認

まずはBitriseには送らずに、トリガーのeventを確認する。

* [x] ブランチ作成
* [x] コミットPush
* [ ] プルリク作成
* [ ] プルリク更新
* [ ] プルリクマージ
* [ ] tagの作成

## DeployGate
https://devcenter.bitrise.io/en/deploying/deploying-apps-to-deploygate-from-bitrise.html#deploying-apps-to-deploygate-from-bitrise

## urllib3

[Python の HTTP クライアントは urllib.request で十分 - Qiita](https://qiita.com/hoto17296/items/8fcf55cc6cd823a18217)
[HTTPのPOST/GETリクエストをする | Python Snippets](https://python.civic-apps.com/http-request-post-get/)
