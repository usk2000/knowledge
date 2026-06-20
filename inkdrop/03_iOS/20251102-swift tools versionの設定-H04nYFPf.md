# swift tools versionの設定


https://docs.swift.org/swiftpm/documentation/packagemanagerdocs/settingswifttoolsversion/

```
% swift package tools-version --set-current
```
で現在の最新のバージョンにPackage.swiftを変更する
6.2になると、
```
  platforms: [.iOS(.v26)],
```
が使えるようになる。
事前に
% swift --version
でswift6.2以降になっていることを確認する。
