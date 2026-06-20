# RxSwiftの導入方法


https://swiftpack.co/package/ReactiveX/RxSwift
https://github.com/ReactiveX/RxSwift

https://github.com/ReactiveX/RxSwift/issues/2127

導入が難しいみたい。


- Carthageで導入(xcframeworkで)

```swift
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "RxSwiftSPM",
            dependencies: ["RxSwift", "RxCocoa", "RxRelay", "RxBlocking"]),
        .binaryTarget(name: "RxSwift", path: "./Carthage/Build/RxSwift.xcframework"),
        .binaryTarget(name: "RxCocoa", path: "./Carthage/Build/RxCocoa.xcframework"),
        .binaryTarget(name: "RxRelay", path: "./Carthage/Build/RxRelay.xcframework"),
        .binaryTarget(name: "RxBlocking", path: "./Carthage/Build/RxBlocking.xcframework"),

        .testTarget(
            name: "RxSwiftSPMTests",
            dependencies: ["RxSwiftSPM"]),
    ]
```


carthageはRxCocoaRuntimeを生成しない
[carthage0.38でrxCocoaRuntimeがエラーを起こすので、githubから直接xcFrameworkをダウンロードする。 - Qiita](https://qiita.com/kaba/items/83a08aa2d98bee46f283)

直接ダウンロードの方法を取る。
RxSwift 6.1ではrxCocoaRuntimeも使えそう。

Enable Testing Search Paths
https://xcodebuildsettings.com

[headerSearchPath(_:_:) | Apple Developer Documentation](https://developer.apple.com/documentation/swift_packages/cxxsetting/3112674-headersearchpath)

[Binary Frameworks with SwiftPM - Using Swift - Swift Forums](https://forums.swift.org/t/binary-frameworks-with-swiftpm/26225/2)

これも必要か？

```swift
.target(
    name: "Core",
    linkerSettings: [
        .linkedFramework("BinaryFramework"),
        .linkedFramework("BinaryFramework2"),
    ],
)
```

[SwiftPM - Binary target with sub-dependencies - Using Swift - Swift Forums](https://forums.swift.org/t/swiftpm-binary-target-with-sub-dependencies/40197/13)
binaryTargetはできないっぽい


```swift
    .target(
      name: "FirebaseCore",
      dependencies: [
        "Firebase",
        "FirebaseCoreDiagnostics",
        "FirebaseCoreInternal",
        .product(name: "GULEnvironment", package: "GoogleUtilities"),
        .product(name: "GULLogger", package: "GoogleUtilities"),
      ],
      path: "FirebaseCore/Sources",
      publicHeadersPath: "Public",
      cSettings: [
        .headerSearchPath("../.."),
        .define("Firebase_VERSION", to: firebaseVersion),
        // TODO: - Add support for cflags cSetting so that we can set the -fno-autolink option
      ],
      linkerSettings: [
        .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS])),
        .linkedFramework("AppKit", .when(platforms: [.macOS])),
      ]
    ),
```


dynamic libraryとすれば行けそう？
[ios - How to add a Swift package manager as a dynamic library in xcode 13? - Stack Overflow](https://stackoverflow.com/questions/70803099/how-to-add-a-swift-package-manager-as-a-dynamic-library-in-xcode-13)
