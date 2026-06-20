# Spreadsheet→JSON


[✏️【GAS】詳解!スプレッドシートからJSON出力した話✏️](https://zenn.dev/k_saito_en/articles/7bf03f16a63fe8)
[[Swift]スプレッドシートのデータをJSONに書き出して読み込む[gas]](https://zenn.dev/oka_yuuji/articles/8262f0254cf80f)

プラグインよりは自作したほうが早い。

```
function exportJson() {
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
  const data = sheet.getDataRange().getValues();

  if (data.length < 2) {
    Logger.log("No data to process.");
    return;
  }

  const keys = data[0]; // 1行目（ヘッダー）をキーとして取得
  const jsonData = [];

  for (let i = 1; i < data.length; i++) {
    let rowObject = {};

    for (let j = 0; j < keys.length; j++) {
      if (!keys[j]) continue; // 空のカラムは無視
      setNestedValue(rowObject, keys[j], data[i][j]);
    }

    jsonData.push(rowObject);
  }

  Logger.log(JSON.stringify(jsonData, null, 2));
}

/**
 * オブジェクトにネストされたキーの値をセットする
 * @param {Object} obj - 対象オブジェクト
 * @param {string} path - ドット区切りのキー
 * @param {any} value - セットする値
 */
function setNestedValue(obj, path, value) {
  const keys = path.split(".");
  let current = obj;

  for (let i = 0; i < keys.length - 1; i++) {
    let key = keys[i];

    // 配列のキー変換 (例: content_1.title → content[0].title)
    const match = key.match(/(.*)_(\d+)$/);
    if (match) {
      key = match[1]; // `content` の部分を取得
      const index = parseInt(match[2], 10) - 1; // `1` を `0` に変換

      if (!Array.isArray(current[key])) {
        current[key] = [];
      }

      // 必要なインデックスにオブジェクトを用意
      if (!current[key][index]) {
        current[key][index] = {};
      }
      current = current[key][index];
    } else {
      if (!current[key]) {
        current[key] = {};
      }
      current = current[key];
    }
  }

  current[keys[keys.length - 1]] = value;
}

```