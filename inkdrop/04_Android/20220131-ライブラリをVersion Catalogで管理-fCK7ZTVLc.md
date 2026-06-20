# ライブラリをVersion Catalogで管理


https://zenn.dev/usk2000/articles/b2ca635be224e8

これでライブラリ管理できる。

[Sharing dependency versions between projects](https://docs.gradle.org/current/userguide/platforms.html)

バージョンアップの方法
[littlerobots/version-catalog-update-plugin: Gradle plugin for updating a project version catalog](https://github.com/littlerobots/version-catalog-update-plugin)

```gradle
dependencyResolutionManagement {
    versionCatalogs {
        libs {
            version('groovy', '3.0.5')
            version('checkstyle', '8.37')
            library('groovy-core', 'org.codehaus.groovy', 'groovy').versionRef('groovy')
            library('groovy-json', 'org.codehaus.groovy', 'groovy-json').versionRef('groovy')
            library('groovy-nio', 'org.codehaus.groovy', 'groovy-nio').versionRef('groovy')
            library('commons-lang3', 'org.apache.commons', 'commons-lang3').version {
                strictly '[3.8, 4.0['
                prefer '3.9'
            }
        }
    }
}
```

