# Firebaseでのセッション管理

https://zenn.dev/satohjohn/articles/d39cf288dcfbe5e39c3b

[バージョン8からモジュラーWebSDKにアップグレードします](https://firebase.google.com/docs/web/modular-upgrade?hl=ja)

[Service Worker によるセッション管理](https://firebase.google.com/docs/auth/web/service-worker-sessions?hl=ja#web-version-9)
→サーバーサイドでもCSRFのリスクはない。
https://www.ipa.go.jp/security/vuln/vuln_contents/csrf.html

[セッション Cookie を管理する](https://firebase.google.com/docs/auth/admin/manage-cookies?hl=ja)
[認証状態の永続性](https://firebase.google.com/docs/auth/web/auth-state-persistence?hl=ja)

フロントで同期的な`currentUser`の取得
https://zenn.dev/phi/articles/firebase-auth-wait-for-initialization

jQuery Cookie
https://www.fenet.jp/dotnet/column/tool/6665/#jQuerycookie
https://www.jsdelivr.com/package/npm/js-cookie

CSRF
https://stackoverflow.com/questions/64851413/where-should-i-generate-the-csrf-token
https://www.npmjs.com/package/csurf
https://tech.chakapoko.com/nodejs/express/csrf.html

