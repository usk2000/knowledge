# SPM testing

> **error: **the library 'DI' requires macos 10.13, but depends on the product 'Dependencies' which requires macos 10.15; consider changing the library 'DI' to require macos 10.15 or later, or the product 'Dependencies' to require macos 10.13 or earlier.

→`Package.swift`の`platforms`に`.macOS(.v10_15)`を追加
→iOSのUIが必要なので、macOSの指定は必要なさそう

```
xcodebuild \
  -scheme AppLibrary-Package \
  -destination 'platform=iOS Simulator,name=iPhone 16e' \
  -enableCodeCoverage YES \
  test
```