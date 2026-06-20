# Gitのコミットdiffを取り出す




[git - How to list only the names of files that changed between two commits - Stack Overflow](https://stackoverflow.com/questions/1552340/how-to-list-only-the-names-of-files-that-changed-between-two-commits)

[[シェル] Grepでand検索、or検索、not検索、正規表現、再帰的に検索、圧縮ファイル内検索、など行う - YoheiM .NET](https://www.yoheim.net/blog.php?q=20160302)

diffからファイルを取り出す
```
% git diff --name-only SHA-1 SHA-2 | grep -e "build.gradle" -e "/infrastructure"
```

diffから特定のキーワードを取り出す
```
% git diff --name-only SHA-1 SHA-2 | grep -e "build.gradle" -e "/infrastructure"
```

最初の１つの文字だけ
[bash - How to use grep to match lines where the first character falls in a range? - Ask Ubuntu](https://askubuntu.com/questions/964465/how-to-use-grep-to-match-lines-where-the-first-character-falls-in-a-range)

```
% grep -i "^[a-c]" data.txt
```

これでgitで追加された列を取り出す。例えば`@Singleton`
