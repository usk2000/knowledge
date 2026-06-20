# GraphQL schema

schemaの書き方を調べる必要がある

[Introduction - GraphQL Tutorials](https://www.apollographql.com/tutorials/side-quest-intermediate-schema-design/01-introduction)

[Interfaces - GraphQL Tutorials](https://www.apollographql.com/tutorials/side-quest-intermediate-schema-design/04-interfaces)


`input`に`interface`を定義できるか
→できない

[Can a GraphQL input type inherit from another type or interface? - Stack Overflow](https://stackoverflow.com/questions/41921137/can-a-graphql-input-type-inherit-from-another-type-or-interface)


デフォルトを設定できるか
[Input Object Types - Hot Chocolate - ChilliCream GraphQL Platform](https://chillicream.com/docs/hotchocolate/v13/defining-a-schema/input-object-types)
→できない。固定値を渡す必要がある
または、１つのenumを持つ