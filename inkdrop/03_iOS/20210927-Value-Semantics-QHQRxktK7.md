# Value-Semantics

[Value Semanticsとは](https://heart-of-swift.github.io/value-semantics/)
[Value Semantics in Swift](https://github.com/apple/swift/blob/main/docs/proposals/ValueSemantics.rst)

> ある型が Value Semantics を持っているとき、その型の変数を初期化したり、値を代入したり、引数に渡したりすると、元の値のコピーが作られて、そのコピーと元の値は独立に変更することができる。つまり、どちらかを変更してももう片方には影響を与えない。
> 

```swift
struct Foo {
    var value: Int = 0
}

var a = Foo()
var b = a
a.value = 2

```
bは変わらない

