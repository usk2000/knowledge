# CoreBluetooth入門


4章

## CBCentralManager
https://developer.apple.com/documentation/corebluetooth/cbcentralmanager

https://developer.apple.com/documentation/corebluetooth/cbcentralmanager/central_manager_state_restoration_options

公式ページ
https://developer.apple.com/library/archive/documentation/NetworkingInternetWeb/Conceptual/CoreBluetooth_concepts/AboutCoreBluetooth/Introduction.html?language=swift#//apple_ref/doc/uid/TP40013257

- CBManagerState: https://developer.apple.com/documentation/corebluetooth/cbmanagerstate

別スレッドで監視する。MainThread(UI Thread)に影響させないため。
DispatchQueue
https://developer.apple.com/documentation/dispatch/dispatchqueue
https://developer.apple.com/forums/thread/53270

## スキャンを開始する
https://developer.apple.com/documentation/corebluetooth/cbcentralmanager/1518986-scanforperipherals

```swift
func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, 
                options: [String : Any]? = nil)
```


CBCentralManagerScanOptionSolicitedServiceUUIDsKeyはなんだろう。
https://stackoverflow.com/questions/21785509/purpose-of-cbcentralmanagerscanoptionsolicitedserviceuuidskey
https://grandbig.github.io/blog/2015/02/08/bl600sample2/


## CBPeripheralへの接続
- 発見したCBPeripheralを使い接続する

CBCentralManager.connect
https://developer.apple.com/documentation/corebluetooth/cbcentralmanager/1518766-connect

- サービスの探索
- キャラクタリスティックの探索

UUIDなどの値
https://konashi.ux-xu.com/documents/
https://konashi.ux-xu.com/documents/#core-ble

debugPrintだと`Device Information`などの値が表示されている。
→原因はわからない。どのようにして情報をマッピングしているのか
→ここで定義している。
https://monomonotech.jp/kurage/webbluetooth/uuid.html
https://www.bluetooth.com/specifications/assigned-numbers/


## データの読み出し

```swift
if characteristic.properties.contains(.read) {
  //値を読み出す
  peripheral.readValue(for: characteristic)                            
}
```


# 書き込み

# 通知受け取り

# UUIDを指定して受け取り
まだできていない。Service UUIDがアドバタイズされていないのかな。
CBCentralManager.retrievePeripheralsを使うとうまくいく
→アドバタイズされていないのかも
https://github.com/YUKAI/konashi-ios-sdk
→ここではUUID指定は実装されていない。

https://stackoverflow.com/questions/62738169/ios-13-5-core-bluetooth-scanning-scanforperipheralswithservices-does-not-di
→Bluetoothをリセットしてみる。
→retrivePeripheralsはリセットされていない
→他の端末でやってみるしかないかな。
→CBAdvertisementDataServiceUUIDsKeyで情報があるやつしかできない。

https://developer.apple.com/documentation/corebluetooth/cbcentralmanager/1518986-scanforperipherals
https://developer.apple.com/forums/thread/76339

ここら辺が参考になるかな。

> [CoreBluetooth] API MISUSE: Cancelling connection for unused peripheral 
> 

→リファレンス保持しなくてはならない。


DispatchQueueのラベルを取得する
https://stackoverflow.com/questions/39553171/how-to-get-the-current-queue-name-in-swift-3
```swift
if let currentQueueLabel = OperationQueue.current?.underlyingQueue?.label {
  print(currentQueueLabel)        
}
```