# gRPC/ProtocolBufferを試す


https://qiita.com/iceman5499/items/0df8084e0a0f6f183636

https://github.com/apple/swift-protobuf

Backend: Node.js
https://engineering.mercari.com/blog/entry/20201216-53796c2494/


### Repository
[grpc/grpc-swift](https://github.com/grpc/grpc-swift)
[apple/swift-protobuf](https://github.com/apple/swift-protobuf)
grpc-swiftをメインに使う。

### set up

２つのコマンドをインストールする。

```sh
% brew install swift-protobuf grpc-swift
```

### ファイル生成





publicにする際
[Make generated structs public · Issue #660 · apple/swift-protobuf](https://github.com/apple/swift-protobuf/issues/660)
```
--swift_opt=Visibility=Public
```

[swift-protobuf/PLUGIN.md at main · apple/swift-protobuf](https://github.com/apple/swift-protobuf/blob/main/Documentation/PLUGIN.md)

[grpc/grpc-swift: The Swift language implementation of gRPC.](https://github.com/grpc/grpc-swift)
[遂にalphaが取れた🏅grpc-swiftへの移行注意点✋やdocsに明記のない機能紹介📝](https://zenn.dev/chigichan24/articles/5dae742e00a264f7065f)
→これをやってみる。



Node.jsでgRPCを試す
[Quick start | Node | gRPC](https://grpc.io/docs/languages/node/quickstart/)
これをサンプルとして使用する。

共通ソースについて、どのように管理すれば良いかは要検討。
ロジックをカスタマイズするときはどうするのか。

[Protocol Buffers Proto3 文法 早めぐり - A Memorandum](https://blog1.mammb.com/entry/2019/10/03/212044)

[RPCの具現化であるgRPC｜作ってわかる！ はじめてのgRPC](https://zenn.dev/hsaki/books/golang-grpc-starting/viewer/rpc)

言語ガイドproto3
https://developers.google.com/protocol-buffers/docs/proto3?hl=ja

[grpc-swiftの使い方ノート](https://zenn.dev/arasan01/articles/grpc-swift-helloroute)


* [ ] bidirectionalを調べる
* [ ] 簡単なアプリを作る

読む
https://zenn.dev/hsaki/books/golang-grpc-starting/viewer/intro
https://syu-m-5151.hatenablog.com/entry/2022/04/12/130411


[grpc-ecosystem/awesome-grpc: A curated list of useful resources for gRPC](https://github.com/grpc-ecosystem/awesome-grpc)

gRPCでjavascriptのコードジェネレータはあるのか

## gRPCの認証処理あたり
[iOS Swift gRPC integration with TLS client authentication using protocol buffer | by Ambrose Silveira | Medium](https://medium.com/@ambrose12silveira/ios-swift-grpc-integration-with-tls-client-authentication-f2e2164ed125)
[What's the right way to use TLS for IOS APP? · Issue #1321 · grpc/grpc-swift](https://github.com/grpc/grpc-swift/issues/1321)
[grpc-swiftの使い方ノート](https://zenn.dev/arasan01/articles/grpc-swift-helloroute)

## gRPCのスタブは？
[遂にalphaが取れた🏅grpc-swiftへの移行注意点✋やdocsに明記のない機能紹介📝](https://zenn.dev/chigichan24/articles/5dae742e00a264f7065f)
TestClientなるものがあるみたい。




