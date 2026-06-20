# Engineering Growth Map

# 📄 Engineering Growth Map（P4 → P5 / 詳細説明付き）


***

## 1. Knowledge of Computer Science

### Current (P4)

- Code appropriately balances processor and memory tradeoffs  
  → CPU負荷とメモリ使用量のバランスを考慮し、過剰最適化を避けつつ実用的な実装を行う。パフォーマンスと可読性の両立ができる。
- Code handles network latency and throughput limitations  
  → ネットワーク遅延や帯域制限を理解し、無駄なリクエストや過剰通信を避ける。非同期処理やキャッシュで体感速度を改善できる。
- Develops effective and efficient API interactions  
  → APIの呼び出し回数やデータ量を最適化し、効率的な通信設計ができる。必要なデータだけ取得する設計ができる。
- Code leverages common data structures  
  → 配列・Map・Setなど標準データ構造を適切に選択し、計算量を意識した実装ができる。無駄な再実装を避ける。

***

### Next (P5)

- Helps many teams consider computing and network tradeoffs  
  → 複数チームに対してパフォーマンス設計の指針を示し、CPU・メモリ・ネットワークのトレードオフを設計段階から導ける。
- Deep knowledge of data structures and educates others  
  → 汎用・ドメイン特化データ構造に精通し、最適な選択理由を説明できる。チームに教育・展開できる。
- Weighs CAP tradeoffs when picking databases  
  → CAP定理を理解し、整合性・可用性・分断耐性のバランスを踏まえたDB選定ができる。
- Familiar with many database engines  
  → RDB・NoSQLなど複数DBの特性を理解し、ユースケースに応じて適切な選択ができる。

***

## 2. Modern Software Development Practices

### Current (P4)

- Consistently commits in small iterations  
  → 小さな単位でコミット・PRを分割し、レビューしやすくすることで品質と開発速度を両立する。
- Suggests process improvements  
  → チームの開発効率を高めるための改善提案を行い、実行に移すことができる。
- Active in retrospectives and planning  
  → レトロやスプリント計画に積極参加し、チーム改善に貢献する。
- Speaks up in pointing sessions  
  → 見積もりの精度向上のために意見を出し、過小・過大評価を防ぐ。
- Collaborates with PM/Design  
  → プロダクト要件を理解し、PMやデザイナーと協働して実現可能な解決策を導く。

***

### Next (P5)

- Deeply familiar with every stage of SDLC  
  → 要件定義から運用までSDLC全体を理解し、ボトルネックを特定・改善できる。
- Suggests improvements impacting many teams  
  → 複数チームに効果のあるプロセス改善を提案・導入する。
- Leads planning/retro sessions  
  → 各種イベントをファシリテーションし、チームの意思決定を前進させる。
- Partners with PM/Design to improve output  
  → ビジネス価値を理解し、仕様そのものの質を向上させる。

***

## 3. Programming Skills

### Current (P4)

- Leads development of features/modules  
  → 機能単位で設計・実装をリードし、品質とスケジュールを担保できる。
- Practices safe concurrency  
  → 並行処理の競合やデッドロックを避け、安全にスレッドを扱える。
- Code is readable and extensible  
  → 他者が理解しやすく、将来の変更に耐えられる構造で実装できる。
- Bugs are rare  
  → 設計とテストによりバグを最小化できる。
- Can debug unaided  
  → 外部支援なしで問題原因を特定し修正できる。

***

### Next (P5)

- Leads development of systems  
  → アプリやシステム全体の設計・実装をリードできる。
- Leads API architecture decisions  
  → API設計の責任を持ち、拡張性・互換性を考慮した設計ができる。
- Highly skilled in thread-safe code  
  → 高度な並行処理を安全に設計・実装できる。
- Bug-free code is expected  
  → バグを前提としない設計・検証レベルを維持できる。
- Guides developers across organization  
  → 他チームの開発者に対して技術的指導ができる。

***

## 4. Secure Development

### Current (P4)

- Adheres to security principles  
  → 最小権限・攻撃面最小化など基本原則を守る。
- Applies authorization in code reviews  
  → 認可ロジックの不備をレビューで検出できる。
- Maintains dependencies  
  → 古いライブラリや脆弱性のある依存関係を適切に管理する。
- Writes tests  
  → テストによって不具合や脆弱性を早期検出する。

***

### Next (P5)

- Applies hardening techniques  
  → アプリの耐攻撃性を高める設計・実装ができる。
- Leads dependency strategy  
  → 組織全体の依存関係管理方針を決定する。
- Eliminates bug categories  
  → 設計レベルでバグや脆弱性を発生させない仕組みを作る。
- Teaches security practices  
  → セキュリティ観点を他エンジニアに教育できる。

***

## 5. Systems Thinking / Solution Design

### Current (P4)

- Considers 2nd/3rd order effects  
  → 実装の影響範囲を広く考え、副作用や将来の影響を予測する。
- Designs scalable modules  
  → 拡張可能で再利用可能な設計ができる。
- Debugs across boundaries  
  → フロント・バックエンドなど境界を跨いで問題解決できる。

***

### Next (P5)

- Builds highly available systems  
  → 障害に強くスケーラブルなシステムを設計できる。
- Reviews other teams’ architecture  
  → 他チームの設計を評価し改善提案できる。
- Seeks ambiguity and drives clarity  
  → 不明確な状況を構造化し、意思決定を導く。

***

## 6. Architecture and Design Patterns

### Current (P4)

- Applies SOLID principles  
  → 責務分離や依存関係の整理ができる。
- Uses common design patterns  
  → 再利用可能な設計パターンを適用する。
- Writes modular code  
  → 拡張しやすい構造で実装する。

***

### Next (P5)

- Promotes SOLID across teams  
  → 組織レベルで設計品質を引き上げる。
- Master of multiple architectures  
  → 様々な設計スタイルに対応できる。
- Builds productivity tools  
  → チームの開発効率を上げる仕組みを作る。

***

## 7. Collaboration and Interaction

### Current (P4)

- Leads technical discussions  
  → 技術的な意思決定を議論でリードする。
- Translates business needs  
  → ビジネス要件を技術仕様に落とし込む。
- Resolves conflicts  
  → 技術・人間関係の問題を解決する。

***

### Next (P5)

- Influences product/business decisions  
  → 技術観点から意思決定に影響を与える。
- Moderates disputes between teams  
  → チーム間の対立を調整する。
- Delegates effectively  
  → 適切に仕事を任せ、チームの成果を最大化する。

***

## 8. Mentorship

### Current (P4)

- Mentors junior engineers  
  → 初級者の成長を支援する。
- Leads learning sessions  
  → 知識共有を促進する。

***

### Next (P5)

- Mentors across teams  
  → 組織横断で人材育成を行う。
- Improves onboarding  
  → 新人教育の仕組みを改善する。

***

## 9. Specialization (Mobile)

### Current (P4)

- Builds complex UI  
  → 複雑な画面や状態管理を実装できる。
- Handles OS/device differences  
  → プラットフォーム差異に対応できる。

***

### Next (P5)

- Develops entire applications  
  → アプリ全体の設計・構築ができる。
- Promotes shared libraries  
  → 共通化により複数アプリの効率を上げる。
