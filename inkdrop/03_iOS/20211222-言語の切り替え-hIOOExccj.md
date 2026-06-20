# 言語の切り替え


## 試す
R.swiftでなんとか出来ないか？中を見てみよう。

https://stackoverflow.com/questions/29985614/how-can-i-change-locale-programmatically-with-swift

```swift
extension String {
func localized(lang:String) ->String {

    let path = NSBundle.mainBundle().pathForResource(lang, ofType: "lproj")
    let bundle = NSBundle(path: path!)

    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
}}
```

https://qiita.com/de_kichi/items/b7b12a03871c3f3bb73f

[Localizing Strings That Contain Plurals](https://developer.apple.com/documentation/xcode/localizing-strings-that-contain-plurals)

[NSLocalizedString](https://developer.apple.com/documentation/foundation/1418095-nslocalizedstring)

→まだ途中なので、来週やる


## ライブラリ作ってみる

- UIKitのUILabelを拡張したもの。IBDesignableを使う
- SwiftUIのTextのラッパー
- どちらも更新が重要
- 言語設定用のクラスも重要

## 言語の更新について考える
方法
1. Notificationなどで受け取り、値を入れ直す
2. rootViewControllerを切り替える

