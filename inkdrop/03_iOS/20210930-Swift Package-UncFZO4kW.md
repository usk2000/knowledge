# Swift Package

https://developer.apple.com/documentation/swift_packages
一般的な話： https://www.swift.org/package-manager/
機能の話： https://docs.swift.org/package-manager/


[ローカルパッケージの追加](https://developer.apple.com/documentation/swift_packages/editing_a_package_dependency_as_a_local_package)

### publicとopenの違い

https://dev.classmethod.jp/articles/swift3_scoped_access_level/

- public: overrideできないようにする
- open: overrideできる、つまりsub class化を前提とする


https://developer.apple.com/documentation/xcode/creating_a_standalone_swift_package_with_xcode

https://developer.apple.com/documentation/swift_packages/bundling_resources_with_a_swift_package
リソースを取り扱いたい。
- テストのみにjsonを含めたい

[Use resources in unit tests with Swift Package Manager](https://newbedev.com/use-resources-in-unit-tests-with-swift-package-manager)

https://github.com/apple/swift-evolution/blob/master/proposals/0271-package-manager-resources.md

swift 5.3以上
```swift
// swift-tools-version:5.3
import PackageDescription

  targets: [
    .target(
      name: "Example",
      dependencies: [],
      resources: [
        // Apply platform-specific rules.
        // For example, images might be optimized per specific platform rule.
        // If path is a directory, the rule is applied recursively.
        // By default, a file will be copied if no rule applies.
        // Process file in Sources/Example/Resources/*
        .process("Resources"),
      ]),
    .testTarget(
      name: "ExampleTests",
      dependencies: [Example],
      resources: [
        // Copy Tests/ExampleTests/Resources directories as-is. 
        // Use to retain directory structure.
        // Will be at top level in bundle.
        .copy("Resources"),
      ]),
```

ここで、テスト用リソースが`Tests/ExampleTests/Resources`デイレクトりにある場合。
使うためには、`Bundle.module`からアクセスする

→`Resources`の名前はよろしくないようなので、`files`に変更
https://crieit.net/posts/Code-sign-error-bundle-format-unrecognized-invalid-or-unsuitable

- .process() : ディレクトリ内のファイルをtop-levelにコピーする
- .copy() : ディレクトリをそのままコピーする（ディレクトリ構造を保持する）