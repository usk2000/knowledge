# mergeExDexでエラー


```
Caused by: com.android.builder.dexing.DexArchiveMergerException: Error while merging dex archives: 
...
Caused by: java.lang.OutOfMemoryError: Java heap space

```

https://qiita.com/keeey/items/81e422a808ad4ae1ae3f
→これは解決しなかった

https://github.com/stripe/stripe-react-native/issues/689
→これで解決した

