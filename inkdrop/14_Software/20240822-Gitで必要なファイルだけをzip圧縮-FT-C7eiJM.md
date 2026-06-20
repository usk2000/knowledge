# Gitで必要なファイルだけをzip圧縮


[git コマンドで不要ファイルを除いて zip 圧縮する | White Space](https://white-space.work/compressed-files-exclude-specific-files-with-git/

`.gitattributes`に

```sh
/.* export-ignore
```

```sh
% git archive [branch name] --format=zip -o output.zip
```


