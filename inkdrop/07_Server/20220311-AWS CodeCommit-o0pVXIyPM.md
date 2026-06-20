# AWS CodeCommit


* [x] プルリク作っていないやつの制限できるか
* [x] ステータス変更どんなのができるか。rejectできるか
* [x] BitriseからAWSにコメントとか送れるか。
* [x] Bitriseでaws cli使えるか


[AWS CodeCommit とは - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/welcome.html)

セットアップ
[Git 認証情報を使用した HTTPS ユーザーのセットアップ - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/setting-up-gc.html)


SSHが確実か。
[Linux、macOS、または Unix での AWS CodeCommit リポジトリへの SSH 接続の設定手順 - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/setting-up-ssh-unixes.html)

[AWS CLI 認証情報ヘルパーを使用した、Linux、macOS、または UNIX での AWS CodeCommit リポジトリへの HTTPS 接続のセットアップ手順 - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/setting-up-https-unixes.html)
[git-remote-codecommit を使用して AWS CodeCommit への HTTPS 接続をセットアップする手順 - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/setting-up-git-remote-codecommit.html)

[[CodeCommit] 僕ぁMacのSourceTreeでCodeCommitのリポジトリを扱いたいんやっ | DevelopersIO](https://dev.classmethod.jp/articles/codecommit-with-mac-sourcetree/)
[AWS CodeCommit からCloneができない - Qiita](https://qiita.com/Masayuki-M/items/2f92aea42fa415d44cc5)


## Branch Commit禁止
https://dev.classmethod.jp/articles/codecommit-deny-push-mster-branch/
プルリク使ってないやつは再現できるか。→できそう

[AWS CodeCommit のブランチに対するプッシュとマージの制限 - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-conditional-branch.html#how-to-conditional-branch-test)
[CodeCommit アクセス許可リファレンス - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/auth-and-access-control-permissions-reference.html)

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": [
                "codecommit:GitPush",
                "codecommit:DeleteBranch",
                "codecommit:PutFile",
                "codecommit:MergeBranchesByFastForward",
                "codecommit:MergeBranchesBySquash",
                "codecommit:MergeBranchesByThreeWay",
                "codecommit:MergePullRequestByFastForward",
                "codecommit:MergePullRequestBySquash",
                "codecommit:MergePullRequestByThreeWay"
            ],
            "Resource": "arn:aws:codecommit:us-east-2:111111111111:MyDemoRepo",
            "Condition": {
                "StringEqualsIfExists": {
                    "codecommit:References": [
                        "refs/heads/main", 
                        "refs/heads/prod"
                     ]
                },
                "Null": {
                    "codecommit:References": "false"
                }
            }
        }
    ]
}
```


