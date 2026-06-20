# CodeCommit 承認テンプレート


承認ルール
[プルリクエストの承認ルールを作成する - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-create-pull-request-approval-rule.html)
- マージをブロック
- コマンドラインでApproval Stateやコメントの追加ができる


[承認ルールテンプレートを作成する - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-create-template.html)

ロール作成
[IAM ユーザーにアクセス許可を委任するロールの作成 - AWS Identity and Access Management](https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/id_roles_create_for-user.html)
→ロールの作成がうまくできないので、諦める

### Bitrise用の承認ルールを作成


### 承認ルールの適用
[プルリクエストの承認ルールを編集または削除する - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-edit-delete-pull-request-approval-rule.html)
[プルリクエストの承認ルールを作成する - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-create-pull-request-approval-rule.html#how-to-create-pull-request-approval-rule-cli)

```
% aws codecommit create-pull-request-approval-rule --pull-request-id 27 --approval-rule-name "Require two approved approvers" --approval-rule-content "{\"Version\": \"2018-11-08\",\"Statements\": [{\"Type\": \"Approvers\",\"NumberOfApprovalsNeeded\": 2,\"ApprovalPoolMembers\": [\"CodeCommitApprovers:123456789012:Nikhil_Jayashankar\", \"arn:aws:sts::123456789012:assumed-role/CodeCommitReview/*\"]}]}"
```

後からテンプレートの適用はできないみたい。

- `list-approval-rule-templates`で名前を確認
- `get-approval-rule-template`で内容を取得
- `create-pull-request-approval-rule`で適用
  - approvalRuleTemplateNameとaporovalRulteTemplateContentが必要

で擬似的にできる

