# GitHubにECDSA


RSA→ECDSAへ推奨

理由
https://github.blog/2021-09-01-improving-git-protocol-security-github/

方法
https://zenn.dev/ianchen0419/articles/94f1883348f745

Github Tokensページにアクセス
https://github.com/settings/tokens

Xcodeでトークンを入力

```
ERROR: You're using an RSA key with SHA-1, which is no longer allowed. Please use a newer client or a different key type.
Please see https://github.blog/2021-09-01-improving-git-protocol-security-github/ for more information. (-20)
```
まだ表示される

`.git/config`
```
[remote "origin"]
        url = https://github.com/usk2000/EmotionCounter-ios.git
        fetch = +refs/heads/*:refs/remotes/origin/*
```
とsshからhttpsに変更。

今後、repo configureするときはECDSAで適用されるので問題ないと思われる

SourceTreeからできない
[【Git】2021年8月13日からGitでリモートにアクセスができなくなった。Support for password authentication was removed on August 13, 2021. | iOS-Docs](https://ios-docs.dev/20210813support-for-password/)

→もう一度やる

Xcode再起動じたら治った。