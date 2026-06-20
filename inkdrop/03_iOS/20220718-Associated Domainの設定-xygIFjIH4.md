# Associated Domainの設定

[Password AutoFill | Apple Developer Documentation](https://developer.apple.com/documentation/security/password_autofill)
[Supporting Associated Domains | Apple Developer Documentation](https://developer.apple.com/documentation/xcode/supporting-associated-domains)


[Deep Link/Deep Linkingまわりのあれこれ](https://zenn.dev/msorz/articles/72a282ff71a350)

[iOS 14 の Universal Links の変更点 | Wantedly Engineer Blog](https://www.wantedly.com/companies/wantedly/post_articles/305303)
[Associated Domains Entitlement | Apple Developer Documentation](https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_associated-domains)

- Firebase Hostingを使う

### Firebase側
- Domainは取得済み  
- Firebaseをコマンドで初期化
  - ConsoleからFirebaseプロジェクトを作っている
  - プロジェクトの作成もCLIでできそう[Firebase CLI リファレンス  |  Firebase Documentation](https://firebase.google.com/docs/cli)
    - その場合、firebase initで途中で新規作成も選択できる
- HostingにDomainを設定（SSL証明書が有効になるまで数時間）
- `apple-app-site-association`を作成。中身を追加する
- Deployする

### App側
- Associated Domainsを設定
- 


> Starting with macOS 11 and iOS 14, apps no longer send requests for apple-app-site-association files directly to your web server. Instead, they send these requests to an Apple-managed content delivery network (CDN) dedicated to associated domains.
While you’re developing your app, if your web server is unreachable from the public internet, you can use the alternate mode feature to bypass the CDN and connect directly to your private domain.
> macOS11およびiOS14以降、アプリはapple-app-site-associationファイルのリクエストをWebサーバーに直接送信しなくなりました。 代わりに、これらのリクエストを、関連付けられたドメイン専用のAppleが管理するコンテンツ配信ネットワーク（CDN）に送信します。
アプリの開発中に、パブリックインターネットからウェブサーバーにアクセスできない場合は、代替モード機能を使用してCDNをバイパスし、プライベートドメインに直接接続できます。