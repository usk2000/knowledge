# Android Backup



## Googleアカウントを使う方法を試す

Google Oneを使う

[自動バックアップでユーザーデータをバックアップする](https://developer.android.com/identity/data/autobackup?hl=ja)
[バックアップと復元をテストする](https://developer.android.com/identity/data/testingbackup?hl=ja)


logcatでfile_backup_helperを検索すると、バックアップできているかどうか確認できそう。

- includeとexcludeで対象を指定・除外する
- domainに設定する値として、file, sharedpref, database, externalがある
  - 

```
    <include domain="database" path="shiftkaigo.db" />
    <include domain="sharedpref" path="default.xml" />
```
などで設定する

`<data-extraction-rules>`と`<full-backup-content>`の両方を指定した方が良いか。
 
気になる文言

```
ユーザーによってデバイスでバックアップが有効化されている。Android 9 では、この設定は [設定] > [システム] > [バックアップ] にあります。
前回のバックアップから少なくとも 24 時間経過している。
デバイスがアイドル状態である。
デバイスが Wi-Fi ネットワークに接続されている（デバイスのユーザーがモバイルデータのバックアップを有効にしていない場合）
```


Android13でバックアップを実行すると
```
2024-11-15 21:14:58.179 17498-30395 Backup                  com.google.android.gms               I  [GmsBackupTransport] Backup finished for jp.summervacation.shiftkaigo
2024-11-15 21:14:58.200 15815-15815 Backup                  com.google.android.gms.persistent    I  [BackupNowBackupAgentsRunner] Backup done for jp.summervacation.shiftkaigo, success: 0
```


### 何も設定しなかったらどうなるか

```
<device-transfer> セクションがないなど、特定のバックアップ モードに関するルールがない場合、バックアップ対象のファイル セクションに記載されているように、no-backup ディレクトリと cache ディレクトリを除くすべてのコンテンツに対して、そのモードが完全に有効になります。
```
もしかしたら、設定しなくても良い？

https://developer.android.com/guide/topics/manifest/application-element?hl=ja
```
android:fullBackupContent
この属性は、自動バックアップ用のフル バックアップ ルールが含まれる XML ファイルを指定します。このルールは、バックアップするファイルを決定します。詳細については、自動バックアップ用の構成ファイルの XML 構文をご覧ください。
この属性は省略可能です。指定しなかった場合、デフォルトでは、アプリのほとんどのファイルが自動バックアップの対象になります。詳しくは、バックアップ対象のファイルをご覧ください。
```
