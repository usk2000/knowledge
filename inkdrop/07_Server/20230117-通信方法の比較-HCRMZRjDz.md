# 通信方法の比較


- REST API
- polling
- Graph QL
- gRPC
- MQTT
- WebSocket

[REST、gRPC、および GraphQL を使い分ける (パート 2) | エクセルソフト ブログ](https://www.xlsoft.com/jp/blog/blog/2022/06/02/post-29512/)
[GraphQL/REST/gRPCの比較](https://zenn.dev/adwd/scraps/ae6e1d177bd721)

[Live IoT Data Subscription with Apollo GraphQL and MQTT | by Shan Desai | Medium](https://medium.com/@shantanoodesai/live-iot-data-subscription-with-apollo-graphql-and-mqtt-60b7c5a86cde)

[gRPCとGraphQL - Qiita](https://qiita.com/hitochan777/items/7ecc11e77fa89be009d3)

- GraphQL over MQTT
ここらあたりを見て、同僚に意見をもらう。

AWS AppSyncはもうMQTTサポートしていないのでは？
-> WebSocketベースとなっている

[WebSocketについて調べてみた。 - Qiita](https://qiita.com/south37/items/6f92d4268fe676347160)
[HTTP/2の特徴 HTTP/1.1との違いについて | REDBOX Labo](https://blog.redbox.ne.jp/http2-cdn.html)

### WebSocket
[WebSocket - Wikipedia](https://ja.wikipedia.org/wiki/WebSocket)
[HTTP/1.1とかHTTP/2とかQUICとかにGraphQLとか、Webサーバー関連の話題についてまとめてみた。 - Panda Noir](https://www.pandanoir.info/entry/2019/02/02/201639)
[ウェブソケットからHTTP/2への旅 | ミゲル・ヒメネス | Building Lang.ai](https://building.lang.ai/our-journey-from-websockets-to-http-2-4d069c54effd)
[WebSocketには注意が必要 | POSTD](https://postd.cc/websockets-caution-required/)

- WebSocketは古く、HTTP2は新しい
- WebSocketもHTTP/2もBidirectionalを
- WebSocketは軽量、
- WebSocketはHTTP/1.1と互換性がある
- WebSocket over HTTP2もできる

### Messaging Orderの観点から
MQTTはOrderingが保証されない？QoSが異なれば。
QoSが一緒であれば、Orderingが保証される。QoS=2: Exactly once delivery
[Is message order preserved in MQTT messages? - Stack Overflow](https://stackoverflow.com/questions/30955110/is-message-order-preserved-in-mqtt-messages)
[MQTT Version 3.1.1](http://docs.oasis-open.org/mqtt/mqtt/v3.1.1/os/mqtt-v3.1.1-os.html#_Toc398718102)

### Query Language
[Query language - Wikipedia](https://en.wikipedia.org/wiki/Query_language)

### RPC
[Remote procedure call - Wikipedia](https://en.wikipedia.org/wiki/Remote_procedure_call)

### GraphQL vs gRPC
[APIs REST, GraphQL or gRPC – Who wins this game?](https://www.sensedia.com/post/apis-rest-graphql-or-grpc-who-wins-this-game)
[REST、gRPC、および GraphQL を使い分ける (パート 2) | エクセルソフト ブログ](https://www.xlsoft.com/jp/blog/blog/2022/06/02/post-29512/)
[gRPC vs REST: Is gRPC better than REST? Where to use it? - DEV Community 👩‍💻👨‍💻](https://dev.to/techschoolguru/is-grpc-better-than-rest-where-to-use-it-3blg)
[GraphQL vs gRPC | GraphQLチュートリアル](https://hasura.io/learn/graphql/intro-graphql/graphql-vs-grpc/)
[GraphQL vs. REST APIs: Why you shouldn’t use GraphQL - LogRocket Blog](https://blog.logrocket.com/graphql-vs-rest-api-why-you-shouldnt-use-graphql/)
[2022年はネイティブ×gRPCが激アツかもしれん](https://zenn.dev/efx/articles/e90a93c1bd210e)
[When to use gRPC vs GraphQL - Stack Overflow Blog](https://stackoverflow.blog/2022/11/28/when-to-use-grpc-vs-graphql/)

[GraphQLのパフォーマンスについて説明しました。パフォーマンスの問題はしばしば... | by Wojciech Trocki | Medium](https://medium.com/@wtr/graphql-performance-explained-cb4b43412fb4)

#### 検討項目
- popularity
- Learn Curve
- ドキュメント化
- Query Flexibility
- Response format
- Code Generation
- SDKは必要か
- performance
  - network speed
  - 
- code generation
- サポート言語
- メッセージ形式

### gRPCについて
GraphQLのようにFilterもできる。
[Practical API Design at Netflix, Part 1: Using Protobuf FieldMask | by Netflix Technology Blog | Netflix TechBlog](https://netflixtechblog.com/practical-api-design-at-netflix-part-1-using-protobuf-fieldmask-35cfdc606518)

https://morioh.com/p/5a36922b0c1d

[gRPCのServer-Streaming RPCを用いたPUSH通知の実現事例 | Fintan](https://fintan.jp/page/1521/)
Server Pushについては、
- ClientからServerにリクエスト
- Connection ID発行
- サーバは、connectionID で識別される “コネクション” オブジェクトを作成し、そのメッセージキューを監視する goroutine を起動する
- Server

### Mock化の観点から
https://qiita.com/disc99/items/77d1de3c808a35e9c218
gRPCはMockコードも作りやすい。

### フルマネージドではなく、gRPCなのは何故か
https://medium.com/eureka-engineering/grpc%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6pairs%E3%81%AEchat%E3%82%92%E9%AB%98%E9%80%9F%E3%81%AB%E3%81%97%E3%81%9F%E3%81%8A%E8%A9%B1-ada759635486

ユースケースとして考えられない→AHMと話した？
DKが利用できない、もしくは微妙に離れたくらいでDK使えなかったら？
DKの不具合があったら？

[GraphQLとRESTの比較─知っておきたい両者の違い](https://kinsta.com/jp/blog/graphql-vs-rest/#drawbacks-of-graphql)

### WebSocket/gRPC
[gRPC vs WebSocket | When Is It Better To Use❓](https://www.wallarm.com/what/grpc-vs-websocket-when-is-it-better-to-use)
[HTTP, WebSocket, gRPC, or WebRTC - Which protocol is best?](https://getstream.io/blog/communication-protocols/)

### HTTP2
[今更ながら HTTP/2 について調べてまとめてみた](https://zenn.dev/mryhryki/articles/2019-12-30-hatena-http2)
