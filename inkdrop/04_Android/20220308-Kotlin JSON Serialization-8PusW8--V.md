# Kotlin JSON Serialization

[Serialization | Kotlin](https://kotlinlang.org/docs/serialization.html)

JSON serializationを試してみる。
[Kotlin Serialization ガイド　第3章 シリアライザ - Qiita](https://qiita.com/guijiu/items/be7fa14c49cb7e3006dd)
→これは使えそうにない。
Moshiを使う方が簡単。

- 処理を一般化・共通化できない？
- できた。


保存先
[データストレージ](inkdrop://note/3JhPtL0ob)

```kotlin
   override fun <T: Any> read(cls: KClass<T>, name: String): T? {

        val file = File(context.filesDir, name)
        if (file.exists()) {

            Json.decodeFromStream<cls>(file.inputStream())

        } else {
            return null
        }

    }
```

他の実装方法
```kotlin
suspend inline fun <reified T> read(name: String): T?
```


serializer to DeserializationStrategy

おそらく簡単には一般化できない。
[kotlinx.serialization/basic-serialization.md at master · Kotlin/kotlinx.serialization](https://github.com/Kotlin/kotlinx.serialization/blob/master/docs/basic-serialization.md#generic-classes)

回避策

> Generic classes in Kotlin provide type-polymorphic behavior, which is enforced by Kotlin Serialization at compile-time. For example, consider a generic serializable class Box.
> 

```kotlin
@Serializable
class Box<T>(val contents: T)

@Serializable
class Data(
    val a: Box<Int>,
    val b: Box<Project>
)

```

[Kotlin Serialization ガイド　第4章 ポリモフィズム - Qiita](https://qiita.com/guijiu/items/b177808b03b59f76c8ee)
この方法も使えそう。

[Kotlin文法 - データクラス, ジェネリクス - Qiita](https://qiita.com/k5n/items/18adb5c3503a54e96c22)

> Polymorphic serializer was not found for missing class discriminator ('null')
> 

[Kotlin - Cannot serialize polymorphic classes. No serializer found - Stack Overflow](https://stackoverflow.com/questions/63957510/kotlin-cannot-serialize-polymorphic-classes-no-serializer-found)
[Kotlin serializationでJSONのpolymorphicなオブジェクトをデシリアライズする](https://zenn.dev/chibatching/articles/kotlin-serialization-polymorphic)

> Serializer for class 'Project' is not found.
> 

`@Serializable`を動かすためのプラグインの追加

root gradle
```
  ...
    id 'org.jetbrains.kotlin.android' version '1.6.10' apply false
    id 'org.jetbrains.kotlin.plugin.serialization' version '1.6.10' apply false
```

module gradle
```
plugins {
    id 'com.android.library'
    id 'org.jetbrains.kotlin.android'
    id 'org.jetbrains.kotlin.plugin.serialization'
}
```


@OptInについて
https://kotlinlang.org/docs/opt-in-requirements.html#module-wide-opt-in