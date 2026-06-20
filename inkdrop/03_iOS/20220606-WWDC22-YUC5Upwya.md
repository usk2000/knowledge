# WWDC22


All Videos
[All Videos - Videos - Apple Developer](https://developer.apple.com/videos/all-videos/)

https://developer.apple.com/videos/play/wwdc2022/101/
- Apple ParkにDeveloper Center
- Developer Academy
- App Intents API
- Live Text API: 画像内のテキスト
- HomeKit, Matter
- CarPlay: 調べる
- M2 Macbook
- maxOS ventura
- Metal
- Wethear


[Platforms State of the Union - WWDC22 - Videos - Apple Developer](https://developer.apple.com/videos/play/wwdc2022/102/)
- Swift
  - Concurrency
  - 正規表現
  - Generics
  - Xcode Cloud
- SwiftUI
  - ディープリンク
  - グリッドAPI、カスタムレイアウトAPI
  - CollectionCell内にSwiftUIを追加できる
  - Swift Chart: チャートを簡単に
  - ロック画面の表示：WidgetKitをextension  
- App Intents
- Passkey: アカウントセキュリティの数々の問題を解決
- New APIs
  - Focus filter API
  - MapKit
    - より詳細
    - Look Around: street view
    - Map Server API
      - Geocode/Reverse Geocode
      - Search
      - Estimated Time of Arrival
  - WeatherKit
  - VisionKit API


CoreMLも気になる





```swift
cell.contentConfiguration = UIHostingConfiguration {
  VStack(alignment: .leading) {
    Text(song.title)
    Text(song.artist.name)
      .font(.caption)
      .foregroundStyle(.secondary)
    
  }
}
```


[Human Interface Guidelines - Human Interface Guidelines - Design - Apple Developer](https://developer.apple.com/design/human-interface-guidelines/guidelines/overview/)

[WWDC 2022 基調講演 まとめ （新しいフレームワークの紹介とSessionリンク） - Qiita](https://qiita.com/MaShunzhe/items/037580d2ed51a5a6e9d9)

## 気になるVideo

### Swift
[What's new in Swift](https://developer.apple.com/videos/play/wwdc2022/110354/)

- Swift Package
  - TOFU: Trust On First Use
    - Generate Documentation
    - Reformat source code
    - Generate test reports
  - Command plugins
    - % swift package generate-documentation    
  - Build tool plugins
    - Source code generation
    - Resource processing
    - BuildPluginを作れる

- Performace improbements
  - Build-time improvements
    - Faster type checking of generics
  - Runtime imporovements
- Concurrency updates
  - Back deployed
  - data race safety
    - distributed actor 
  - Async Algorithms package
  - Concurrency optimization
- Using the Swift concurrency instruments
  - ビジュアライズ

- Expressive Swift
  - Generic code clarity
  - improve "any" type
    - AnyCollection -> any Collection

[Meet Swift Async Algorithms](https://developer.apple.com/videos/play/wwdc2022/110355/)

- AsyncSequence
  - https://github.com/apple/swift-async-algorithms
  - zip: 複数input  

```swift
for try await (vid, preview) in zip(videos, previews) {
  try await upload(vid, preview)
}
```

  
merge: 追加されるごとに呼ばれる

```swift
for try await message in merge(primaryAccount.mesages, secondaryAccount.messages) {
  displayPreview(message)
}
```

Clock
```swift
// sleep
let clock = SuspendingClock()
var deadline = clock.now + .seconds(3)
try await clock.sleep(until: deadline)

// measure
let clock = ContinuousClock()
let elapsed = await clock.measure {
  await someLongRunningWork()
}
```

- SsupendingClock
  - デバイス時間を測る
  - アニメーションの遅延
- ContinuousClock
  - リアル時間を測る
  - 絶対時間での遅延
- debounse
  - ContinuousClock使っている
  - field inputの遅延とかに使う
  - throttleとどう違うのだろう
- chunk
  - by count
  - by time
  - by content

```swift
let batches = outboundMessages.chunked(
  by: .repeating(every: .millsecons(500))
)

let encoder = JSONEncoder()
for await batch in batches {
  let data = try encoder.encode(batch)
  try await postToServer(data)
}

```

[Meet distributed actors in Swift](https://developer.apple.com/videos/play/wwdc2022/110356/)
よくわからない。

[Embrace Swift generics](https://developer.apple.com/videos/play/wwdc2022/110352/)
わかりやすい

```swift
func feed<A>(_ animal: A) where A: Animal
->
func feed(_ animal: some Animal)

//SwiftUI
var body: some View { ... }

```

Opaque type declarations

```swift
func getValue<T>(Parameter) -> Result

let animal: some Animal = Horse()
func feed(_ animal: some Animal)
feed(Horse())
feed(Chicken())

protocol Animal {
  associatedtype Feed: AnimalFeed
  func eat(_ food: Feed)
}

struct Farm {
  func feed(_ animal: some Animal) {
    let crop = type(of: animal).Feed.grow()
    let produce = crop.harvest()
    animal.eat(produce)    
  }
  
  func feedAll(_ animals: [any Animal]) {
    for animal in animals {
      //animal.eat(food: Animal.Feed) 
      feed(animal)
    }
  }
  
}

```

some: 数あるうちの１つを確定的
- Holds a fixed concrete type
- Guarantees type relationships
any: confirmされた型の全て。Boxing
- Hold an arbitrary concrete type
- Erase type relationships

- Write some by default

### SwiftUI

### Xcode
[Visualize and optimize Swift concurrency](https://developer.apple.com/videos/play/wwdc2022/110350/)

- misuse、メモリ不足の箇所を特定できる

### Service
[Meet Apple Maps Server APIs](https://developer.apple.com/videos/play/wwdc2022/10006/)

- Geocoding
- Reverse Geocoding
- Search
- ETA: Estimated Time of Arrival

- Full Stack Architecture: Make more simple for whole architecture
- Network Performance: Resolve redundant requests
- Power Efficiency

Comic Store
- Client, backend, Apple Maps server
- 今のままでは、ClientからApple Serverにリクエストが大量に送られてしまう
- これからは、backendからApple Maps Serverにリクエストを送れる

Apple Maps Servierについて
- Auth2を使って認証する
- Maps auth token != Maps access token
- 25000 per day

## SwiftUI





---


[The SwiftUI cookbook for navigation](https://developer.apple.com/videos/play/wwdc2022/10054/)


[Explore more content with MusicKit](https://developer.apple.com/videos/play/wwdc2022/110347/)

[Enhance voice communication with Push to Talk](https://developer.apple.com/videos/play/wwdc2022/10117/)
[Get more mileage out of your app with CarPlay](https://developer.apple.com/videos/play/wwdc2022/10016/)
[What's new in SwiftUI](https://developer.apple.com/videos/play/wwdc2022/10052/)
[What's new in Xcode](https://developer.apple.com/videos/play/wwdc2022/110427/)
[Get the most out of Xcode Cloud](https://developer.apple.com/videos/play/wwdc2022/110374/)
[Meet WeatherKit](https://developer.apple.com/videos/play/wwdc2022/10003/)
[Get to know Create ML Components](https://developer.apple.com/videos/play/wwdc2022/10019/)

[Capture machine-readable codes and text with VisionKit](https://developer.apple.com/videos/play/wwdc2022/10025/)
[What's new in Create ML](https://developer.apple.com/videos/play/wwdc2022/110332/)
[What's new in Nearby Interaction](https://developer.apple.com/videos/play/wwdc2022/10008/)
[What's new with in-app purchase](https://developer.apple.com/videos/play/wwdc2022/10007/)
[Meet passkeys](https://developer.apple.com/videos/play/wwdc2022/10092/)
[Deliver reliable streams with HLS Content Steering](https://developer.apple.com/videos/play/wwdc2022/10144/)
[Adopt Variable Color in SF Symbols](https://developer.apple.com/videos/play/wwdc2022/10158/)


[What's new in Swift-DocC](https://developer.apple.com/videos/play/wwdc2022/110368/)
[Explore in-app purchase integration and migration](https://developer.apple.com/videos/play/wwdc2022/10040/)

[What’s new in CloudKit Console](https://developer.apple.com/videos/play/wwdc2022/10115/)
[Add Live Text interaction to your app](https://developer.apple.com/videos/play/wwdc2022/10026/)
[Design app experiences with charts](https://developer.apple.com/videos/play/wwdc2022/110342/)
[Optimize your use of Core Data and CloudKit](https://developer.apple.com/videos/play/wwdc2022/10119/)
[Eliminate data races using Swift Concurrency](https://developer.apple.com/videos/play/wwdc2022/110351/)

[Compose custom layouts with SwiftUI](https://developer.apple.com/videos/play/wwdc2022/10056/)
[Build global apps: Localization by example](https://developer.apple.com/videos/play/wwdc2022/10110/)

[Meet Transferable](https://developer.apple.com/videos/play/wwdc2022/10062/)
[Improve the discoverability of your Swift-DocC content](https://developer.apple.com/videos/play/wwdc2022/110369/)
[Replace CAPTCHAs with Private Access Tokens](https://developer.apple.com/videos/play/wwdc2022/10077/)

[Use Xcode to develop a multiplatform app](https://developer.apple.com/videos/play/wwdc2022/110371/)

[Discover advancements in iOS camera capture: Depth, focus, and multitasking](https://developer.apple.com/videos/play/wwdc2022/110429/)

[Design an effective chart](https://developer.apple.com/videos/play/wwdc2022/110340/)


[Swift Charts: Raise the bar](https://developer.apple.com/videos/play/wwdc2022/10137/)

