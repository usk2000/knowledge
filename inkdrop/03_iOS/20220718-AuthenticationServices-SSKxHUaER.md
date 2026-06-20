# AuthenticationServices


## ASWebAuthenticationSession
[Authenticating a User Through a Web Service | Apple Developer Documentation](https://developer.apple.com/documentation/authenticationservices/authenticating_a_user_through_a_web_service)

[iOSアプリでのOAuth認証で、ASWebAuthenticationSessionを使用する - Qiita](https://qiita.com/atizawa/items/d4f5baca28b3828da655)

[【SwiftUI】ASWebAuthenticationSessionを使用して、Webの認証セッションを行う - Qiita](https://qiita.com/Howasuto/items/4f07b0f45460476452b0)

UIWindowを取得する
[【Swift】SwiftUIのViewからUIWindowへアクセスする方法 - Qiita](https://qiita.com/shiz/items/3b829b1521f9723aa875)
[SwiftUI App Life Cycle で View が属している keyWindow (UIWindow) を取得する](https://zenn.dev/konomae/articles/55759a688a7dfc)

ASWebAuthenticationSessionを使う

- UIApplicationDelegateAdapter を設定して自作の AppDelegate を利用する
- AppDelegate で自作の SceneDelegate を利用するように設定する
- SceneDelegate 内で UIWindowScene から keyWindow (UIWindow) を取り出す
- SceneDelegate を ObservableObject に適合させる

何故これで通用するのかがわからない。
→

> AppDelegate や SceneDelegate をObservableObject に適合させておくと、自動的に SwiftUI の Environment に設定してくれるため、@EnvironmentObject var sceneDelegate: SceneDelegate などとしてどの View からでも SceneDelegate を取り出すことができるようになります。
> 

[UIApplicationDelegateAdaptor | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/uiapplicationdelegateadaptor/)

> If your app delegate conforms to the ObservableObject protocol, as in the example above, then SwiftUI puts the delegate it creates into the Environment. You can access the delegate from any scene or view in your app using the EnvironmentObject property wrapper:

> As with the app delegate, if you make your scene delegate an observable object, SwiftUI automatically puts it in the Environment, from where you can access it with the EnvironmentObject property wrapper, and create bindings to its published properties.


[AuthenticationServices - 日本語ドキュメント - Apple Developer](https://developer.apple.com/jp/documentation/authenticationservices/)
* [ ] 色々調べてみると良いかも。
* [ ] UIWindowのところについてはアウトプットする

[@UIApplicationDelegateAdapterについて読み物 - SwiftUIからアプリ始めた人むけ | Irimasu Densan Planning - いります電算企画](https://irimasu.com/about-uiapplicationdelegateadapter)
[SwiftUI App Lifecycle. @UIApplicationDelegateAdapter | by Ruchish shah | Medium](https://medium.com/@ruchish7187/swiftui-app-lifecycle-5aa72878c8a8)


パスワードAuto Fillを使う場合、associated domainが必要？
[ios - How to get Password AutoFill to work with ASWebAuthenticationSession? - Stack Overflow](https://stackoverflow.com/questions/62008102/how-to-get-password-autofill-to-work-with-aswebauthenticationsession)


Freeeの場合、
[freee APIのアクセストークンを取得する – freee ヘルプセンター](https://support.freee.co.jp/hc/ja/articles/115000145263-freee-API%E3%81%AE%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E3%83%88%E3%83%BC%E3%82%AF%E3%83%B3%E3%82%92%E5%8F%96%E5%BE%97%E3%81%99%E3%82%8B)
> ※ 「Webアプリ認証用URL」へのアクセス時にログインする場合は、Googleアカウント等のsocial ログインではなく、freeeアカウントのメールアドレス・パスワードでログインする必要があります。
> 

→できない？試してみる
個人用のアカウントで試してみる

> https://accounts.secure.freee.co.jp/public_api/token
"client_secret=4dfb9e723499ec2e5025e8784bb1c4e867359db8a5425a9b231b849e58348a49&grant_type=authorization_code&redirect_url=free%2Dhr%2Dapp&code=12c067cea9c66008e95562ef0f1fed7d5ab51054451d0a29d7f62ad5083a8289&client_id=fa3a4abfbe4bac1a0c8ea81ad87070769e7b284a55f10dd3e3ab5ddbd6fc8f17"
{
    error = "invalid_request";
    "error_description" = "translation missing: ja.doorkeeper.errors.messages.invalid_request.missing_param";
}

エラーとなっているので、問い合わせする

OAuth2.0を試すサービスを他に探す
