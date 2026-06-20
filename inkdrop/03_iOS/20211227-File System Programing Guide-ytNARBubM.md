# File System Programing Guide

アウトプットする。

[データストレージ](inkdrop://note/3JhPtL0ob)

クラウドにバックアップを考える。

### 基本
[File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW2)
[Performance Tips](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/PerformanceTips/PerformanceTips.html#//apple_ref/doc/uid/TP40010672-CH7-SW3)
[About Advanced File System Topics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemAdvancedPT/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010765-CH1-SW1)
[Advanced Memory Management Programming Guid](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/MemoryMgmt.html)

### File Systemで暗号化する場合
[Encrypting Your App’s Files](https://developer.apple.com/documentation/uikit/protecting_the_user_s_privacy/encrypting_your_app_s_files)
[Encrypting and Decrypting a Single File](https://developer.apple.com/documentation/applearchive/encrypting_and_decrypting_a_single_file)


### 潜在的な問題領域と修正

#### ディスクから(任意のタイプの)多くのファイルを読み取っているコード
リソースファイルをロードしている場所も探すことを忘れないでください。実際にそれらのファイルのすべてのデータをすぐに使用していますか?そうでない場合は、いくつかのファイルをより遅延的にロードすることをお勧めします。

##### 古いファイルシステムコールを使用するコード
ほとんどの呼び出しは、Swift APIまたはObjective-C APIを使用する必要があります。BSDレベルの呼び出しも使用できますが、FSRefまたはFSSpecデータ構造で動作する古いCarbonベースの関数は使用しないでください。Xcodeは、廃止されたメソッドと関数を使用してコードを検出すると警告を生成するので、これらの警告を確認してください。最新のファイルシステムインターフェイスを使用するを参照してください。
#### コールバック関数またはメソッドを使用してファイルデータを処理するコード
ブロックオブジェクトを取る新しいAPIが利用可能な場合は、代わりにそのAPIを使用するようにコードを更新してください。

#### 同じファイルで実行される多くの小さな読み取りまたは書き込み操作を持つコード
これらの操作をグループ化して、一度にすべて実行できますか?同じ量のデータに対して、1つの大きな読み取りまたは書き込み操作は通常、多くの小さな操作よりも効率的です。

#### 一般的な推奨事項

これらの推奨事項は、ファイルシステム関連のパフォーマンスを向上させるのに役立ちます。すべてのヒントと同様に、最適化を検証できるように、前後のパフォーマンスを測定します。

- ファイル操作の数を最小限に抑えます
  - ローカルファイルシステムからメモリにデータを移動するには、かなりの時間がかかります。また、ターゲットファイルシステムが世界の途中でサーバー上にある場合、ネットワーク遅延によりデータの取得の遅延が増加します。
- Reuse path objects. 
  - When you access file resources for a NSURL object using the resourceValuesForKeys(_:) method, those values are cached. By reusing the NSURL object, you may avoid file system access on subsequent access to those file resources. Also, because NSURL objects can be expensive to construct, prefer reuse over creating new instances each time you reference a file.
- 小さなチャンクで大量のデータを処理しないでください
  - バッファサイズは、ディスクからローカルバッファへのデータの読み取り速度に劇的な影響を及ぼします。比較的大きなファイルを操作している場合は、大きなバッファ(128KBから256KBなど)を作成し、処理する前にデータの大部分またはすべてをメモリに読み取ります。ディスクにデータを書き込むのと同じルールが適用されます。単一のファイルシステムコールを使用して、できるだけ順次データを書き込みます。
- ファイル内でジャンプするのではなく、データを順番に読み取ります
  - カーネルはI/O操作を透過的にクラスター化し、シーケンシャル読み取りをはるかに高速にします。
- データを書き込む前に、空のファイルで先にスキップしないでください
  - システムは、ギャップを埋めるために介入スペースにゼロを書き込む必要があるかもしれません。書き込み時にファイルに「穴」を含めると、パフォーマンスのペナルティが発生する可能性があるため、正当な理由なしには行わないでください。詳細については、「ゼロフィル遅延がコストでセキュリティを提供する」を参照してください。
- アプリがデータを必要とするまで、I/O操作を延期します
  - 怠惰であるという黄金律は、ディスクパフォーマンスだけでなく、他の多くのタイプのパフォーマンスにも適用されます。
- 環境設定システムを使用して、安価に再計算できるデータをキャプチャしないでください
  - 環境設定システムを使用して、ユーザー設定(ウィンドウの位置、表示設定、ユーザー提供の環境設定など)のみをキャプチャします。単純な値の再計算は、ディスクから同じ値を読み取るよりも大幅に高速です。
- メモリ内のファイルをキャッシュすると、アプリが高速化されると仮定しないでください
  - メモリ内のファイルをキャッシュすると、メモリ使用量が増加し、他の方法でパフォーマンスが低下する可能性があります。さらに、システムは自動的にファイルデータをキャッシュする可能性があるため、独自のキャッシュを作成するとさらに悪化する可能性があります。 システムには独自のファイルキャッシュメカニズムがあるを参照してください。

