# HILT

[Hilt を使用した依存関係の注入  |  Android デベロッパー  |  Android Developers](https://developer.android.com/training/dependency-injection/hilt-android?hl=ja)

Java 11でも使えそう
[Using Dagger with java 11 and maven - Stack Overflow](https://stackoverflow.com/questions/66216082/using-dagger-with-java-11-and-maven)

[Hiltの使い方 - Qiita](https://qiita.com/MoriokaReimen/items/750644062b3f5bec18ed)

[Hilt](https://dagger.dev/hilt/)

* [x] Application
* [x] Activity
* [x] ViewModel
* [ ] ProvidesとBindsの違い
* [ ] Field InjectionによるInjectionタイミング
* [ ] ActivityContextからActivityの取得
* [ ] Github APIサンプルの実装
* [ ] SingletonComponentではシングルトンになってしまうのか


[ViewModel の保存済み状態のモジュール  |  Android デベロッパー  |  Android Developers](https://developer.android.com/topic/libraries/architecture/viewmodel-savedstate)

[Inject vs Provides vs Binds in Dagger and Hilt — Mobile Dev Notes](https://www.valueof.io/blog/inject-provides-binds-dependencies-dagger-hilt)
→結構わかりやすい
コードを省略するために、Bindsを使っていそう。interfaceで。

- Binds: interfaceに紐づくimplementationの情報
  - Constructor Injectしてるやつのみ
  - 型情報でやりとりしてるみたい。同じ型だっらどうなんだろう
- Provides: 単にinterface/implementationを返す
- 外部ライブラリとか。Inject使ってないやつ

```
@Binds methods must have exactly one parameter, whose type is assignable to the return type
```

`@Provides`の中身で引数を渡す場合

- Use @Inject for code you own. 
- Use @Provides for code you don’t own.
- Use @Binds for injecting interfaces while generating less DI code. 

Binds使うときには、`@Inject constructor`が必要

## ActivityContextからActivityの取得

* [x] `@ActivityContext`からActivityにキャストできるか→できそう
* [x] Entry Pointsから取得できるか→難しそう

`@InstallIn(ActivityComponent::class)`をつけないと、`@ActivityContext`は使えなさそう。
`@ApplicationContext`はどの場合でも使えそう。

SingletonComponent	Application
ViewModelComponent	ViewModel
ActivityComponent	Activity
FragmentComponent	Fragment
ViewComponent	View
ViewWithFragmentComponent	View with @WithFragmentBindings
ServiceComponent	Service

- ComponentとScopeで同じ？
- 具体的な例は調べよう


[Dagger Hilt の Context まわりでハマったこと](https://zenn.dev/kmd_htsh0226/articles/5ea197bc242e6e67d47a)

[Entry Points](https://dagger.dev/hilt/entry-points)

