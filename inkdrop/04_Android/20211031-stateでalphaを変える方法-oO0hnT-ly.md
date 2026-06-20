# stateでalphaを変える方法

https://stackoverflow.com/questions/53163354/how-do-i-add-an-alpha-channel-to-an-existing-android-color-in-xml

```
<item android:state_enabled="false"
      android:color="?android:attr/colorAccent"
      android:alpha="0.5" />
```

https://developer.android.com/guide/topics/resources/color-list-resource
> 注: 状態リストのアイテムの中で、オブジェクトの現在の状態に合致する最初のアイテムが適用されます。したがって、リスト内の最初のアイテムに上記の状態属性がいずれも含まれていない場合、そのアイテムが毎回適用されることになります。そのため、デフォルト値は常に最後に配置する必要があります。下記の例をご覧ください。
> 

→順番が重要みたい

https://stackoverflow.com/questions/3953606/how-to-specify-background-color-in-color-state-list-resources

ColorStateListはそのままcolorとして使えなく、drawableにするしかない？

https://developer.android.com/guide/topics/resources/color-list-resource?hl=ja
