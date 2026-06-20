# SwiftUI EnvironmentObjectでprotocolは使えない


[@EnvironmentObject and Protocols? | Apple Developer Forums](https://developer.apple.com/forums/thread/676060)

wrapすることで回避

```swift
protocol DataStore { }

class DataAccessObject: ObservableObject { }

```
