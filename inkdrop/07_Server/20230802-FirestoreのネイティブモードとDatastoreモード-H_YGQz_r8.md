# FirestoreのネイティブモードとDatastoreモード


[ネイティブ モードと Datastore モードからの選択  |  Cloud Datastore ドキュメント  |  Google Cloud](https://cloud.google.com/datastore/docs/firestore-or-datastore?hl=ja)


新しい Firestore データベースを作成するときは、データベース モードを選択する必要があります。同じプロジェクトでネイティブ モードと Datastore モードの両方を使用することはできません。データベース モードを選択する場合は、次のことをおすすめします。

- 新しいサーバー プロジェクトの場合は、Datastore モードで Firestore を使用する。
  - Datastore モードで Firestore を使用すると、既存の Cloud Datastore サーバー アーキテクチャを使用しながら、基本的な Datastore の制限を排除できます。Datastore モードでは、毎秒数百万回の書き込みまで自動的にスケーリングします。
- モバイルアプリやウェブアプリの場合は、ネイティブ モードで Firestore を使用する。
  - Firestore では、リアルタイムおよびオフライン機能を備えたモバイルおよびウェブ クライアント ライブラリをご利用いただけます。ネイティブ モードでは、数百万のクライアント同時実行まで自動的にスケーリングします。

> 400: The Cloud Firestore API is not available for Firestore in Datastore Mode database projects/oneday-chat/databases/(default).
> 

というエラーがGCPコンソールで見られた。Firebaseコンソールに行くと、問題なくなった。
