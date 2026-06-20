# getExternalStorageDirectoryを解決する


getExternalStorageDirectoryはAndroid10からは推奨されていない

[【Android】getExternalStorageDirectory()について② | ながれのブログ](https://nagare-it.com/121/)

https://developer.android.com/training/data-storage/app-specific?hl=ja
→外部装置はマウントされていないこともあるので、内部に変更してしまおう。
→メールで送信する時など、

[動作の変更点: Android 13 以上をターゲットとするアプリ  |  Android デベロッパー  |  Android Developers](https://developer.android.com/about/versions/13/behavior-changes-13?hl=ja)
これが影響するか？しなさそう。