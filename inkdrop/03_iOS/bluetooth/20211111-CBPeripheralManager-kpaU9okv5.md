# CBPeripheralManager


- identifierを知ること・変更することはできるのか
できなさそう
- Central側で見つけることができない？

CBPeripheral.nameには入ってこないが、CBAdvertisementDataLocalNameKeyでは入ってくる？

https://stackoverflow.com/questions/12265028/cbperipheral-name-is-sometimes-null/17157421
Connectする前だから？

CBAdvertisementDataLocalNameKey: TestDeviceだが、
CBPeripheral.nameは"Hasegawa iPhone 6s Plus"となっていた。ペアリングしたことがあるからだろうか。これは特殊であるが、iPhoneをペリフェラルにする場合は注意が必要。

* [x] ペリフェラルの起動
* [x] サービス・キャラクタリスティックの追加
* [x] セントラルから発見
* [x] セントラルからのReadリクエストに答える
* [x] セントラルからのWriteリクエストに答える
* [x] セントラルへデータの更新を通知する


`CBMutableCharacteristic`の初期化時にvalueを設定するとdelegateは呼ばれない。

- periperal: writeWithoutResponse, central: withoutResponse：問題なし
- periperal: writeWithoutResponse, central: withResponse：問題なしだが、挙動について調査が必要
- periperal: write, central: withoutResponse
```
2021-11-16 09:16:31.095310+0900 BluetoothSample[37664:4915294] [CoreBluetooth] WARNING: Characteristic <CBCharacteristic: 0x282e12be0, UUID = 78EFF880-E01B-4244-A9EB-A4ABCF97621C, properties = 0x8A, value = {length = 11, bytes = 0x53616d706c652044617461}, notifying = NO> does not specify the "Write Without Response" property - ignoring response-less write
```
→書き込めていない。


→peripheralがバックグラウンドに行くと、
```
Error Domain=CBATTErrorDomain Code=242 "Unknown ATT error." UserInfo={NSLocalizedDescription=Unknown ATT error.}
```

- periperal: write, central: withResponse：問題なしだが、挙動について調査が必要
https://developer.apple.com/documentation/corebluetooth/cbcharacteristicwritetype


centralで履歴からconnectionリクエスト→peripheralがonになっていないとき→onになった時に検知できるのか。
途中でperipheralをoffにした時の挙動。

### Centralへの通知
- Centralで通知受け取りのon/off
- 通知結果をプリント
- Peripheralで更新処理
- Peripheralでサブスクライブの状態を監視
