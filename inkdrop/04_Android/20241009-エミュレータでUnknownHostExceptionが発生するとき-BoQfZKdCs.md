# エミュレータでUnknownHostExceptionが発生するとき


[AndroidStudio内のエミュで突然HTTP通信ができなくなった件](https://zenn.dev/nenfa/articles/808ff015a8a501)

```
java.net.UnknownHostException: Unable to resolve host "APIのリンク": No address associated with hostname
```

エミュレータ起動時にPCが接続していたWifiが`Androidwifi`として設定されるので、
PCを移動した際は、エミュレータを再起動する
