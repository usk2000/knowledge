# 📘 GitHub Markdown可視化・ドキュメント構成まとめ

## 1. 目的

- GitHub上のMarkdownを**見やすくブラウザで確認**

- 将来的には**ドキュメントサイト化**

- UX：

  - 左カラム：ページ一覧
  - 右カラム：本文表示

***

## 2. GitHub CLIの役割

- GitHub CLIでは以下は可能：

  - PR / Issue 操作
  - リポジトリ管理

- ❌ 不可：

  - Markdownのローカルサーバ表示
  - ドキュメントレンダリング

👉 **表示用途は別ツールが必要**

***

## 3. ローカルでMarkdownを確認する方法

### A. GitHub Pages互換（本命）

- Jekyll

特徴：

- GitHub Pagesと同じ仕組み
- 複数ページ・ナビゲーション対応

起動：

```
bundle exec jekyll serve
```

***

### B. 軽量プレビュー

- grip

特徴：

- GitHubとほぼ同じ見た目
- 単一ファイル確認向け

***

### C. モダン構成（Pages使わない場合）

- VitePress
- mdBook

***

## 4. 左ナビ＋右本文レイアウト（Jekyllテーマ）

### ✅ 最適解

- Just the Docs

特徴：

- 左：ページ一覧（階層）
- 右：本文
- 検索・ナビ完備
- GitHub Pages対応

***

### 他の選択肢

- Minimal Mistakes  
  → 柔軟だが設定多め
- Docsy Jekyll  
  → ドキュメント特化・やや重い

***

## 5. ディレクトリ構成（推奨）

```
docs/
 ├── index.md
 ├── architecture.md
 ├── api.md
 └── features/
      ├── feature-a.md
      └── feature-b.md
```

👉 フォルダ構造 = ナビ構造になる（Just the Docs）

***

## 6. Mermaid対応

### 結論

- Jekyll単体では ❌ 非対応
- **JavaScriptで描画する必要あり**

***

### 実装方法（推奨）

#### Markdown

````
```mermaid
graph TD
  A --> B
````

````

---

#### Jekyllに追加

```html
<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>
````

***

### Just the Docsの場合

```
<!-- _includes/head_custom.html -->
<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>
```

***

### 補足

- Mermaidはブラウザ側で描画
- kramdownは変換のみ（描画しない）

***

## 7. 実務的な最適構成

### MVP構成

- 表示：Jekyll + Just the Docs
- 図：Mermaid（JS描画）
- ホスティング：GitHub Pages or 静的ホスティング

***

### 判断基準

| 目的        | 選択        |
| --------- | --------- |
| とにかく早く確認  | grip      |
| Pages前提   | Jekyll    |
| Pages使わない | VitePress |

***