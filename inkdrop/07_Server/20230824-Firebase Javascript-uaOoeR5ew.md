# Firebase Javascript


[Firebase JavaScript API reference](https://firebase.google.com/docs/reference/js?hl=en)
[Add Firebase to your JavaScript project](https://firebase.google.com/docs/web/setup?hl=en)


> referenceerror: window is not defined

と出てしまう問題
[Next.jsとFirebaseで初回ロードでエラーが出る問題の解決](https://zenn.dev/tokiya_horikawa/articles/6008f6463a2e59)
→これで解決はしなかった。

ログをよく見ると、
> @firebase/analytics: Analytics: Firebase Analytics is not supported in this environment. Wrap initialization of analytics in analytics.isSupported() to prevent initialization in unsupported environments.

とあるので、isSuportedを使ってみる

[Analytics: problem with "prevent initialization in unsupported environments" handling · Issue #3573 · firebase/firebase-js-sdk](https://github.com/firebase/firebase-js-sdk/issues/3573)

isSuportedはPromiseなので、exportをどうするか

[javascript - How can I export promise result? - Stack Overflow](https://stackoverflow.com/questions/42958334/how-can-i-export-promise-result)

> トップレベルの 'await' 式は、'module' オプションが 'es2022'、'esnext'、'system'、'node16'　または 'nodenext' に設定されていて、'target' オプションが 'es2017' 以上に設定されている場合にのみ使用できます
> 

[tsconfig.jsonのよく使いそうなオプションを理解する](https://zenn.dev/chida/articles/bdbcd59c90e2e1)
