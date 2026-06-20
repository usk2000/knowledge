# SwiftUI vs Storyboard(XMLレイアウト)

比べる。

UIパーツを比べる表

- UIKit：UIを提供するフレームワーク。SwiftUIもStoryboardも最終的にはこのUIKitで表現される。
- SwiftUI：宣言的UI
- Storyboard：XML形式のレイアウト


Pros
https://www.bravesoft.co.jp/blog/archives/10973
https://and-engineer.com/articles/YR9nWBAAAPDrAh3z

Cons
https://tanabesport.com/language/

Neutral
https://engineering.mercari.com/blog/entry/20201216-4043b38af1/
→これがわかりやすい。
https://medium.com/technology-nineleaps/swift-ui-or-storyboard-675ff2b40829


## Matrix

|subject|SwiftUI|Storyboard|Code|
|--|--|--|--|
|より少ないコード量|○|×|×|
|より少ないコンパイル時間|○|×|○|
|開発スピード||||
|レビューのしやすさ|○|×|△|
|コンフリクトしにくさ|○|×|○|
|より少ないメンテナンスコスト|○|×|×|
|パフォーマンス|○|×|○|
|UIKitとの完全性|△|○|○|
|レイアウトの柔軟性|△|○|○|
|凝ったレイアウトの実現性|△|○|○|
|学習コスト|△|×|×|
|再利用性|○|×|○|
|ノウハウや記事|×|○|△|

### Others
- SwiftUI + UIKit(もしくはStoryboard)は実現できる。
- ライフサイクルはSwiftUI/UIKitベースの2つがある。途中で変えることは困難。



## SwiftUIのpros/cons

### Pros
- コード量が減る→開発スピードが上がる
  - レイアウトのコード量が約1/4になる
  - 将来的なメンテナンスコストが下がる
- コンパイル時間が減る→開発スピードが上がる
  - 画面数が多いと、コンパイル時間・開発スピードに直結する
- レイアウトのコードが見やすいので、読みやすく、レビューしやすい
  - もちろんコンフリクトが格段に減る
- AppleがSwiftUI推しなので、発展が期待できる

### Cons
- 2019年に発表され、まだ新しい手法なので、ノウハウや記事が少ない
  - 2020年にはSwiftUI 2, 2021年にはSwiftUI 3が発表されているが、SwiftUI 2でだいぶ使い勝手が良くなった。実用に耐えうる
  - Storyboardを経験している人の方が多い
- 全てのUIKitのパーツの代わりとはならない
  - 凝ったUIを作るのが苦手
  - SwiftUI 3でだいぶ網羅されている
  - できないところはUIKitを使う
- Storyboardと比べ、使い方にクセがある
  - 慣れれば良いだけだが
- 新しい技術なので、学習コストがかかる
  - ビギナーには、SwiftUIで良いのではないか


### 所感
- 主流がObjective-CからSwiftに移ったように、StoryboardからSwiftUIに主流は移りつつある
- 90%の完成度で早くアプリを出すのであれば、SwiftUIの方がメリットが大きい
  - 
- Storyboardを使った場合、開発コストもメンテナンスコストも高くなるが、そのコストを払うのは誰かを考える。
  - もしSwiftUIに慣れていないのであれば、学習コストがかかるが、開発コストなどとの
- 本来は、依頼する人が決まってから根幹の技術を決めるのではなく、その逆で決めるべき。
- アーキテクチャについてもそう。
- 安く済ませるという実情はあるとは言え、理解し難い。




