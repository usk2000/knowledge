# 画像リサイズについて


Node.js sharpライブラリを使用する
[sharp - High performance Node.js image processing](https://sharp.pixelplumbing.com/)


## Pawuの仕様

- メイン画像は横幅最大2500px
- サムネイル画像は横幅最大200px
- 形式はjpeg
- Firebase Storageにアップロード

画像リサイズ
[Resizing images](https://sharp.pixelplumbing.com/api-resize#resize)

画像ローテーション
[Image operations](https://sharp.pixelplumbing.com/api-operation#rotate)


[Node.jsのライブラリsharpでリサイズを試してみる | Simple is Beautiful.](https://blog.kozakana.net/2019/04/sharp-resize/)

縦横を指定してリサイズが良さそう。中央だけcropされる
- メイン画像：2500 x 2500px
- サムネイル画像：200 x 200px
