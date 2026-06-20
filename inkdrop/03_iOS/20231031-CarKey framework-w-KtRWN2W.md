# CarKey framework


### CoreBluetooth
[CarKeyRemoteControlSession | Apple Developer Documentation](https://developer.apple.com/documentation/carkey/carkeyremotecontrolsession)

> If your app has an active session, the system automatically ends that session when your app enters the background. Upon reentering the foreground, you must create a new session to communicate with your vehicle again.

とあるので、アプリがsuspendされるとsessionつまりBLEが切断されると思われる。
[iOSでの車のキーのセキュリティ - Apple サポート (日本)](https://support.apple.com/ja-jp/guide/security/secf64471c16/web)

なので、BLE接続をバックグラウンドで接続し直せば良いのかもしれない。
[iOS Background Bluetooth: BLE scan… | Apple Developer Forums](https://developer.apple.com/forums/thread/652592)

CarKeyとBLEを同時に使えるか、つまりBLE connectionが２つかどうか
[ios - What happens if we send multiple connect requests to the same device over BLE? - Stack Overflow](https://stackoverflow.com/questions/48580333/what-happens-if-we-send-multiple-connect-requests-to-the-same-device-over-ble)


余談
[CryptoKitとCoreBluetoothを利用したスマートキー開発 by saiten | トーク | iOSDC Japan 2020 - fortee.jp](https://fortee.jp/iosdc-japan-2020/proposal/184a1285-efd6-4448-bd2d-2ccf97f073bd)
