# StoreKit まとめ買い問題

## 非消費アイテム Bundle 購入後に、再インストールすると A/B/C を再購入できてしまう問題

### 概要

アプリ内課金で以下の構成を持っている。

- 非消費アイテム `A`
- 非消費アイテム `B`
- 非消費アイテム `C`
- 非消費アイテム `Bundle`

`Bundle` を購入すると、`A/B/C` の機能をまとめて使える仕様にしている。

しかし、ユーザーが `Bundle` 購入後にアプリを削除して再インストールすると、アプリ側で `A/B/C` を未購入と誤判定し、個別購入ボタンが再び押せてしまう問題がある。

Apple の StoreKit 2 では、現在有効な権利の確認には `Transaction.currentEntitlements` を使うのが基本であり、非消費アイテムもここから取得して復元する前提になっている。

### 原因

原因は、購入状態を **Product ID 単位でしか判定していない** こと。

たとえば `A` の購入可否を判断するときに、

- `A` 自身を買ったか

だけを見ていて、

- `Bundle` を買った結果として `A` の機能が解放済みか

を見ていない。

また、ローカル保存だけに依存している場合、アプリ削除で状態が消えるため、再インストール後に正しい復元ができない。Apple は購入後のコンテンツ解放と、復元時の再構築をアプリ側の責務として説明している。

### 問題点

#### 1. Product ベースで判定している

`A` を買っていないから `A` は購入可能、と単純判定してしまう。  
しかし実際には `Bundle` 購入によって `A` は利用可能になっている。

#### 2. Feature ベースの権利管理になっていない

本来見るべきなのは「`A` の Product を買ったか」ではなく、  
**「featureA が解放済みか」** である。

#### 3. 再インストール後の復元設計が弱い

アプリ起動時や復元時に、StoreKit から entitlement を再構築していないと、購入状態が正しく戻らない。StoreKit 2 は `Transaction.currentEntitlements` や transaction updates を使って現在の権利状態を判断できる。

### 解決方針

#### 方針1: Product ではなく Feature で管理する

以下のような対応関係を持つ。

- `product.a` → `featureA`
- `product.b` → `featureB`
- `product.c` → `featureC`
- `product.bundle` → `featureA`, `featureB`, `featureC`

そして、UI や機能開放の判定は Product ID ではなく **Feature の解放状態** を使う。

#### 方針2: 起動時に entitlement を再構築する

アプリ起動時に `Transaction.currentEntitlements` を走査し、現在有効な購入済み Product を取得する。そこから最終的な解放済み Feature 集合を作る。Apple も current entitlements を使って「今ユーザーがアクセス権を持つコンテンツ」を判断する設計を示している。

#### 方針3: 購入ボタン表示も Feature 基準にする

たとえば `Bundle` を持っているなら、

- `A/B/C` は「購入済み」または「Bundleで解放済み」と表示
- 個別購入ボタンは非表示または disabled

にする。

#### 方針4: 更新イベントにも追従する

以下のタイミングで entitlement を再計算する。

- アプリ起動時
- 購入完了時
- 復元実行後
- `Transaction.updates` 受信時

これにより、別デバイス購入や遅延反映にも対応しやすくなる。

### 実装方針

#### やること

- StoreKit から現在の購入済み Product 一覧を取得する
- Product → Feature のマッピングで解放済み機能を組み立てる
- UI は `canPurchase(feature:)` のような API を使う
- `Bundle` 購入済みなら `A/B/C` の個別購入を不可にする

#### やらないこと

- `UserDefaults` だけで購入状態を持つ
- `A` は `A` の購入履歴だけで判定する
- Bundle 購入結果をローカルフラグだけで持つ

### 期待される結果

- `Bundle` 購入後に再インストールしても、`A/B/C` は自動で解放状態になる
- `A/B/C` の個別購入ボタンは表示されない、または押せない
- 単体購入と Bundle 購入が混在しても、最終的に正しい機能解放状態を復元できる
