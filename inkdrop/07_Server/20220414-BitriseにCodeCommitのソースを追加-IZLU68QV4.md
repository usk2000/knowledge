# BitriseにCodeCommitのソースを追加



SSH Keyなどの登録は終えている前提

- Create New App from Web UI
- Private
- ssh://Your-SSH-Key-ID@git-codecommit.~~~~
  - Your-SSH-Key-IDはAWS IAMで設定したキーID
- SSH: Add Own SSH
  - bitrise用のSSHキーの秘密鍵をセットアップ
- ブランチ選択
- iOS/Androidがスキャンされる
- iOS
  - Build Schemeの選択
- Android
  - モジュールの選択
  - Build Variantの入力



