# AdMob導入時のエラー


https://mylife-navi.com/hayaplex/ios14-admob/
```
Undefined symbols for architecture arm64:
  "_OBJC_CLASS_$_OAConsumer", referenced from:
      objc-class-ref in XAuthTwitterEngine.o
  "_OBJC_CLASS_$_OADataFetcher", referenced from:
      objc-class-ref in ExchangeCredentialsOperation.o
  "_OBJC_CLASS_$_OAMutableURLRequest", referenced from:
      objc-class-ref in ExchangeCredentialsOperation.o
      objc-class-ref in XAuthTwitterEngine.o
      objc-class-ref in msMailViewController.o
  "_OBJC_CLASS_$_OARequestParameter", referenced from:
      objc-class-ref in ExchangeCredentialsOperation.o
  "_OBJC_CLASS_$_OAToken", referenced from:
      objc-class-ref in XAuthTwitterEngine.o
```

１つずつtargetから外した
