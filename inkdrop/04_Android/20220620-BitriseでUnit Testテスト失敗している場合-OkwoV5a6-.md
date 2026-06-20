# BitriseでUnit Testテスト失敗している場合


特にBitriseでFail状態にならない。テスト失敗したらFail状態にしてほしい。

[testing - How do I show a list of all the test failures after completion of a gradle task involving tests - Stack Overflow](https://stackoverflow.com/questions/43917709/how-do-i-show-a-list-of-all-the-test-failures-after-completion-of-a-gradle-task)
[Gradle Enterprise Gradle Plugin User Manual | Gradle Enterprise Docs](https://docs.gradle.com/enterprise/gradle-plugin/)

ソースコード変更せずにできるかな。gradlewのoptionだけでいけるかな。

[コマンドラインからテストする  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/test/command-line)


エラーがあったらexit codeを変えるのは引数でできるか。
[Differ exit code for failing test and other gradle problems · Issue #12374 · gradle/gradle](https://github.com/gradle/gradle/issues/12374)
→できなさそう

[java - Run all JUnit tests with Gradle - Stack Overflow](https://stackoverflow.com/questions/49219605/run-all-junit-tests-with-gradle)
[Gradle Goodness: Stop Build After One Failing Test - Messages from mrhaki](https://blog.mrhaki.com/2019/09/gradle-goodness-stop-build-after-one.html)
コマンドラインでできそう？
特定のtaskの時に行いたい


Bitriseの変数で何かないか調べる。
fail fastについて詳しく深掘りする

コードを変えるのを調べてアウトプット
