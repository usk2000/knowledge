# default export


```js
const firebaseApp = initializeApp({ /* config */ });
export default firebaseApp;
```
→`export default`が使えそう。
→使えなかった。

通常のように
```js
export const firebaseApp = initializeApp({ /* config */ });
```

で良さそう

[ES6のexportについて詳しく調べた](https://qiita.com/senou/items/a2f7a0f717d8aadabbf7)

exportは使わない方が良さそうだな。