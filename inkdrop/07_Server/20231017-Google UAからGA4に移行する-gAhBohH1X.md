# Google UAからGA4に移行する


[[GA4] 次世代のアナリティクス、Google アナリティクス 4 のご紹介 - アナリティクス ヘルプ](https://support.google.com/analytics/answer/10089681?hl=ja)
[GA4（Google Analytics 4）とは？UAとの違いや設定方法を解説 | CANVAS（キャンバス）](https://canvas.d2cr.co.jp/data/9538/#)
[Google アナリティクスについて – ジンドゥークリエイターサポート](https://help.jimdo.com/hc/ja/articles/115005521363-Google-%E3%82%A2%E3%83%8A%E3%83%AA%E3%83%86%E3%82%A3%E3%82%AF%E3%82%B9%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

https://support.google.com/analytics/answer/12938611?hl=ja#zippy=%2C%E3%81%93%E3%81%AE%E8%A8%98%E4%BA%8B%E3%81%AE%E5%86%85%E5%AE%B9


広告クリックについてです。
２つ確認しました。

１）９月前後のアプリ側の変更が影響している可能性
差分を確認したところ、WebView周りでの影響はないと考えられます。おそらく、PlayStore Consoleに出ていた警告の対応だったかと思います。
手元で何度か確認しましたが、シフトナ・シフトカイゴともに以下の３つが正常に表示されていることを確認しました。
①WebViewの表示ロジック
②転職ランキングのボタンのNew表示（水曜日、土曜日表示）
③転職ランキングに位置情報（アクセスしている都道府県情報）を上手く渡せているか

２）WebViewで表示されているWebページに組み込まれているGoogle Analyticsに何かしらの変更があった可能性
９月くらいに御社でWebページを変更したかどうかはわかりませんが、変更していないという仮定のもの調査しました。
その結果、Google Analyticsの仕様変更が影響している可能性が高いです。

Webページを確認したところ、Google Analyticsのユニバーサルアナリティクス（UA）を使用しています。
https://kaigorank.jimdo.com/

UAについて調査したところ、UAは今年の７月くらいから段階的に停止している（イベントが送られなくなる）ようです。
代わりにGA4というものに移行しているようです。
https://support.google.com/analytics/answer/10089681?hl=ja
https://canvas.d2cr.co.jp/data/9538/#
https://help.jimdo.com/hc/ja/articles/115005521363-Google-%E3%82%A2%E3%83%8A%E3%83%AA%E3%83%86%E3%82%A3%E3%82%AF%E3%82%B9%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6

おそらくこのUAの段階的廃止が原因で、GA4への移行が早急に必要になってきます。
こちらの対応をお願いできますでしょうか。