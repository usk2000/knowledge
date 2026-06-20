# printとdebugPrint

違いってなんだろう。

[print](https://developer.apple.com/documentation/swift/1541053-print)
[debugPrint](https://developer.apple.com/documentation/swift/1539920-debugprint)
[print to OutputStream](https://developer.apple.com/documentation/swift/1641736-print)
[dump](https://developer.apple.com/documentation/swift/1539127-dump)

# print
```swift
func print(_ items: Any..., separator: String = " ", terminator: String = "\n")
```

> The textual representation for each item is the same as that obtained by calling String(item). 

アウトプットは`String(item)`と同じもの

# debugPrint

```swift
func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n")
```

> The textual representation for each item is the same as that obtained by calling String(reflecting: item).

アウトプットは`String(reflecting: item)`と同じもの。より詳細なデータ

[String.init(reflecting:)](https://developer.apple.com/documentation/swift/string/1541282-init/)

```swift
init<Subject>(reflecting subject: Subject)
```

- もし、SubjectがCustomDebugStringConvertibleに適合していたら、subject.debugDescriptionになる
- もし、SubjectがCustomStringConvertibleに適合していたら、subject.descriptionになる
- もし、SubjectがTextOutputStreamableに適合していたら、subject.write(to: "")の結果になる
- それ以外は、Swift Standard Libraryで自動で変換される

https://qiita.com/baikichiz/items/3544b6d5acc13cd1d856


```swift
struct Pet {
    let name: String
    let age: Int
}

let pet = Pet.init(name: "Pochi", age: 5)

print(pet) // 
debugPrint(pet)

// Pet(name: "Pochi", age: 5)
// __lldb_expr_11.Pet(name: "Pochi", age: 5)

```

```swift
struct Pet {
    let name: String
    let age: Int
}

extension Pet: CustomDebugStringConvertible {
    var debugDescription: String {
        return "name: \(name), age: \(age)"
    }
}

extension Pet: CustomStringConvertible {
    var description: String {
        return "\(name)[\(age)]"
    }
}

let pet = Pet.init(name: "Pochi", age: 5)

print(pet)
debugPrint(pet)

//Pochi[5]
//name: Pochi, age: 5

```

## TextOutputStream
https://developer.apple.com/documentation/swift/textoutputstream

```swift
struct ASCIILogger: TextOutputStream {
    mutating func write(_ string: String) {
        let ascii = string.unicodeScalars.lazy.map { scalar in
            scalar == "\n"
              ? "\n"
              : scalar.escaped(asASCII: true)
        }
        print(ascii.joined(separator: ""), terminator: "")
    }
}
```

```swift
let s = "Hearts ♡ and Diamonds ♢"
print(s)
// Prints "Hearts ♡ and Diamonds ♢"

var asciiLogger = ASCIILogger()
print(s, to: &asciiLogger)
// Prints "Hearts \u{2661} and Diamonds \u{2662}"
```

## dump
https://developer.apple.com/documentation/swift/1539127-dump

```swift
@discardableResult func dump<T>(_ value: T, name: String? = nil, indent: Int = 0, maxDepth: Int = .max, maxItems: Int = .max) -> T
```

構造化された情報を表示。

```swift
struct Pet {
    let name: String
    let age: Int
    let owner: Owner
}

struct Owner {
    let name: String
}

let pet = Pet.init(name: "Pochi", age: 5, owner: Owner(name: "Taro"))

print(pet)
debugPrint(pet)
dump(pet)

//Pet(name: "Pochi", age: 5, owner: __lldb_expr_27.Owner(name: "Taro"))
//__lldb_expr_27.Pet(name: "Pochi", age: 5, owner: __lldb_expr_27.Owner(name: "Taro"))
//▿ __lldb_expr_27.Pet
//  - name: "Pochi"
//  - age: 5
//  ▿ owner: __lldb_expr_27.Owner
//    - name: "Taro"

```