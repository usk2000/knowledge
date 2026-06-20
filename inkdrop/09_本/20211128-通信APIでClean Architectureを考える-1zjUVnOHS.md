# 通信APIでClean Architectureを考える


以下2つのモジュールを考える
- Usecase
- ApiClient


### 1.シンプル：Usecase + ApiClient

### 2.Complex: Usecase + Gateway + ApiClient

### 3.Complex: Usecase with Interface + ApiClient

初期段階では1,成熟期では2か3が適当である。
2,3はどちらでも良いが、メリット・デメリットを考える。

### Swift Moduleで考える場合
3は現実的でない。
1は変更に弱い。
2は理想的だがソースコードは増える。