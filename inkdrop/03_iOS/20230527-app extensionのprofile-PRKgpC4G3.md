# app extensionのprofile


app extension用にもprofileが必要
特にAd Hoc。

[xcode - Do i require distribution provisioning profile for notification service extension for iOS? - Stack Overflow](https://stackoverflow.com/questions/47466759/do-i-require-distribution-provisioning-profile-for-notification-service-extensio)

Ad Hoc Archiveを試してみると良さそう

codesigndoc
```
bash -l -c "$(curl -sfL https://raw.githubusercontent.com/bitrise-io/codesigndoc/master/_scripts/install_wrap-xcode.sh)"
```

→できなくなったので、手動でやる。

