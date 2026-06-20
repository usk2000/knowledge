# Github Actions


[Understanding GitHub Actions](https://docs.github.com/ja/actions/learn-github-actions/understanding-github-actions)

- Workflow: 自動化された手順。１つ以上のジョブ。スケジュールまたはイベントによってトリガー
- Event
- Job
- Step

### 変数の定義
https://docs.github.com/ja/actions/learn-github-actions/essential-features-of-github-actions#using-variables-in-your-workflows

```yaml
jobs:
  example-job:
      steps:
        - name: Connect to PostgreSQL
          run: node client.js
          env:
            POSTGRES_HOST: postgres
            POSTGRES_PORT: 5432
```

### ワークフロー構文
https://docs.github.com/ja/actions/learn-github-actions/workflow-syntax-for-github-actions

https://blog.kondoumh.com/entry/2021/01/22/133427
ワークフローをスイッチするには、ワークフローを複数用意する。
