# CodeCommit + EventBridge


### Commit Event
標準は使わない。PRに関することができないから。

### EventBridge
[Amazon EventBridge および Amazon CloudWatch Events の CodeCommit イベントのモニタリング - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/monitoring-events.html)

PRの作成でトリガーする。
[What Is Amazon EventBridge? - Amazon EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html)


ブランチ作成とかもトリガーする

- ソース：CodeCommit (リポジトリ情報まで)
- ターゲット：Lambda

- pullRequestSourceBranchUpdated: ソースがアップデートされた
- pullRequestCreated: PR作成された
- pullRequestMergeStatusUpdated: マージされた
- referenceCreated: branch作成、タグの作成
- referenceUpdated: コミット更新

これらのみで対応できそう。


- pullRequestMergeStatusUpdatedイベントの場合、destinationReferenceだけテストする
- getMergeConflicts
  - [GetMergeConflicts - AWS CodeCommit](https://docs.aws.amazon.com/codecommit/latest/APIReference/API_GetMergeConflicts.html)


