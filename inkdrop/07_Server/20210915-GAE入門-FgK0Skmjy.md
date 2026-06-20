# GAE入門

https://cloud.google.com/appengine/docs/standard/nodejs/how-to?hl=ja

ディレクトリ構造で１つのプロジェクトにGAEを複数設定
https://cloud.google.com/appengine/docs/standard/nodejs/configuration-files?hl=ja
→分割をやってみる。すぐに削除する

開発環境・本番環境ではプロジェクトを分ける

[自動スケーリングについて](https://cloud.google.com/appengine/docs/standard/nodejs/how-instances-are-managed?hl=ja)
https://www.serversus.work/topics/vyly8dwer5uql5ra5xdg/

[カスタムドメインの設定](https://cloud.google.com/appengine/docs/flexible/python/mapping-custom-domains?hl=ja)

[GitHubからデプロイ](https://qiita.com/yuki2006/items/bef132274cb97d7e1c56)

## アプリのセキュリティ
https://cloud.google.com/appengine/docs/standard/nodejs/application-security?hl=ja
設定

```yaml
handlers:
- url: /.*
  script: auto
  secure: always
  redirect_http_response_code: 301
```
`secure: always` を使用すると、すべての HTTP トラフィックが同じパスの HTTPS URL にリダイレクトされます。


##