# Camera Preview


[Previewing the Camera Output — Sample Apps Tutorials | Apple Developer Documentation](https://developer.apple.com/tutorials/sample-apps/capturingphotos-camerapreview)


[AVFoundationを使用したRAW撮影機能の実装方法｜Naoya Maeda](https://note.com/naoya_maeda_app/n/n38b0e25c0476)


```swift
    lazy var previewStream: AsyncStream<CIImage> = {
        AsyncStream { continuation in
            addToPreviewStream = { ciImage in
                if !self.isPreviewPaused {
                    continuation.yield(ciImage)
                }
            }
        }
    }()
```
ここがわからないので後で調べる

時間があれば、SwiftUIで置き換える。
