# Dokkaを使いドキュメントHTMLを生成


[Android開発におけるドキュメント作成"Dokka / KDoc"の導入手順 #Java - Qiita](https://qiita.com/foxsal/items/6c4a0dfbc8f8e3000077)

Base URL
https://github.com/Kotlin/dokka/issues/1390

Header
[Support custom request parameters for externalDocumentationLink · Issue #2376 · Kotlin/dokka](https://github.com/Kotlin/dokka/issues/2376)


[Introduction | Kotlin Documentation](https://kotlinlang.org/docs/dokka-introduction.html)
[Gradle Configuration Options](https://kotlinlang.org/docs/dokka-gradle.html#configuration-options)

apollo clientのソースコードを含める場合
- 生成されたソースコードのディレクトリをsourceRootsに含める
- apolloの後に行うように設定する
- suppressGeneratedFilesをfalseにする


[Generated source folders are not included in documentation · Issue #2850 · Kotlin/dokka](https://github.com/Kotlin/dokka/issues/2850)
→KMPではsupressGeneratedFilesがtrueになっていそう

検索のための`search.js`がない？

```sh
cd build/dokka/html  # Dokkaが生成したHTMLファイルのディレクトリに移動
python3 -m http.server
```

これで確認したところ、検索できた。


### 特定のフィールドを除外する場合

1. Dokkaプラグインを使う場合
2. gradleに手動で一時的にコメントアウトする

1の方法で進める
[Dokka plugins | Kotlin Documentation](https://kotlinlang.org/docs/dokka-plugins.html)
[Plugin development - Dokka](https://kotlin.github.io/dokka/1.9.20/developer_guide/plugin-development/introduction/)
https://github.com/Kotlin/dokka/tree/master/examples/plugin/hide-internal-api

事前設定として、dokkaプラグインはroot gradleで設定する

```gradle
plugins {
    id("org.jetbrains.dokka") version "1.9.20"
}

subprojects {
    apply(plugin = "org.jetbrains.dokka")
}

buildscript {
    dependencies {
        classpath("org.jetbrains.dokka:dokka-base:1.9.20")
    }
}

```

ここまで設定した後に、一度GradleをSyncする。
次に、下記のコードを加える

```
tasks.withType<DokkaTask>().configureEach {
    pluginConfiguration<DokkaBase, DokkaBaseConfiguration> {

    }
}
```

次にプロジェクトレベルのbuild.gradleに下記を追加

```
dependencies {
    dokkaPlugin("org.jetbrains.dokka:dokka-core:1.9.20")
}
```

→難しいので、諦める

### 手動でフィルタ

python scriptを使い、手動でフィルタが簡単そう。
```python

```


### フォーマット

Dokkaでよりリッチなdescriptionを表示したい場合、
[Module documentation | Kotlin Documentation](https://kotlinlang.org/docs/dokka-module-and-package-docs.html)


### Versioning

バージョン情報を入れる
[Versioning - Dokka](https://kotlin.github.io/dokka/1.4.30/user_guide/versioning/versioning/)

### Examples
https://github.com/Kotlin/dokka/tree/master/examples


### 生成できない時がある

> Unresolved reference 'build'
> 

`compileCommonMainKotlinMetadata`でエラーが出る
→何故かエラーが出る時がある