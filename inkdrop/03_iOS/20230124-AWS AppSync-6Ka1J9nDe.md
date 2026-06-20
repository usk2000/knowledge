# AWS AppSync



https://github.com/awslabs/aws-mobile-appsync-sdk-ios

[AWS AppSyncを使用したiOSアプリ開発入門 - Qiita](https://qiita.com/Tanashun/items/edf297eaeeb6c04130ca)

[【超ミニマム】AWS AppSync + AmplifyでiOSチャットアプリを作る - Qiita](https://qiita.com/ichikawa7ss/items/3da2842056186e3a5b60)
Amplifyの中でAppSync用のEndpointにアクセスできるみたい
[aws-amplify/aws-sdk-ios: AWS SDK for iOS. For more information, see our web site:](https://github.com/aws-amplify/aws-sdk-ios)

- FWをmanualで選択する必要がある。
- AWSCoreが必要なので、余計なコードもたくさん入っている
- Objective-Cメインなので、バグが起きやすくなっている
- API.swiftに自動生成される。双方向通信のためにはsubscribeする必要がある
- 

[API (GraphQL) - Client code generation - AWS Amplify Docs](https://docs.amplify.aws/cli-legacy/graphql-transformer/codegen/#mutations)
結局、コードジェネレーションを使うと、クライアント側ではAppSync用のSDKが必要になる。
→Legacyなドキュメント

[API (GraphQL) - Getting started - Swift - AWS Amplify Docs](https://docs.amplify.aws/lib/graphqlapi/getting-started/q/platform/ios/)
- Amplify SDKへの依存が強くなる
- このSDKから他への3rd party SDKへの依存度が強い
  - AppSyncRealTimeClient, aws-crt-swift, aws-sdk-swift, smithy-swift, SQLite.swift, Starstream, swift-collections, swift-log, XMLCoder
- 安定性・メンテナンス性のためのコストが増えてしまう

### GraphQLを直接叩けるか
- API GatewayでGraphQLを選択することができる
- コード生成は3rd partyが必要となる
- AWS用の追加の設定が必要になりそう
  - AMAZON_COGNITO_USER_POOLS: cognitoでのユーザ認証
  - 自前で実装する必要がある

[AWS AmplifyによるiOSアプリ開発入門（Part3） - Qiita](https://qiita.com/papi_tokei/items/ee4abf44703f8692f006#appsync%E3%81%AE%E8%A8%AD%E5%AE%9A%E3%82%92%E8%A1%8C%E3%81%86)

- Backend DBの種類に強く依存する
  - イベント数が多かったら、スループット・コストがかかりそうでは？


[AWS AppSyncのスキーマ情報からAmplify以外の方法でTypeScriptの型を生成する - Sweet Escape](https://www.keisuke69.net/entry/2022/07/21/133703)
AWS独自の型もあるので、それらを使うとなるとAppSync mobile SDKが必須となる。


### Unit Test

[Advanced workflows - Mocking and testing - AWS Amplify Docs](https://docs.amplify.aws/cli/usage/mock/)

mocking/stubについてはできそう。当たり前か。

[aws-amplify/amplify-cli: The AWS Amplify CLI is a toolchain for simplifying serverless web and mobile development.](https://github.com/aws-amplify/amplify-cli)
[aws-amplify/amplify-swift: A declarative library for application development using cloud services.](https://github.com/aws-amplify/amplify-swift)

### CICD
[Advanced workflows - Headless mode for CI/CD - AWS Amplify Docs](https://docs.amplify.aws/cli/usage/headless/)
CICD内で、cliを使ってschema updateを行える。

[スキーマからのプロビジョニング (オプション) - AWS AppSync](https://docs.aws.amazon.com/ja_jp/appsync/latest/devguide/provision-from-schema.html)
これを見ると、AppSyncのスキーマの変更を、EventBridge自動で取得することはできなさそう？

ソースベースでアップデートできるか
[Designing your schema - AWS AppSync](https://docs.aws.amazon.com/appsync/latest/devguide/designing-your-schema.html)
操作はconsole, API, cliで可能
API/CLI共に、機能ごとにcreate -> updateが可能だが、一括ファイル更新ができなさそう。
[appsync — AWS CLI 2.9.22 Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/appsync/index.html#cli-aws-appsync)

Amplify CLIだとできそう？
[API (GraphQL) - Overview - AWS Amplify Docs](https://docs.amplify.aws/cli/graphql/overview/#delete-a-record)
[API (GraphQL) - Getting started - Android - AWS Amplify Docs](https://docs.amplify.aws/lib/graphqlapi/getting-started/q/platform/android/)
Swiftでもできる
→Android/Backendとの管理が大変そう
- Swiftリポジトリのみであれば管理可能
- リポジトリを別にすることで可能
- AppSync自体もアップデートすることは可能。どれかのplatformからAmplify CLIを使って。
- Mobileからアップデートできることが問題

Amplify, GraphQLの場合のschemaアップデート
- schema用のstandaloneリポジトリを作成
- schemaを書く
- amplify pushを使い、schemaをAppSyncにアップロード
- git commit
- remoteでgitの変更をトリガーにする
  - CodeCommitの場合はEventBridge->Lambda
  - githubの場合はGithubAction
- 各platformのリポジトリでschemaアップデートを行う
  - CodeCommitの場合はLambda操作（作業量多）
  - githubの場合はGithubAction内でworkflowを実装（作業量少）
  - 別branchでアップデートしPRを作るところまで
  - 連携しているCI/CDでテストを行う

AmplifyとAppSyncの場合の問題点
- schemaをそれぞれのリポジトリでアップデートできてしまうこと
  - 他のplatformで意図しない変更ができてしまう
  - 運用でカバーするしかないが、避けたい


AppSyncにDynamoDBをマニュアルで追加する必要がありそう
DynamoDBにはDynamoDB on-demandとprovisioned capacityがある
https://aws.amazon.com/jp/dynamodb/pricing/
https://aws.amazon.com/dynamodb/pricing/?nc1=h_ls

[AWS AppSync選定を悩んでいる方必見！GraphqlエキスパートがAppSync導入をいろんな角度からまとめました😎 | Ragate ブログ](https://www.ragate.co.jp/blog/articles/12064)
パフォーマンスが不透明


差分同期もあるんだ。
[チュートリアル: 差分同期 - AWS AppSync](https://docs.aws.amazon.com/ja_jp/appsync/latest/devguide/tutorial-delta-sync.html)
