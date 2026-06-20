# Webpack

https://www.npmjs.com/package/webpack

[ExpressをWebpackでバンドルする](https://qiita.com/wakusan-6126/items/c7963ba2359f60474e99)
この方法を使い、Webpackでアセットをバンドルする。

[Webpack](https://webpack.js.org)

[Webpack + Express環境下でのpug](https://qiita.com/KengoShimizu/items/80b60a580674cc9a0b37)
[WebpackでPugの開発環境を構築](https://zenn.dev/asano/articles/95c23f06eb95ef)
[webpack v5がリリースされたので、現状をまとめてみた](https://zenn.dev/sakito/articles/7002f4d1097a85cb2b31)


これをやってみる。
https://webpack.js.org/guides/progressive-web-application/

## Webpack + Express + Pugの構成
[Bootstrap a Web Application with #Node.js #Express #Webpack #Pug](https://erdoganbavas.medium.com/bootstrap-a-web-application-with-node-js-express-webpack-pug-aa29cf537cfa)

[devServer](https://webpack.js.org/configuration/dev-server/)
指定の方法が変わっている。

# Webpackの基本コンセプト

### Entry
メインのjavascript。デフォルトは`./src/index.js`。`entrypoint`で指定ができる。
詳しくは[Entry Points](https://webpack.js.org/concepts/entry-points/)
```js
module.exports = {
  entry: './path/to/my/entry/file.js',
};
```

### Output
バンドルされたファイルの出力先。デフォルトは`./dist/main.js`もしくは`./dist`
詳しくは[Output](https://webpack.js.org/concepts/output/)

```js
const path = require('path');

module.exports = {
  entry: './path/to/my/entry/file.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'my-first-webpack.bundle.js',
  },
};
```

### Loaders
基本はjavascriptとJSONファイルのみしか認識できないが、`Loaders`を使えば他の形式、例えばプレーンテキストファイルを認識できる。
1. `test`で指定したファイルが変換対象もしくはそのままコピーする対象
2. `use`でどのように変換するか指定

```js
const path = require('path');

module.exports = {
  output: {
    filename: 'my-first-webpack.bundle.js',
  },
  module: {
    rules: [{ test: /\.txt$/, use: 'raw-loader' }],
  },
};
```

https://webpack.js.org/awesome-webpack/#loaders
[pug-loader](https://github.com/pugjs/pug-loader)



### Plugins
`Loaders`は特定のモジュール対象だが、その他の変換もプラグインによってサポートされている。
例えば、バンドル最適化、アセット管理、環境変数など

```js
const HtmlWebpackPlugin = require('html-webpack-plugin'); //installed via npm
const webpack = require('webpack'); //to access built-in plugins

module.exports = {
  module: {
    rules: [{ test: /\.txt$/, use: 'raw-loader' }],
  },
  plugins: [new HtmlWebpackPlugin({ template: './src/index.html' })],
};
```

[基本的なプラグイン一覧](https://webpack.js.org/plugins/)
[サードパティプラグイン](https://webpack.js.org/awesome-webpack/#webpack-plugins)

### Mode
`mode`で開発環境・本番環境を指定できる。デフォルトは`production`
https://webpack.js.org/configuration/mode/
- production
- development
- none

```js
module.exports = {
  mode: 'development',
};
```

```sh
% webpack --mode=development
```

### Environment
`Webpack5`は`Node.js`が`10.13.0`以上で使える。