# swift-dependencies


https://github.com/pointfreeco/swift-dependencies
[swift-dependencies の使い方・メリット・注意点](https://zenn.dev/mayaa/articles/409c07b5d9e0cb)


### Free API List

https://apilist.fun/category/random
[Free API - 90+ Public APIs For Testing [No Key] - Apipheny](https://apipheny.io/free-api/)


```swift
private enum ApiClientKey: DependencyKey {
    static let liveValue: any ApiClientProtocol = ApiClient()
    static let testValue: any ApiClientProtocol = MockApiClient()
    static let previewValue: any ApiClientProtocol = MockApiClient()
}
```
`liveValue`, `testValue`, `previewValue`を適切に設定する


https://swiftpackageindex.com/pointfreeco/swift-dependencies/main/documentation/dependencies/dependencykey

```swift
public protocol DependencyKey: TestDependencyKey {
  static var liveValue: Value { get }
  associatedtype Value = Self
  static var previewValue: Value { get }
  static var testValue: Value { get }
}

public protocol TestDependencyKey {
  associatedtype Value = Self
  static var previewValue: Value { get }
  static var testValue: Value { get }
}
```