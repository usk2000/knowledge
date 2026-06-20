# Client SideでImage resize

https://imagekit.io/blog/how-to-resize-image-in-javascript/
https://stackoverflow.com/questions/23945494/use-html5-to-resize-an-image-before-upload

リサイズして画像をアップロードすることで、サーバ側に負担をかけないようにする。

https://developer.mozilla.org/ja/docs/Web/API/FileReader
https://www.html5rocks.com/ja/tutorials/file/filesystem//
→直接ファイルを編集できたら嬉しいな。

https://codepen.io/tuanitpro/pen/wJZJbp
これは書き込みはできているけど、どうだろうか。
この記事を掘り下げてみよう。

https://syncer.jp/javascript-reference/canvas-todataurl
https://qiita.com/0829/items/a8c98c8f53b2e821ac94#サーバ側-1
formからは難しいかな。セキュリティもあるし。

- 画像のアップロードは別口にする
- 画像のサイズを制限する

