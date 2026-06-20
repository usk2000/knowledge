# AppSyncを試す


[AWS AppSync](inkdrop://note/6Ka1J9nDe)

[API (GraphQL) - Getting started - Swift - AWS Amplify Docs](https://docs.amplify.aws/lib/graphqlapi/getting-started/q/platform/ios/)
https://qiita.com/makishy/items/57a178a341e2c6afbae4

事前にこれをやっておく。
[Project Setup - Prerequisites - Swift - AWS Amplify Docs](https://docs.amplify.aws/lib/project-setup/prereq/q/platform/ios/#configuring-the-amplify-cli)

### setup
```bash
% curl -sL https://aws-amplify.github.io/amplify-cli/install | bash && $SHELL
% amplify init --quickstart --frontend ios
% amplify codegen models
```

- model swift fileは手動で追加
- `amplifyconfiguration.json`を手動で追加
- model nameを変えたら、一度削除しないとならない
- modelを追加するごとに手動でxcodeに追加

- SQL操作のようにフィルタできる
- nullを許容してしまうことがデフォルトなので、使いにくい
- 余計なmutationを公開することになっているので、APIが煩雑では？
  - 内部のみで生成・更新されるようなものまでAPIとして公開されている
  - 必要なAPIのみを取得するにはQueryを作れば良いのか？
- AppSync利用するためにいくつか知っておくべきことがあるかも
  - nullに対する扱い
  - hasManyなどのdirective
  - 必要なREcordは事前に作っておく必要がある
  - nestはあまり得意ではない
- do catchしているのに、Resultで帰ってくる

### スキーマの設計
[スキーマの設計 - AWS AppSync](https://docs.aws.amazon.com/ja_jp/appsync/latest/devguide/designing-your-schema.html)
[API (GraphQL) - Data modeling - AWS Amplify Docs](https://docs.amplify.aws/cli/graphql/data-modeling/#setup-database-tables)

- Queryでpredicateを指定しないとならない
  - あまり影響しないかな

### Upload
- CloudFormation使っているが、料金は大丈夫だろうか

### Sorting

[API (GraphQL) - GraphQL query with sorting by date - JavaScript - AWS Amplify Docs](https://docs.amplify.aws/guides/api-graphql/query-with-sorting/q/platform/js/#implementation)

## Resolver

- [DynamoDB](https://docs.aws.amazon.com/ja_jp/appsync/latest/devguide/tutorial-dynamodb-resolvers.html)
- [Lambda](https://docs.aws.amazon.com/ja_jp/appsync/latest/devguide/tutorial-lambda-resolvers.html)
- [Direct Lambda Resolver](https://docs.aws.amazon.com/appsync/latest/devguide/direct-lambda-reference.html)
[AWS AppSync が GraphQL API 用の Direct Lambda Resolvers をリリース](https://aws.amazon.com/jp/about-aws/whats-new/2020/08/aws-appsync-releases-direct-lambda-resolvers-for-graphql-apis/)

Lambdaで作ってみる

### AppSync→Lambda
- １からAPIを作る


Lambdaの作成には、GraphQLからのほうがよさそう
[API (GraphQL) - Custom business logic (Lambda function, HTTP, and VTL resolvers) - AWS Amplify Docs](https://docs.amplify.aws/cli/graphql/custom-business-logic/)

```sh
% amplify push
...
🛑 Your GraphQL schema is invalid. Update the schema to use proper syntax and try again.
🛑 Syntax Error: Cannot parse the unexpected character "/".
```
と表示される。

[AWS Amplifyの各種ファイルの意味、手動でいじってよもの・悪いもの - Qiita](https://qiita.com/okapee0608/items/a9169c9900ce4ff24226)
`#current-cloud-backend`の中身のスキーマが更新されない。

```
% amplify codegen
% amplify update api
```

> Troubleshooting: The AWS API plugins do not support conflict detection. If AppSync returns errors about missing _version and _lastChangedAt fields, or unhandled conflicts, disable conflict detection. Run amplify update api, and choose Disable conflict detection. If you started with the Getting Started guide, which introduces DataStore, this step is required.
> 

とあるが、うまくいかない。`amplify`を使って`sync`できなくなったようだ。
おそらく、`local change`と`cloud`にあるSchemaがsyncできない。conflictをoverrideしようとしてもできないみたい。


新しい環境で作ってみる。
```
GraphQL endpoint: https://sbptucylczc4tbaaigmkl2rrlm.appsync-api.ap-northeast-1.amazonaws.com/graphql
GraphQL API KEY: da2-ptyylizmxbc2lkf3zfkyggxeve

```

他リポジトリで作ったschemaを、mobileに持ってくるためにはどうすれば良いのか？
→ドキュメントにあまり書いていない
https://docs.amplify.aws/lib/project-setup/use-existing-resources/q/platform/ios/

```
% aws pull
```
でできそう。

```
For more information on AWS Profiles, see:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

? Please choose the profile you want to use default
? Which app are you working on? d175gbumv3xj4m
Backend environment 'dev' found. Initializing...
? Choose your default editor: Visual Studio Code
? Choose the type of app that you're building ios
? Do you plan on modifying this backend? No

✅ Added backend environment config object to your project.
Run 'amplify pull' to sync future upstream changes.

Updating Xcode project:
-- Amplify project found.
-- Amplify config files found.
-- Successfully updated project /Users/yusuke.hasegawa/workspace/ios/AmplifySample2.
🚫 folderNotFound: Amplify generated models not found at /Users/yusuke.hasegawa/workspace/ios/AmplifySample2/amplify/generated/models
-- Recovery suggesti
```

Queryだけを作るのは難しい？

[Project Setup - Use existing AWS resources - Swift - AWS Amplify Docs](https://docs.amplify.aws/lib/project-setup/use-existing-resources/q/platform/ios/)
[API (GraphQL) - Use existing AWS resources - Swift - AWS Amplify Docs](https://docs.amplify.aws/lib/graphqlapi/existing-resources/q/platform/ios/)

これで既にあるものに追加できそう。

[GraphQLにおけるSubscription処理について(実装例: Amplify + AppSync) - Qiita](https://qiita.com/yoshii0110/items/3d9ec03215537646b65c)
Subscriptionできるかどうかには、`@aws_subscribe`が必要。


### 既にあるAppSyncをiOSにimportする
- `amplifyconfiguration.json`を追加。中身は`{}`
- `amplify pull <app-id>`


問題
Xcodeで新たに
`amplify init`
しても、
`amplify/backend/backend-config.json does not exist`
となってしまう。

```
% amplify pull --appId d175gbumv3xj4m --envName dev
? Select the authentication method you want to use: AWS profile

For more information on AWS Profiles, see:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

? Please choose the profile you want to use default
Amplify AppID found: d175gbumv3xj4m. Amplify App name is: AmplifySample
Backend environment dev found in Amplify Console app: AmplifySample
? Choose your default editor: Xcode (macOS only)
? Choose the type of app that you're building ios
Not pulling components because this project is not configured as a javascript frontend.
? Do you plan on modifying this backend? No

✅ Added backend environment config object to your project.
Run 'amplify pull' to sync future upstream changes.

Updating Xcode project:
-- Amplify project found.
-- Amplify config files found.
-- Successfully updated project /Users/yusuke.hasegawa/workspace/ios/AmplifySample2.
🚫 folderNotFound: Amplify generated models not found at /Users/yusuke.hasegawa/workspace/ios/AmplifySample2/amplify/generated/models
-- Recovery suggestion: Run amplify codegen models.
Not pulling components because this project is not configured as a javascript frontend.
```

`amplify add api`としても、swiftが選択できない。
→Xcodeが必要だから？

`? Do you plan on modifying this backend? No`
をYesとすると、schemaとかがダウンロードできた。

Queryの場合AWSAppSyncを使わないとできなさそう。
https://github.com/awslabs/aws-mobile-appsync-sdk-ios
→結局DynamoDBなしAppSyncにすると、AppSyncClientも必要になりそう。

### AppSyncのEndpoint
[WebSocket リアルタイムクライアントの構築 - AWS AppSync](https://docs.aws.amazon.com/ja_jp/appsync/latest/devguide/real-time-websocket-client.html)

GrapReal-time endpointが必要。つまり2つのendpoint。


### Keep-aliveできるか
できそう。MessageTypeにKEEP_ALIVEを設定することで。
ただし、AppSync library

### versioningできるか？
できなさそう。
AmplifyModels.versionというパラメータがあるが、これを使っているか定かではない。

- AppSync自体、ハッシュ値でバージョン管理しているかもしれない
- AppSync以外のBackend側への影響はあるのでは？
  - AppSync AとLambdaをdeploy
  - AppSync AとLambda Aを更新
  - AppSync AからBにアップデートしdeploy。Lambdaはバージョン管理していないので、そのままdeploy
  - AppSync A/BからLambdaへリクエスト
  - 片方はおかしくなってしまう

Queryのテスト方法
[Advanced workflows - Mocking and testing - AWS Amplify Docs](https://docs.amplify.aws/cli/usage/mock/#function-mocking-setup)
[テスト/デバッグリゾルバー (VTL) - AWS AppSync](https://docs.aws.amazon.com/ja_jp/appsync/latest/devguide/test-debug-resolvers.html)


純粋なGraphQLのみのレスポンス
https://piotrzakrzewski.medium.com/graphql-keep-alive-4379fe1a8b58

各AWSリージョンへのping
https://speedtest.globalaccelerator.aws/#/
早くする方法
[AWS Global Accelerator（アプリケーションの可用性とパフォーマンスを向上）| AWS](https://aws.amazon.com/jp/global-accelerator/)


### パイプラインリゾルバ
[AppSyncのパイプラインリゾルバーを解説！気になる仕組みを見てみよう💡 | Ragate ブログ](https://www.ragate.co.jp/blog/articles/6087)

### GraphQLでpushできなくなったら
修正できない問題がまだ残っている。

```
% amplify push        
⠙ Fetching updates to backend environment: dev from the cloud.✅ GraphQL schema compiled successfully.

Edit your schema at /Users/yusuke.hasegawa/workspace/ios/AmplifySample/amplify/backend/api/amplifyDatasource/schema.graphql or place .graphql files in a directory at /Users/yusuke.hasegawa/workspace/ios/AmplifySample/amplify/backend/api/amplifyDatasource/schema
✔ Successfully pulled backend environment dev from the cloud.
⠏ Building resource api/amplifyDatasource✅ GraphQL schema compiled successfully.

Edit your schema at /Users/yusuke.hasegawa/workspace/ios/AmplifySample/amplify/backend/api/amplifyDatasource/schema.graphql or place .graphql files in a directory at /Users/yusuke.hasegawa/workspace/ios/AmplifySample/amplify/backend/api/amplifyDatasource/schema

    Current Environment: dev
    
┌──────────┬───────────────────┬───────────┬───────────────────┐
│ Category │ Resource name     │ Operation │ Provider plugin   │
├──────────┼───────────────────┼───────────┼───────────────────┤
│ Api      │ amplifyDatasource │ Update    │ awscloudformation │
└──────────┴───────────────────┴───────────┴───────────────────┘
✔ Are you sure you want to continue? (Y/n) · yes
🛑 Your GraphQL schema is invalid. Update the schema to use proper syntax and try again.
🛑 Syntax Error: Cannot parse the unexpected character "/".
```