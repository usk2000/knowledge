# Mapbox


[概要 | Maps SDK | ドキュメント | Mapbox](https://docs.mapbox.com/jp/android/maps/guides/)
[Navigation SDK | Android | Mapbox](https://docs.mapbox.com/android/navigation/guides/)

Mapbox Studioである程度のカスタマイズが可能
https://studio.mapbox.com/

Style
https://www.mapbox.jp/maps

## Map Style

Languageは基本的な言語がある。localとしてローカル（なければデフォルト）を表示できる

### Road Network
- Simple
- Standard
- Navigation


- Simple
  - Language
  - Load Width
- Standard
  - Exits: 高速道路の出口・入口（ICとかの場所）
  - Shields: 高速道路番号
  - Icon Style: Full color/Monotone, saturation, lightness
  - One way arrows: 一方通行
  - railway crossing: 踏切
  - Minor roads: ?
  - Roads under construction:
- Navigation
  - もっと細かい

速度制限はなさそう

### Transit
- aeroways
- railways: 線路
- Ferries
- Aerialways

### Point of Interest Labels
- Densityでどのくらい表示するか

### Place Labels
- Country
- State/Province
- Settlements: Cityレベル
- Settlement subdivisions: Townレベル

### Building
- 2D/3D
- Underground
- House numbers


Apple, Google Mapが優秀
特にAppleが細かいところ

- Mapbox:問題点を箇条書き
- Tomtomも契約した


## Maps
### インストール

おおよそGude通り
`com.mapbox.maps:android:10.7.0`
英語ページにバージョンがあった。

### Implementation
- Lifecycleは特に気にしなくても良くなった


### User Location
[PermissionManager](https://docs.mapbox.com/android/core/guides/#permissionsmanager)

> Use Google's Fused Location Provider
> By default, the Maps SDK uses the Android GPS and Network Providers to obtain raw location updates. In applications using Android 11, the raw location updates might suffer from precision issues.
> 

Fused Lcoation Providerを使用する

[Display the user's location](https://docs.mapbox.com/android/maps/examples/location-tracking/)

### マーカー


## Search SDK

[Search SDK | Android | Mapbox](https://docs.mapbox.com/android/search/guides/)

デフォルトの
- Histories
- Favorites

が使えそう

Geocoding
[Search | Search SDK | Android | Mapbox](https://docs.mapbox.com/android/search/guides/search/)

## Navigation SDK
[Navigation SDK | Android | Mapbox](https://docs.mapbox.com/android/navigation/guides/)

* Navigation routes
* Accurate device location updates
* Voice instruction announcements
* Real-time user progress to their destination
* Off-route detection and rerouting
* Dynamic camera adjustments during turn-by-turn navigation
* Pre-built UI components to show changing navigation information
* Support for navigating with limited or no network connection

```
ナビゲーションルート
デバイスの位置情報の正確な更新
音声指導のお知らせ
目的地までのリアルタイムのユーザーの進捗状況
オフルート検出と再ルーティング
ターンバイターンナビゲーション中の動的カメラ調整
変化するナビゲーション情報を表示するための事前構築されたUIコンポーネント
ネットワーク接続が制限されている、またはまったくない状態での操作のサポート
```

### 主な機能
- turn by turn
- free drive


- direction API: profileの設定(運転、交通での運転、歩行など)、bearing(ルートの開始方向に影響を与える)、exclude(通行料の回避など)など、多くのルートオプションがあります。

[Directions | API | Mapbox](https://docs.mapbox.com/api/navigation/directions/)

- Drop-in UIはbeta版




