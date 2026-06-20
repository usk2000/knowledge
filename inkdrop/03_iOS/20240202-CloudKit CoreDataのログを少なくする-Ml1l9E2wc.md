# CloudKit CoreDataのログを少なくする


[ios - Reduce debug output from CoreData? - Stack Overflow](https://stackoverflow.com/questions/57905451/reduce-debug-output-from-coredata)


[Syncing a Core Data Store with CloudKit | Apple Developer Documentation](https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit/syncing_a_core_data_store_with_cloudkit)


```swift
-com.apple.CoreData.SQLDebug 0
-com.apple.CoreData.Logging.stderr 0               
-com.apple.CoreData.ConcurrencyDebug 0
-com.apple.CoreData.MigrationDebug 0
-com.apple.CoreData.CloudKitDebug 0
```

あたりを追加する
