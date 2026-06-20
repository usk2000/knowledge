# CodeCommit + Lambda


[AWS CodeCommit とは - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/welcome.html)

CodeCommitイベント
[Notification concepts - Developer Tools console](https://docs.aws.amazon.com/dtconsole/latest/userguide/concepts.html#events-ref-repositories)

Pull Request
[プルリクエストの作成 - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-create-pull-request.html)

pre-mergeはCodeCommitでは取得できないみたい。

### Node.jsの場合
[例: AWS CodeCommit 関数用の AWS Lambda トリガーを作成する - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-notify-lambda.html)

[CodeCommit Client - AWS SDK for JavaScript v3](https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/clients/client-codecommit/index.html)

[async/await の使用 - AWS SDK for JavaScript](https://docs.aws.amazon.com/ja_jp/sdk-for-javascript/v2/developer-guide/using-async-await.html)

`.promise()`が必要みたい。

- Markdown可能
- AWS CLIで作成ができる
- 画像・動画はできる？
- テンプレートがない

[getMergeOptions.js - AWS Code Sample](https://docs.aws.amazon.com/code-samples/latest/catalog/javascriptv3-codecommit-src-getMergeOptions.js.html)
[GetMergeConflicts - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/APIReference/API_GetMergeConflicts.html)

競合の解決方法
[AWS CodeCommit リポジトリ内のプルリクエストの競合を解決する - AWS CodeCommit](https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-resolve-conflict-pull-request.html)
→競合があるとマージできないのは問題なさそう

承認ルール→別note

ここら辺はPythonでもあると思われる

[[アップデート]CodeCommitでプルリクエストの承認ルールワークフローを試してみた | DevelopersIO](https://dev.classmethod.jp/articles/codecommit-approvalrule-for-pullrequest/)

[CodeCommitのPull Request関連のイベントをSlackに通知してみた | DevelopersIO](https://dev.classmethod.jp/articles/notify-slack-of-events-related-to-codecommit-pull-requests/)

## Lambda
- 作成後、CodeCommitのトリガーから選択する


```python

import json
import urllib.request
import boto3
import os

codecommit = boto3.client('codecommit')

def lambda_handler(event, context):
    
    appSlug = os.environ['APP_SLUG']
    apiToken = os.environ['API_TOKEN']
    endpoint = "https://api.bitrise.io/v0.1/apps/{0}/builds".format(appSlug)
    repository = event['Records'][0]['eventSourceARN'].split(':')[5]
    references = [reference for reference in event['Records'][0]['codecommit']['references'] ]

    print(json.dumps(event))
    print("URL : " + endpoint)

    for r in references:
        ref = r["ref"]
        commitId = r["commit"]
        commit = codecommit.get_commit(repositoryName=repository, commitId=commitId)
        message = commit['commit']['message']
        
        # print("Triggering Bitrise build for ref {0} of repository {1}".format(ref, repository))
        # print("at commit {0} -- {1}".format(commitId, message))

        payload = {
            'hook_info': {'type': 'bitrise'},
            'build_params': {
                'branch': 'master',
                'workflow_id': 'primary'
            }
        }
        
        print(payload)
        
        headers = {
            'Content-Type': 'application/json',
            'Authorization': apiToken
        }
        
        # req = urllib.request.Request(endpoint, json.dumps(payload).encode(), headers)
        
        # try:
        #     res = urllib.request.urlopen(req) 
        #     print(res.read())
        # except urllib.error.HTTPError as err:
        #     print(err.code)
        #     print(err.read().decode())
        # except urllib.error.URLError as err:
        #     print(err.reason)
# end lambda_handler


```


