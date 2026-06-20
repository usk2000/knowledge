# Bluetooth Classicの接続


[External Accessory | Apple Developer Documentation](https://developer.apple.com/documentation/externalaccessory/)
[EAAccessoryManager | Apple Developer Documentation](https://developer.apple.com/documentation/externalaccessory/eaaccessorymanager)

[About External Accessories](https://developer.apple.com/library/archive/featuredarticles/ExternalAccessoryPT/Introduction/Introduction.html#//apple_ref/doc/uid/TP40009502)


`showBluetoothAccessoryPicker`でUIが表示されない問題
https://stackoverflow.com/questions/69259457/ea-showbluetoothaccessorypicker-not-showing-in-swiftui

[ios - EA showBluetoothAccessoryPicker not showing in SwiftUI - Stack Overflow](https://stackoverflow.com/questions/69259457/ea-showbluetoothaccessorypicker-not-showing-in-swiftui)

これが解決策か？
https://stackoverflow.com/questions/69259457/ea-showbluetoothaccessorypicker-not-showing-in-swiftui

AppDelegateベースにするとうまくいく。