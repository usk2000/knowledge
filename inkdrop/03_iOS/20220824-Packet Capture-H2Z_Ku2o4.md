# Packet Capture


- BLE Explore
- Packet Capture


[A New Way to Debug iOSBluetooth Applications | Bluetooth® Technology Website](https://www.bluetooth.com/blog/a-new-way-to-debug-iosbluetooth-applications/)
[Recording a Packet Trace | Apple Developer Documentation](https://developer.apple.com/documentation/network/recording_a_packet_trace)
[Mac のターミナルを使ってパケットトレースをキャプチャする - Apple サポート (日本)](https://support.apple.com/ja-jp/HT202013)

## Wireshark
https://medium.com/geekculture/capture-iphone-ios-http-traffic-using-wireshark-4af01a4313e6


## Proxyman
https://zenn.dev/anoworl/articles/5b6749eda8e778

## Airtoolが使えそう
https://www.intuitibits.com/2021/03/02/capturing-packet-traces-from-your-ios-device/

## SSL Proxy

https://brightdata.jp/blog/プロキシ全般/sslプロキシとは何ですか

https://www.middlewareinventory.com/blog/how-to-decrypt-https-traffic/

SSL Pinning issue
https://www.appknox.com/blog/bypass-ssl-pinning-in-ios-app

## Macをaccess pointにする
https://stackoverflow.com/questions/7166044/how-can-i-configure-wireshark-to-see-https-traffic

手動設定のプロキシはOffにする

- Wifiで通信できるか
- インターネット共有が使えるか
  - iPhone -> ケーブル -> Mac -> Wifiは使えなさそう


- Honda Guest -> iPhone -> Safari (yahoo.com)はdecreptできていた
- Honda Guest -> iPhone -> Safari (honda.com)はdecreptできている。get/post両方
- iPhone テザリング -> iPhone -> Safari (yahoo.com)もdecreptできている。get/post両方
- iPhone テザリング -> iPhone -> Safari (honda.com)もdecreptできている。get/post両方
- iPhone テザリング -> iPhone -> AccuraLink decreptできていない


## Mac越しでやって見る
- Proxyman
- Charls


### Proxyman

https://docs.proxyman.io/debug-devices/ios-device
https://docs.proxyman.io/troubleshooting/my-ios-devices-couldnt-connect-to-proxyman-via-proxy
https://docs.proxyman.io/troubleshooting/get-ssl-error-from-https-request-and-response

1. Macアプリを使ったManual Proxy
- 同じNetwork内である必要がある
- Manual Proxyを設定したら、google.comにアクセスして読み込めるか確認
- 使い終わったら、CAとManual ProxyはOffにする

2. iOSアプリを使ったpacket capture



Proxy通しているとredirectできないようなので、acura.comのWebページは見れない

Honda APIが使えない
https://medium.com/trendyol-tech/securing-ios-applications-with-ssl-pinning-38d551945306
SSL pinningがdisableされていることが原因と思われる。


- Amplitude API document確認する
  - query parameter
- Amp

