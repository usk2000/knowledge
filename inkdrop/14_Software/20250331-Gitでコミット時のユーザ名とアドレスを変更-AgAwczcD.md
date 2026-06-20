# Gitでコミット時のユーザ名とアドレスを変更



変更
```bash
git config user.name "USK Lab"
git config user.email "38001194+lab-usk@users.noreply.github.com"
```

確認
```bash
git config user.name
git config user.email
```

## 🔧 方法：特定のリポジトリパスに応じて user.name を変える

### 1. グローバル `.gitconfig` に条件付き設定を追加する

ホームディレクトリにある `~/.gitconfig` に以下を追加：

```
[includeIf "gitdir:~/dev/my-org/"]
  path = ~/.gitconfig_myorg
```

> `gitdir:` の後に指定するのはリポジトリの\*\*パス（ディレクトリ）\*\*です。上記例では `~/dev/my-org/` 以下にあるリポジトリに対して別設定を適用しています。

```
[user]
  name = My Organization Name
  email = me@myorg.com
```