# Flowへの置き換え

https://twitter.com/the_uhooi/status/1473868302900695046?s=21


[Flow と Retrofit を組み合わせたサンプルと解説](https://qiita.com/kaleidot725/items/bcb41be03854b11aee61)
[Kotlin Coroutines Flow + RetrofitでAPIを叩いてみよう](https://qiita.com/alpha2048/items/da51ef344a424a897114)
[Retrofit 2.6で通信を非同期処理](https://qiita.com/littleFeet/items/110a2a7237341feca804)
[Coroutine Flow + Retrofit (+ Dagger Hilt) で 安全なAPIコールを実現する](https://zenn.dev/chmod644/articles/fc304b7e2508de)

https://qiita.com/kaleidot725/items/ba0ec061c114e3e4364d
https://stackoverflow.com/questions/61417190/unresolved-reference-aslivedata-while-converting-flow-to-livedata
→これも必要
[Android での Kotlin Flow](https://developer.android.com/kotlin/flow)
→これを読んで試す？


https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines.flow/index.html

## 使用するために
https://github.com/Kotlin/kotlinx.coroutines
```
dependencies {
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.6.0")
}
```


[SharedFlowとStateFlowを読み解く](https://qiita.com/tonionagauzzi/items/43dcb01f9f120e14cc23)
[LiveDataとStateFlowの違い](https://star-zero.medium.com/livedataとstateflowの違い-5c141c6eb0f9)

[Kotlin Flow と LiveData を使用した高度なコルーチンの学習](https://developer.android.com/codelabs/advanced-kotlin-coroutines?hl=ja#0)


Flow -> LiveDataへの変換
```
androidx.lifecycle:lifecycle-livedata-ktx
```


## 後で試す
[LiveData 🤝 Coroutines](https://star-zero.medium.com/livedata-coroutines-f658cc055f04)