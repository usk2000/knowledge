# PandocでMarkdownからドキュメントを作成


[Pandoc User’s Guide 日本語版](https://pandoc-doc-ja.readthedocs.io/ja/latest/users-guide.html)

### Install

```zsh
% brew install pandoc
```

https://oita.oika.me/2020/11/23/markdown-to-html/


### CSS template
[pandoc template and css | memo-blog](https://dobachi.github.io/memo-blog/2020/03/06/pandoc-template-and-css/)
https://github.com/jez/pandoc-markdown-css-theme
https://jez.io/pandoc-markdown-css-theme/

### Metadata blocks
https://pandoc.org/MANUAL.html#metadata-blocks


### 生成方法

 
```sh
% pandoc DOC.md -o index.html --css=pandoc-github.css -s
```