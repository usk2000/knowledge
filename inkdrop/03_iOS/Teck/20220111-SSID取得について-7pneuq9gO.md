# SSID取得について


https://qiita.com/HackingGate/items/0eea2159a169c27fc1f4

結構難しくなっている。取れないと思って良いかも。

[iOS Wifi Management APIs](https://developer.apple.com/library/archive/qa/qa1942/_index.html)

https://developer.apple.com/documentation/networkextension/nehotspotnetwork/3666511-fetchcurrentwithcompletionhandle


https://www.webdevqa.jp.net/ja/ios/swiftを使用してiosで利用可能なwifiネットワーク名を取得する方法/1054317567/

Androidはできそうだが、セキュリティは大丈夫か？今後問題なさそうか？

https://dev.classmethod.jp/articles/ios13_get_ssid/
→この方法でもできそうだが、iOS14でできるか確認する。

[CNCopyCurrentNetworkInfo](https://developer.apple.com/documentation/systemconfiguration/1614126-cncopycurrentnetworkinfo)
```
To use this function, an app linked against iOS 12 or later must enable the Access WiFi Information capability in Xcode. For more information, see Access WiFi Information Entitlement. Calling this function without the entitlement always returns NULL when linked against iOS 12 or later.
```
つまり、Wifiを利用するときはentitlementを追加しないとならない。

```
The app uses Core Location, and has the user’s authorization to use location information.
```
ともあるので、CoreLocationも支えなくてはならない。

[Access WiFi Information Entitlement](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_networking_wifi-info)

https://developer.apple.com/documentation/networkextension/hotspot_helper
おそらくこの方法しかない。

[Hotspot Helper](https://developer.apple.com/documentation/networkextension/hotspot_helper)
```
NEHotspotHelper is only useful for hotspot integration. There are both technical and business restrictions that prevent it from being used for other tasks, such as accessory integration or Wi-Fi based location. Before using NEHotspotHelper, you must first be granted a special entitlement (com.apple.developer.networking.HotspotHelper) by Apple. For more information, see Hotspot Helper Request.
```

## 実装
- NEHotspotNetwork.fetchCurrentを実装する
  - この時点でnull
- CapabilitiiesにAccess WiFi Informationを追加
  - entitlementが追加される
  - この時点ではnull

```
NEHotspotNetwork nehelper sent invalid result code [1] for Wi-Fi information request
```

- 位置情報を許可
  - 現在のSSIDの表示ができる


## 備考
- entitlementがあるので、Appleに説明が必要になりそう
- 将来的にAppStoreで使っている旨が表示されそう
- 何故位置情報の許可が必要なのか



