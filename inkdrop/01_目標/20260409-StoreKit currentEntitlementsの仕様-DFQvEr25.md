# StoreKit currentEntitlementsの仕様


# StoreKit Configuration 利用時の復元仕様メモ

## 結論

今回の事象としては、**`Transaction.currentEntitlements` が再インストール後に消えるように見えるのは、`Environment = .xcode` のときだけ**だった。  
つまり、**StoreKit Configuration を使ったローカルテスト時の挙動**であり、**Sandbox では再インストール後も `currentEntitlements` から復元できた**。

そのため、実アプリの設計としては、**`Transaction.currentEntitlements` を見て復元する方針で問題ない**と判断できる。

---

## 背景

アプリには以下の非消費アイテムがある。

- `A`
- `B`
- `C`
- `Bundle`

`Bundle` を購入すると、`A/B/C` の機能をまとめて開放する。

懸念していたのは、以下のケース。

1. ユーザーが `Bundle` を購入
2. アプリを削除
3. 再インストール
4. `A/B/C` が未購入扱いになり、再購入できてしまう

この点を確認したところ、**Sandbox では `Transaction.currentEntitlements` に `Bundle` の購入情報が残っており、再構築できた**。  
一方で、**StoreKit Configuration を使った `Environment = .xcode` のテストでは、再インストール後に同じように復元できない挙動があった**。

---

## 解釈

### StoreKit Configuration 利用時
- `Environment = .xcode`
- ローカルの StoreKit テスト環境
- 再インストール後に `Transaction.currentEntitlements` が期待どおり残らない場合がある
- 実運用の復元仕様確認には向かない

### Sandbox 利用時
- `Environment = .sandbox`
- App Store に近い復元確認ができる
- 再インストール後でも `Transaction.currentEntitlements` を使って購入状態を復元できた

---

## 仕様方針

### 1. 購入状態の復元元
購入状態の復元は、**`Transaction.currentEntitlements` を正とする**。

### 2. Bundle の扱い
`Bundle` を購入している場合は、以下を開放済みとして扱う。

- `A`
- `B`
- `C`

### 3. UI 判定
`A/B/C` の購入可否は、各 Product ID 単体の購入有無ではなく、  
**最終的な開放状態**で判定する。

例:

- `Bundle` 購入済み → `A/B/C` は購入不可
- `A` 単体購入済み → `A` は購入不可、`B/C` は未購入なら購入可

### 4. 復元タイミング
以下のタイミングで `Transaction.currentEntitlements` を読み直して状態を再構築する。

- アプリ起動時
- 購入完了時
- 復元操作実行時
- `Transaction.updates` 受信時

---

## テスト運用ルール

### ローカルテスト
StoreKit Configuration によるテストは、以下の確認に使う。

- 購入フロー
- 失敗時ハンドリング
- UI 動作確認
- 基本的な transaction 処理確認

ただし、**再インストールを跨いだ復元確認の結果は過信しない**。

### 復元確認
再インストール後の復元確認は、**Sandbox 環境で行う**。

---

## 実装上の判断

今回の確認結果から、以下の方針とする。

- `Transaction.currentEntitlements` を使って復元する
- `Bundle` 購入時は `A/B/C` をまとめて開放する
- 再インストール後の復元確認は Sandbox を基準にする
- `Environment = .xcode` での再インストール挙動は、ローカルテスト特有のものとして扱う

---

## 補足

StoreKit Configuration は開発時の便利なテスト手段だが、  
**復元や再インストールを含む挙動確認については Sandbox の方を信頼する**、という運用にする。