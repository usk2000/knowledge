# The Book

https://www.rust-lang.org/ja/learn
https://doc.rust-lang.org/book/
https://doc.rust-jp.rs/book-ja/

## Hello World!

プロジェクトディレクトリを作成
```
% mkdir -p workspace/rust/helloworld
% cd workspace/rust/helloworld
```

コードを書く
```rust
fn main() {
    println!("Hello, world!");
}
```

コンパイルと実行
```
% rustc main.rs
% ./main
Hello, world!
```

`println!`の`!`はRustのマクロ関数を呼び出している。

## Hello Cargo

Cargoは、Rustのビルドシステム兼、パッケージマネージャ

インストールされているか確認
```
% cargo --version
cargo 1.55.0 (32da73ab1 2021-08-23)
```

プロジェクト作成
```
% cargo new hello_cargo --bin
     Created binary (application) `hello_cargo` package
% cd hello_cargo
```

`--bin`引数が、 ライブラリとは対照的に実行可能なアプリケーション(イナリ)を作成します。
`git`リポジトリも作成される

`Cargo.toml`の中身
```
[package]
name = "hello_cargo"
version = "0.1.0"
edition = "2018"

# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html

[dependencies]

```

`[package]`: パッケージの内容
`[dependencies]`: 依存関係
`src/`配下にRustのソースコードがあることが期待されている。

ビルド
```
% cargo build
   Compiling hello_cargo v0.1.0 (/path/to/hello_cargo)
    Finished dev [unoptimized + debuginfo] target(s) in 0.80s
```

`target/debug/hello_cargo`に実行ファイルがある

ビルドから実行まで
```
% cargo run
    Finished dev [unoptimized + debuginfo] target(s) in 0.00s
     Running `target/debug/hello_cargo`
Hello, world!

```

コンパイルできるかチェック
```
% cargo check
    Checking hello_cargo v0.1.0 (/path/to/hello_cargo)
    Finished dev [unoptimized + debuginfo] target(s) in 0.12s
```

リリースビルド
```
% cargo build --release
```

- 最適化を行なってコンパイルすることができます。
- target/debugではなく、 target/releaseに実行可能ファイルを作成します。
- 最適化は、Rustコードの実行を速くしてくれますが、 オンにするとプログラムをコンパイルする時間が延びます。