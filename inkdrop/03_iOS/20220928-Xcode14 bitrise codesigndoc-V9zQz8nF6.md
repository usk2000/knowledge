# Xcode14 bitrise codesigndoc



```
To collect available code sign files, we search for installed Provisioning Profiles:"
- which has installed Codesign Identity in your Keychain"
- which can provision your application target's bundle ids"
- which has the project defined Capabilities set"
- which matches to the selected export method"
```

のエラーが出た。
Cloud上にApp Distributionがあるようだ。

https://github.com/bitrise-io/codesigndoc/issues/151

CertificateをマニュアルでXcodeから追加し直す。
→行けた