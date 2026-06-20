# Service Worker


Firebase Authで使いたい

[Service worker の使用](https://developer.mozilla.org/ja/docs/Web/API/Service_Worker_API/Using_Service_Workers)
[Service Worker 初心者入門](https://webbibouroku.com/Blog/Article/serviceworker)

[Service Workerの更新](https://jun711.github.io/web/how-to-force-update-a-service-worker-on-chrome-firefox-and-safari/)

[Service Worker スクリプトのインストールと更新処理](https://nhiroki.jp/2018/02/15/service-worker-install-and-update-scripts)
[ServiceWorkerRegistration.update()](https://developer.mozilla.org/ja/docs/Web/API/ServiceWorkerRegistration/update)

キャッシュした方が良いのかな。キャッシュについて考える。それか、ファイル名を変える。

type: moduleを追加する。

window not found対策？
https://qiita.com/niibori/items/64d8b267f9e19a16ec4d
→ダメだった
もしかしたら、モジュール化していないからかな。

## 問題点
- updateの挙動がわからない
- getAuthが帰ってきていない？windowがないようだ。

## 解決点
* [ ] ServiceWorker.updateを使いこなす
* [ ] モジュール形式でのインポート(通常のJavascriptで)

## 解決策
- Webpackも試す
- 他のリポジトリがないか
- Cookieに戻す

