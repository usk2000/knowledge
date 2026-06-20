# Html2canvas

試してみる。

https://qiita.com/7shi/items/ba7089e864fefac69808
https://www.npmjs.com/package/node-html-to-image

* [ ] OGPのフォントを確かめてみる



```js
const font2base64 = require('node-font2base64')

const _data = font2base64.encodeToDataUrlSync('../my/awesome/font.ttf')

const html = `
<html>
  <head>
    <style>
      @font-face {
        font-family: 'testFont';
        src: url(${_data}) format('woff2'); // don't forget the format!
      }
    </style>
  </head>
...
```

https://github.com/Automattic/node-canvas#registerfont
