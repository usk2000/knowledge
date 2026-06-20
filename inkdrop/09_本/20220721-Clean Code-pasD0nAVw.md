# Clean Code


## 名前

### 意図が明確な名前
```swift
var d: Int // 日単位の経過時間
```

```swift
var epalsedTimeInDays: Int
var daysSinceCreation: Int
var daysSinceModification: Int
var fileAgeInDays: Int
```

```swift
func getThem() -> [[Int]] {
  var list1: [[Int]] = []
  for x in theList {
    if (x[0] == 4) {
      list1.add(x)
    }   
  }
  return list1
}

public func getFlaggedCells() {
  var flaggedCells: [Cell] = []
  for cell in gameBoard {
    if cell.isFlagged {
      flaggedCells.add(cell)
    }
  }
  return flaggedCells
}

```

### 意味のある対比
```swift
public func copyChars(a1: [Char], a2: [Char]) {
  for (index, element) in a1.enumerated() {
    a2[index] = element
  }
}

public func copyChars(source: [Char], destination: [Char]) {
  for (index, element) in source.enumerated() {
    destination[index] = element
  }
}
```

意味がわからない名前
```swift
getActiveAccount()
getActiveAccounts()
getActiveAccountInfo()
```

### 発音可能な名前を使用する
```swift
class DtaRcrd102 {
  var genymdhms: Date
  var modymdhms: Date
  static let pszqint = "102"
}
```

```swift
class Customer {
  var generationTimestamp: Date
  var modificationTimestamp: Date
  static let recordId = "102"
}
```

### 検索可能な名前を用いる
１文字の名前と、数字定数(Magic Number)は、検索で見つけにくい

```swift
for j in 0..<34 {
  s += (t[j]*4)/5
}

let realDaysPerIdealDay = 4
let WORK_DAYS_PER_WEEK = 5
var sum = 0

for j in 0..<NUMBER_OF_TASKS {
  let realTaskDays = taskEstimate[j] * realDaysPerIdealDay
  let realTaskWeeks = (realTaskDays / WORK_DAYS_PER_WEEK)
  sum += realTaskWeeks
}

```

### メンバープレフィックス
つけない。あれば古いコード
インターフェースとかも。`I***`とか。
つけるとしたらポストフィックス。`***Impl`など

### メンタルマッピングを避ける
名付けた名前を、コードを読む人が心の中で名前に変換しなければならない状況は作るべきではない。
例えば、１文字の変数名。

### クラス名
クラス、オブジェクトにはCustomer, WikiPage, Account, AddressParserCustomerのような名詞・名詞句を付ける。
Manager, Processor, Data, Infoのような名前は避ける。

### メソッド名
postPayment, deletePage, saveといった動詞・動詞句を付ける。
get, set, isは前置する。
(Swiftではisだけか)

```swift
paycheck.isPosted
```

### 気取らない
面白さと言う価値より、明確さのほうが大事。

### １つのコンセプトには１つの単語
controller, manager, driverの多用は避ける。
Devicemanager, ProtocolControllerの本質的な違いがわからないから。

### 語呂合わせをしない
addではなく、insert, appendなど明確にする

### 解決領域の用語の使用
プログラマが知っている用語を使う。
AccoutnVisitor, JobQueueなど

### 問題領域の用語の使用
上記で解決できない場合、問題領域から名前を持ってくる。業務の専門家に聞くことができる。
この２つの領域を分離することが重要。

### 意味のある文脈を加える

```swift
public class GuessStatisticsMessage {
  var number: String = ""
  var verb: String = ""  
  var pluralModifier: String = ""
  
  public func make(candidate: Char, count: Int) -> String {
    createPluralDependentMessageParts(count)
    return "There \(verb) \(number) \(candidate) \(pluralModifier)"
  }
  
  private func createPluralDepeendentMessageParts(count: Int) {
    if count == 0 {
      thereAreNoLetters()
    } else if count == 1 {
      thereIsOneLetter()
    } else {
      thereAreManyLetters(count)
    }
  }
  
  private func thereAreManyLetters(count) {
    number = String(count)
    verb = "are"
    pluralModifier = "s"
  }
  
  private func thereIsOneLetter() {
    number = "1"
    verb = "is"
    pluralModifier = ""    
  }
  
  private func thereAreNoLetters() {
    number = "no"
    verb = "are"
    pluralModifier = "s"
  }
  
}
```

### 根拠のない文脈を与えない
クラス名のプレフィックスにアプリケーション独特の文字を加えない。
IDEの支援機能の邪魔をしているから。
短い名前は、意味が明確である限りは、長い名前より優れている。必要以上に文脈を名前に付け加えない。
accountAdress, customerAdressは、Adressクラスのインスタンス名としては良いが、クラス名とするのは不適切。

### 最後に
名前の選択は、教える能力の問題。
ここに挙げた規則を守り、コードの読みやすさが改善するかどうかみてみて下さい。


## 関数
### 小さいこと
関数は短くしなければならない
ifなどのブロック内は関数に置き換えることができる。処理内容を上手に表現できるから。

### １つのことを行う
関数では１つのことを行うようにせよ。その１つのことをきちんと行い、それ以外のことは行ってはならない。

### １つの関数に１つの抽象レベル
コード通読：逓減規則
コードは上から下へ物語のように読める必要がある。

### switch文

```swift
func calculatePay(e: Employee) throws -> Money {
  switch e.type {
    case .commisioned:
      return calculateCommissionedPay(e)
    case .hourly:
      return calculateHourlyPay(e)
    case .salaried:
      return calculateSalariedPay(e)
    default:
      throw InvalidEmployeeTypeError(e.type)
  }
}
```

これを以下のように書き換える
```swift
protocol Employee {
  func isPayday() -> Bool
  func calculatePay() -> Money
  func deliverPay(pay: Money)
}

protocol EmployeeFactory {
  func makeEmployee(r: EmployeeRecord) throws -> Employee
}

class EmployeeFactoryImpl: EmployeeFactory {
  override func makeEmployee(r: EmployeeRecord) throws -> Employee {
    switch r.type {
      case .commissioned:
        return CommissionedEmployee(r)
      case .hourly:
        return HourlyEmployee(r)
      case .salaried:
        return SalariedEmployee(r)
      default:
        throw InvalidEmployeeType(r.type)
    }
  }
}
```

### 内容をよく表す名前を使う
関数を小さくし、内容をよく表す名前を付けること。
適切な名前を追求することで、コードの構造を改善することにつながっていく。
整合性を持って名前を付ける。

### 関数の引数
関数の引数は、理想的には０、次に１、次に２。３はできれば避けるべき。４以上は避けるべき。
引数があると、テストも難しくなる。

### 共通モナディック形式
入力引数に対して何らかの変換を行うのであれば、それは戻り値として返すべき

### コマンド・照会の分離原則
オブジェクトの状態の変更と、応答を返すかのどちらかを行う。

### 戻り値より例外を好む
戻りコードの代わりに例外を使用すれば、コードは単純になる。
```swift

try {
  deletePage(page)
  registry.deleteReference(page.name)
  configKeys.deleteKey(page.name.makeKey())
} catch {
  logger.log(e.message)
}

```

### DRY(Don't Repeat Yourself)原則
重複は、あらゆるソフトウェアの諸悪の根源と言える。

### 関数を練って書く
コードは最初は複雑なもの。次にコードを練って洗練していく。
関数を分離、名前を変更、重複を排除していく。

### 結論
関数は動詞、クラスは名詞。
プログラマは、システムを話して聞かせるストーリーとして捉える。

## コメント
コメントは必要悪。コメントを行き届いた状態にすることは困難。
コードを明確に、洗練させたほうがよい。

### 自分自身をコードの中で説明する

```swift
// 従業員が、給料の完全給付を受けるかどうかチェックする
if employee.flag == HOURLY_FLAG && employee.age > 65
```

```swift
if employee.isEligibleForFullBenefits()
```

### よくないコメント
ほとんどのコメントはこのカテゴリ
出来の悪いコードの言い訳
不十分な決定の正当化
プログラマの表現能力の欠如

全ての関数・変数ににJavadocの記述を強制するルールは馬鹿げている
すでに明らかなことを、単に言い換えているだけのコメントはノイズでしかない。

ロジックの理由がある場合は、コメントを書く必要がある
コードを読みやすいコメントは書いて良いが、ノイズになるものは書くべきでない。
さらに、コメントよりはコードで説明する

コメントアウトは削除するべき

## 書式化

### 書式化の目的
ちゃんと動くことより、コーディングスタイル・読みやすさが重要
保守容易性と拡張性を保つ

### 縦方向の書式化
最大500行

### 新聞に例える
ソースは新聞のように、名前は単純にしかし説明的でなければならない
ソースの一番最初に高レベルの概念とアルゴリズム

### 垂直概念分離性
パッケージ宣言・インポート宣言・全ての関数が空行で分けることで、コードがとても読みやすくなる

### 垂直密度
ソースの各行が強く関連している時、互いを近くに置くことで読みやすくなる。
頭も視線も動かさなくても良いようにする

### 垂直距離
密接に関連した概念、変数や関数は、複数のファイルに分散するべきではありません。
インスタンス変数：議論があるが、最初におくべき
依存関数：関数が別の関数を呼び出しているのであれば、垂直方向に近い位置に置くべき
概念の密接な関係：直接的な依存がなくても、関数が似たような操作を行う場合は近くに置く　

### 垂直方向の並び順
処理の方向に従い、上から下に書く

### 横方向の書式化
最大120文字

### 水平分離性と密度
関連が弱いもの、演算子などはスペースを置いて強調する。

### 水平方向の位置合わせ
位置揃えは有用ではない

悪い例
```swift
class FitNesseExpediter: ResponseSender {
  private var socket: Socket
  private var input:  InputStream
  private var output: OutputStream
}
```

### インデント
スコープの階層を見やすくするために、インデントを使う
インデント規則違反：短い関数では、１行に収めてしまわないように気をつける

### Uncle Bobの書式化規則

```swift

class CodeAnalyzer: FileAnalysis {
  private var lineCount: Int
  private var maxLineWidth: Int
  private var widestLineNumber: Int
  private var lineWidthHistogram: LineWidthHistogram = LineWidthHistogram()
  private var totalChars: Int
  
  static func findFiles(parentDirectory: File) -> [File] {
    var files: [File] = []
    findFilesResursively(parentDirectory, files)
    return files
  }
  
  static func findFilesResursively(parentDirectory: File, files: inout [File]) {
    for var file in parentDirectory.listFiles() {
       if file.name.wndsWith(".swift") {
         files.add(file)
       } else if file.isDirectory {
         findFilesResursively(file, files)
       }
    }
  }
  
  func analyzeFile(file: File) throws {
    guard let path = Bundle.main.path(forResource file.name, ofType: nil) else {
      throw Error("File not found")
      return
    }
    
    let data = try String(contentsOfFile: path, encoding: .utf8)
    let strings = data.components(separatedBy: .newlines)
    
    strings.forEach { line in
      measureLine(line)
    }
    
  }
  
  private func measureLine(line: String) {
    
  }
  
}

```

inoutを使っているので、個人的には好きではない。
https://swift.tecc0.com/?p=286

## オブジェクトとデータ構造
### データ・オブジェクトの非対称性

手続き方（データ構造を使用するコード）は、新たな関数を既存データ構造に影響を与えずに追加することができる。
オブジェクト指向の場合、逆に既存の関数を変えることなく、新たなクラスを追加することができる

- 新たなクラスを追加することがない→手続き方
- 新たなクラスを追加することが多い→オブジェクト指向

→ここら辺を理解するために、サンプルを書いてみる

# エラー処理
## リターンコードではなく、例外を使用する
```swift
public class DeviceControoler {
  public func sendShutDown() {
    do {
      try shutDown()
    } catch error {
      print(error)
    }
  }
  
  private func shutDown() throws {
    let handle = try getHandle()
    closeDevice(handle)
  }
  
  private func getHandle() throws {
    ...
    throw DeviceSHutDownError
    ...
  }
  
}
```
## 最初にtry-catch-finally文を書く
TDD。例外を強制的に送出するテストを書き、その後でテストが成功するように処理コードに振る舞いを追加する。

## 非チェック例外を使用する
チェック例外を使用すると、変更の波及範囲が広大になってしまう。
開放・閉鎖原則に反する。

## 例外で状況を伝える

## 正常ケースのフローを定義する
例外がロジックを分断してしまうことを避ける

## nullを返さない
からのリスト・オブジェクトを返すことで、ロジックを簡潔にできる

## nullを渡さない

## 結論
クリーンコードは読みやすいだけでなく、堅牢でなければならない。
エラー処理とロジックを独立させる。

# 境界
他のコンポーネント・サブシステム・サードパーティーのコードとの境界
```swift
public class Sensors {
  private var sensors: [String: Sensor] = [:]
  public get(id: String) -> Sensor {
    return sensors[id]
  }
}
```

- 他のコードの使い方を知ることで、境界を定義する
- 既知のものとそうでないものを分離する境界
  - 境界のインターフェースがどのようなものであるべきかを明確にしていく

きれいな境界は、お金・労力のコストをあまりかけずに中身を変えることができる。

# 創発

重要度順
- 全テストを実行する
- 重複の排除
- プログラマの意図が表現されている
- クラスとメソッドを最小化する

# 同時並行性
オブジェクトは処理を抽象化する。スレッドはスケジュールを抽象化する。

## 同時並行性防御原則
- 単一責務の原則
- データのスコープを限定
- データのコピーを使用
- スレッドはできる限り独立させる

## スレッド化されたコードのテスト
- テストの失敗の仕方が怪しかったら、スレッドの問題だと疑ってかかる
- まずスレッド化されていないコードを先にテストしておく
- スレッド化されたコードは差し替え可能としておく
- スレッド化されたコードをチューニング可能にしておく
- プロセッサの個数以上スレッドを生成して実行する
- 異なるプラットフォームで実行する
- コードに対していろいろなことを試し、強制的にエラーを発生させる

## コードを綺麗にするように心がける

Swiftではどのようにするのか調べる

# においと経験則
## コメント
- C1: 不適切な情報
- C2: 退化コメント
- C3: 冗長なコメント
- C4: 記述不足のコメント
- C5: コメントアウトされたコード

## 環境
- E1: ビルドに複数のステップを要する
- E2: テストに複数のステップを要する

## 関数
- F1: 多すぎる引数
- F2: 出力引数
- F3: フラグ引数
- F4: 死んだ関数

## 一般
- G1: 1つのソースファイルに複数の言語を使用する
- G2: あって当然の振る舞いが実装されていない
- G3: 環境値に対する不正確な振る舞い
- G4: 安全軽視
- G5: 重複
- G6: 抽象レベルが正しくないコード
- G7: 継承クラスに依存したベースクラス
- G8: 情報過多
- G9: デッドコード
- G10: 垂直分離
- G11: 不整合
- G16: 不明瞭な意図
  - コードはできる限り表現豊かにする必要がある
















