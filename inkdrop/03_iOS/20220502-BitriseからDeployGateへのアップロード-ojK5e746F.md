# BitriseからDeployGateへのアップロード


[BitriseとDeployGateを連携しAndroidアプリのアッ。プデートを配布 - Qiita](https://qiita.com/yoppie_x/items/c4279c6eaa0e03cef861)

[BitriseからDeployGateへデプロイする - CatHand Blog](https://www.cathand.app/entry/2021/01/09/220000)

deployできない。
Unauthorized upload target。

権限の問題か？
[メンバー情報の確認](https://docs.deploygate.com/docs/enterprise-user-show)
「開発者」の権限が必要そう

```
% dg deploy path/to/apk --user organization_name
```
You do not have a permission to upload applications.
権限の問題がありそう

自分のアカウント、メールで試してみる

