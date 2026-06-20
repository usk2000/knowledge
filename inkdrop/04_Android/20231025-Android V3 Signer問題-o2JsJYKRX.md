# Android V3 Signer問題


https://note.com/nttrtech/n/n18280473a4d6

→V3が正しく署名されているか

[アプリへの署名  |  Android Studio  |  Android Developers](https://developer.android.com/studio/publish/app-signing?hl=ja)
[apksigner  |  Android デベロッパー  |  Android Developers](https://developer.android.com/studio/command-line/apksigner?hl=ja)


### apksignerへのパスを通す

```sh
export PATH=$HOME/Library/Android/sdk/build-tools/34.0.0:$PATH
```


### proof-of-rotation

最初に、証明書を書き出す
古い方
```sh
keytool -exportcert -keystore <your-keystore>.jks -alias <old-alias> -file oldCert.x509.pem -rfc
```

新しい方
```sh
keytool -exportcert -keystore <your-keystore>.jks -alias <new-alias> -file newCert.x509.pem -rfc
```

`proof-of-rotation`の作成

```sh
apksigner rotate --out proof-of-rotation.zip \
                 --old-key oldKey.pk8 oldCert.x509.pem \
                 --new-key newKey.pk8 newCert.x509.pem
```

→できない。--old-keyがないと言われる

```
% apksigner rotate --help
1. Create a new SigningCertificateLineage to enable rotation:
$ apksigner rotate --out /path/to/new/file --old-signer --ks release.jks \
    --new-signer --ks release2.jks
```



