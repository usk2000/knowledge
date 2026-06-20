# 単体テストTips


[効果的な単体テストを作成する](https://developer.android.com/training/testing/unit-testing?hl=ja)
[ローカル単体テストを作成する](https://developer.android.com/training/testing/unit-testing/local-unit-tests?hl=ja)
[インストゥルメント化単体テストを作成する](https://developer.android.com/training/testing/unit-testing/instrumented-unit-tests?hl=ja)

- ローカル単体テスト：Androidの機能に依存しない場合。実行時間が短いメリットがある
- インストゥルメント化単体テスト：Androdiの機能を使う場合。


[fuwamaki-media | Android: ローカル単体テストをRobolectricで実現しようとしたけど断念した備忘録](https://www.fuwamaki.com/article/249)

色々調べたが、以下の記事が参考になった。
[AndroidでContextが必要な機能のテストコードを簡単に書こうとしてとても時間がかかった話 - Qiita](https://qiita.com/hotdrop_77/items/adf0d706c0fbc4c0a5c9)
[Unit Test と Instrumented Unit Test の実行（UnitTest探求記1） - Qiita](https://qiita.com/beyondseeker/items/f1a625e75bf8085847e3)


* [x] テスト環境をセットアップする
* [x] ローカル単体テストクラスを作成する
* [x] フレームワークの依存関係を含める
* [ ] Android Builder クラスを含める
* [ ] モックの依存関係を含め
* [ ] 


Instrument Unit Testは実機を使った方が早い
