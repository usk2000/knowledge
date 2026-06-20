# Bitrise + AWS CLI


BitriseでAWS CLIを使う。
* [ ] PRに対してコメントを行う
* [ ] PRに対してステータス変更を行う

https://devcenter.bitrise.io/en/builds/installing-tools-during-a-build.html
https://discuss.bitrise.io/t/how-to-install-awscli/4272

Homebrewでインストールした後。
KEY_IDなどを設定する。regionも。
[Environment variables to configure the AWS CLI - AWS Command Line Interface](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
→無事疎通確認完了。

AWS_CONFIG_FILEは使うべきか。
[設定ファイルと認証情報ファイルの設定 - AWS Command Line Interface](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-files.html)
AWS_SHARED_CREDENTIALS_FILEも使った方が良さそう？
→あまりメリットはないため、使わない。env varsで十分。

Pull Request関連のコマンド
[AWS CodeCommit リポジトリのプルリクエストを表示する - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-view-pull-request.html#get-pull-request)

コマンドラインで実行
[AWS CodeCommit コマンドラインリファレンス - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/cmd-ref.html)

- post-comment-for-pull-request
- get-merge-conflicts
- update-pull-request-approval-state

get-merge-conflictsはLambdaの中でやるべきか

[プルリクエストのレビュー - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-review-pull-request.html#how-to-review-pull-request-cl


### PRの承認ステータスを変える

[AWS CodeCommit リポジトリのプルリクエストを表示する - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-view-pull-request.html)
[プルリクエストのレビュー - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-review-pull-request.html#update-pull-request-approval-state)

リビジョンID、`get-pull-request`から取得
```bash
AWS_PR_REVISION_ID=$(aws codecommit get-pull-request-id ${PR_ID} | jq -r 'pullRequest.revisionId')
```

- 現在の状態：`get-pull-request-approval-state`
- 更新: `update-pull-request-approval-state`


