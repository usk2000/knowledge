# Keystore/JKSのSHA1確認方法


### .keystoreの場合

```bash
keytool -list -v -keystore your_file.keystore
```

### .jksの場合

```bash
keytool -list -v -keystore your_file.jks
```