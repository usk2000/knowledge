# BLE通信の暗号化


https://developer.apple.com/documentation/corebluetooth/cbcharacteristicproperties/1518732-notifyencryptionrequired

[Bluetoothのセキュリティ - Apple サポート (日本)](https://support.apple.com/ja-jp/guide/security/sec82597d97e/web)
[Bluetooth通信実装のセキュリティ観点を4ステップ + 1で理解する - Flatt Security Blog](https://blog.flatt.tech/entry/ble_security)

ペアリング方式には`Association Model`と呼ばれる4つの方法がある

- `Numeric Comparison`: 両端末に共通の6つの数字を表示し、同一であることを確認させる(後述する`Secure Connection`のみ)
- `Just Works`: `Numeric Comparison`において固定の数字を利用し、両端末にはその数字を表示しない
- `Passkey Entry`: 片方の端末で6つの数字(PIN)[7](https://blog.flatt.tech/entry/ble_security#fn:7)を表示し、もう片方の端末でその数字を入力させる
- `Out of Band(OOB)`: BLEと関係のない経路で鍵を渡す
