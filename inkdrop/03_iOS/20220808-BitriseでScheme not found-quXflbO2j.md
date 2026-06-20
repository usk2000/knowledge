# BitriseでScheme not found


[One iOS app, multiple configurations | Bitrise](https://blog.bitrise.io/post/one-ios-app-multiple-configurations)
[xcode - Bitrise.io scheme not found - Stack Overflow](https://stackoverflow.com/questions/41149994/bitrise-io-scheme-not-found)

SchemeをShareにしていないから？

Sharedになっていたが、`*.xcodeproj`の下にあった。`*.xcworkspace`の下が良い。

Manage Scheme -> ContainerがWorkspaceの方が良い？
→できた

Scheme毎に、Update Xcode Project Provisioningを適用する

