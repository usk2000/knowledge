# Dependency Visualization



https://github.com/glato/emerge

pythonのバージョン変更
pyenvを使う方法
https://qiita.com/twipg/items/75fc9428e4c33ed429c0

~/.python-versionを直接いじった方が早かった

```sh
pygraphviz/graphviz_wrap.c:2711:10: fatal error: 'graphviz/cgraph.h' file not found
      #include "graphviz/cgraph.h"
               ^~~~~~~~~~~~~~~~~~~
      1 error generated.
```

brewでインストールする方法も試した
https://analytics-note.xyz/mac/mac-graphviz-install/


`glato/emerge`のSource Codeからインストールする方法を使う。

```sh
# configuration fileを作成
% python /Users/hasegawa/workspace/python/emerge/emerge.py -a swift
# 解析を実行
% python /Users/hasegawa/workspace/python/emerge/emerge.py -c swift-template.yaml
```
output directoryは作成しておく

PyGraphvizをインストール
https://qiita.com/ryoppippi/items/f484eb995ff1e913dd44

```
pip install --global-option=build_ext --global-option="-I/opt/homebrew/include/" --global-option="-L/opt/homebrew/lib/" pygraphviz
```
pathが違った。


`ignore_dependencies_containing`で余計なdependenciesを避ける