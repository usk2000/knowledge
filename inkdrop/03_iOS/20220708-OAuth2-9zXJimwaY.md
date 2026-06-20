# OAuth2


[[iOS]OAuth認証を極める（GitHubAPIで学ぶOAuth認証のフロー） - Qiita](https://qiita.com/yyokii/items/87d4975716f1a6ed620c)

https://github.com/p2/OAuth2

Content-Type:application/x-www-form-urlencoded
の場合
[ios - Swift 4 send POST request as x-www-form-urlencoded - Stack Overflow](https://stackoverflow.com/questions/48720925/swift-4-send-post-request-as-x-www-form-urlencoded)

→AuthenticationServicesを使う
[AuthenticationServices](inkdrop://note/SSKxHUaER)

Refresh TokenをRevokeすることで、余計な確認処理が走らなくて済む。
[Revoke Refresh Tokens](https://auth0.com/docs/secure/tokens/refresh-tokens/revoke-refresh-tokens)


servers sideでaccess_tokenを検証する
https://stackoverflow.com/questions/12296017/how-to-validate-an-oauth-2-0-access-token-for-a-resource-server
- 毎回検証するのはhigh latencyとなるので、避ける
- １回認証したら、sessionを発行する
- redisとかのin memoryにする
→あまりBackendについては踏み込まない



