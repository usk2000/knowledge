# KMP investigation TODO


- 仕組みの理解→サンプルを作成
  - Android
  - iOS
- GraphQLのプラグインを試す
- dokkaを試す
- コメント追加
- module/libraryを作成する


### サンプル作成

[Create a Kotlin Multiplatform app — tutorial](https://www.jetbrains.com/help/kotlin-multiplatform-dev/multiplatform-getting-started.html)

project作成はAndroid Studioで

[iOS用のconfiguration](https://www.jetbrains.com/help/kotlin-multiplatform-dev/multiplatform-create-first-app.html#run-on-a-new-ios-simulated-device)
→Execution targetが表示されない

[Version comparioson](https://kotlinlang.org/docs/multiplatform-compatibility-guide.html#version-compatibility)

> The operation couldn’t be completed. Unable to locate a Java Runtime.

→解決できないので、iOSについては一旦スキップする？

https://stackoverflow.com/questions/76898701/xcode-cannot-locate-java-runtime
> sudo ln -sfn /Applications/Android\ Studio.app/Contents/jbr /Library/Java/JavaVirtualMachines/jbr
> 

これで行けた。この方法を使うようにする

### Module/Libraryを作成

[Share code on platforms](https://kotlinlang.org/docs/multiplatform-share-on-platforms.html#share-code-on-all-platforms)


### GraphQL

[ここさえ抑えればGitHub API v4がわかる! GraphQL入門](https://zenn.dev/hsaki/articles/github-graphql)
[GraphQLでの呼び出しの作成](https://docs.github.com/ja/graphql/guides/forming-calls-with-graphql)
[パブリックスキーマ](https://docs.github.com/ja/graphql/overview/public-schema)
[GraphQL APIについて](https://docs.github.com/ja/graphql/overview/about-the-graphql-api)

### Apollo Client
[Get started with Multiplatform (Experimental) | Apollo GraphQL Docs](https://www.apollographql.com/docs/kotlin/v2/essentials/get-started-multiplatform/)

`libs.versions.toml`
```
[versions]
...
apollo3 = "3.8.4"

[libraries]
...
apollo-runtime = { module = "com.apollographql.apollo3:apollo-runtime", version.ref = "apollo3" }

[plugins]
...
apolloClient = { id = "com.apollographql.apollo3", version.ref = "apollo3" }

```

sharedの`build.gradle.kts`

```
plugins {
    alias(libs.plugins.apolloClient).apply(false)
}

apollo {
    service("service") {
        packageName.set("com.example")
    }
}

dependencies {
    implementation(libs.apollo.runtime)
}

```

その後、GraphQLファイルを
`shared/src/commonMain/graphql`
に置く

https://docs.github.com/ja/graphql/overview/public-schema
これをダウンロードして置く


```
apollo {
    service("service") {
        packageName.set("com.example")
    }
}
```
この部分が認識されない？→されるようになった

https://docs.github.com/ja/graphql/guides/introduction-to-graphql#discovering-the-graphql-api
schema.jsonのダウンロードが必要。.graphqlよりはこちらを使う？

こちらの前のバージョンが参考になる
https://www.apollographql.com/docs/kotlin/v2/essentials/get-started-kotlin

### GraphQL server

Githubは敷居が高いので、自作シンプルサーバを作ってみる
https://graphql.org/graphql-js/running-an-express-graphql-server/
→なかなか難しい

https://www.apollographql.com/docs/kotlin/v2/essentials/get-started-kotlin

https://apollo-fullstack-tutorial.herokuapp.com/graphql
→これを使ってみる


```kotlin
// First, create an `ApolloClient`
// Replace the serverUrl with your GraphQL endpoint
val apolloClient = ApolloClient.builder()
  .serverUrl("https://your.domain/graphql/endpoint")
  .build()

// in your coroutine scope, call `ApolloClient.query(...).toDeferred().await()`
scope.launch {
  val response = try {
    apolloClient.query(LaunchDetailsQuery(id = "83")).toDeferred().await()
  } catch (e: ApolloException) {
    // handle protocol errors
    return@launch
  }

  val launch = response.data?.launch
  if (launch == null || response.hasErrors()) {
    // handle application errors
    return@launch
  }

  // launch now contains a typesafe model of your data
  println("Launch site: ${launch.site}")
}
```

`toDeferred`が見つからない

[Kotlin coroutines | Apollo GraphQL Docs](https://www.apollographql.com/docs/kotlin/v2/advanced/coroutines/)

flowの知識が必要になってきた。
apollo coroutinesのライブラリが認識されていない？

https://www.apollographql.com/docs/kotlin/migration/3.0/#operation-apis
→awaitからexecuteになっていた。
apollo coroutinesは必要なさそう。

> ./gradlew :shared:downloadApolloSchema --endpoint="https://apollo-fullstack-tutorial.herokuapp.com/" --schema='shared/src/commonMain/graphql/schema.json'
> 
> Cannot decode introspection 
> 

とある。

自作のApolloサーバにしてみる。

[GraphQL server](inkdrop://note/mSaEOA40A)

Plugin
https://marketplace.visualstudio.com/items?itemName=GraphQL.vscode-graphql

graphql import
https://the-guild.dev/graphql/tools/docs/migration/migration-from-import
[Resolvers (GraphQL-Tools)](https://the-guild.dev/graphql/tools/docs/resolvers)
[GraphQLスキーマを外部ファイルとして読み込む方法 #Node.js - Qiita](https://qiita.com/curry__30/items/178606ab97dd7d05219a)

Schemaをダウンロードするために
[Downloading a schema | Apollo GraphQL Docs](https://www.apollographql.com/docs/ios/v0-legacy/downloading-schema/)

これのインストールが必要
https://www.apollographql.com/docs/devtools/cli/

エラーが出た
> Duplicate "graphql" modules cannot be used at the same time since different
    versions may have different capabilities and behavior.


apolloとgraphqlをグローバルにインストールすると、正しくinspectionできた。
しかし、global installはなるべくしたくないので、対応を考える
→node projectを分けたことで解決

server側のレスポンスをダイナミックにしたい


### テスト

https://chatgpt.com/c/40e19d50-73d6-4d19-9a64-48386f9c4dbd
→coroutineを使い、テストを書いた


### 後で調べること

- schema.jsonではなく、schema.graphqlでコードを自動生成する方法を見つける
  - 一応できそう。schema.graphqlsを使用する