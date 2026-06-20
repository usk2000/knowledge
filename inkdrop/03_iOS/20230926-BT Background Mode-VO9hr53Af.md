# BT Background Mode


[Core Bluetooth Background Processing for iOS Apps](https://developer.apple.com/library/archive/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/CoreBluetoothBackgroundProcessingForIOSApps/PerformingTasksWhileYourAppIsInTheBackground.html)

https://stackoverflow.com/questions/19932090/how-to-wake-up-ios-app-with-bluetooth-signal-ble
→Backgroundにアプリが必ずいなければならない


- BTペアリングされている
- iPhoneがCentralでなくてはならない
    - BackgroundではPeripheralとして振る舞えないから
- アプリがBakcgroundにいる必要がある
- Backgroundでは、Connectionが失われたか知ることができない


[Core Bluetooth Background Processing for iOS Apps](https://developer.apple.com/library/archive/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/CoreBluetoothBackgroundProcessingForIOSApps/PerformingTasksWhileYourAppIsInTheBackground.html#//apple_ref/doc/uid/TP40013257-CH7-SW10)
[HID over GATT Profile | Bluetooth® Technology Website](https://www.bluetooth.com/specifications/specs/hid-over-gatt-profile-1-0/)
[Technical Q&A QA1962: Conditions Under Which Bluetooth State Restoration Will Relaunch An App](https://developer.apple.com/library/archive/qa/qa1962/_index.html)
[[EVIC-433] Launch the app when Bluetooth connection events happen - Jira](https://drivemode.atlassian.net/browse/EVIC-433)


[Core Bluetooth Background Processing for iOS Apps](https://developer.apple.com/library/archive/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/CoreBluetoothBackgroundProcessingForIOSApps/PerformingTasksWhileYourAppIsInTheBackground.html)

[centralManager(_:didConnect:) | Apple Developer Documentation](https://developer.apple.com/documentation/corebluetooth/cbcentralmanagerdelegate/1518969-centralmanager)

