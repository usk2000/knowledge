# Canvas画像をCloud Storageに保存


```js
  var file = admin.storage().bucket().file(path);

  //https://qiita.com/tshida951/items/c64ed8057bdf8f52bad2

  // await file.save(canvas.createJPEGStream()); 何故かできない
  await file.save(canvas.toBuffer("image/jpeg"));

  await file.makePublic(); //公開設定
  let url = file.publicUrl();
  // res.send('<img src="'+canvas.toDataURL()+'" />');
  res.send('<img src="'+url+'" />');
```