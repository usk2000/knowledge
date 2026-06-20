# Xcode CloudでSPMパッケージ依存がある時


[Xcode Cloud を iOS アプリ（個人開発）に導入した際の所感 - Qiita](https://qiita.com/tanakadaichi_1989/items/a39db2046fc4a4fd57b1#%E6%B3%A8%E6%84%8F%E3%81%99%E3%82%8B%E3%81%93%E3%81%A8)

次のファイルを追加
```
*.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved
```

ついでに追加
```
EmotionCounter.xcodeproj/xcshareddata/xcschemes/EmotionCounter.xcscheme
.swift-format
```