# SPMでbinary framework dependency


[Distributing Binary Frameworks as Swift Packages | Apple Developer Documentation](https://developer.apple.com/documentation/swift_packages/distributing_binary_frameworks_as_swift_packages)

リモートの`xcfraemwork`を追加するには、この方法

```swift
        .binaryTarget(
            name: "SomeRemoteBinaryPackage",
            url: "https://url/to/some/remote/xcframework.zip",
            checksum: "The checksum of the ZIP archive that contains the XCFramework."
        ),
```

RxSwiftはどうなっている？