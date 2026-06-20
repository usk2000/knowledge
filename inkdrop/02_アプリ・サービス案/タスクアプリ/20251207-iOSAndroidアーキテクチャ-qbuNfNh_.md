# iOS/Androidアーキテクチャ


# 3. iOS / Android クライアントアーキテクチャ

## 全体方針

- **共有ロジック**：Kotlin Multiplatform (KMP) で Domain / Data を共有（任意）
- **UI**：iOS = SwiftUI、Android = Jetpack Compose
- **構造**：`Presentation → Domain → Data` の3レイヤ

---

## 3.1 KMP 共有モジュール（任意だがあなた向き）

### shared モジュール構成例

```text
shared/
  src/commonMain/kotlin/
    domain/
      model/
        Task.kt
        Project.kt
        Plan.kt
      usecase/
        CreateTaskUseCase.kt
        UpdateTaskUseCase.kt
        DeleteTaskUseCase.kt
        GetTasksUseCase.kt
        ParseTaskUseCase.kt          // /nl/parse-task 呼び出し
        SemanticSearchUseCase.kt     // /semanticSearch 呼び出し
        PlanTodayUseCase.kt          // /plan/today 呼び出し
    data/
      repository/
        TaskRepository.kt
        AiRepository.kt
        PlanRepository.kt
      remote/
        ApiClient.kt       // Ktor などで Functions/BFF を叩く
      local/
        LocalStore.kt      // （必要なら）ローカルキャッシュ
    util/
      Result.kt
      DateTimeUtil.kt
      
```

- iOS / Android 双方から `usecase` を叩き、UI 側はプラットフォームネイティブに実装。


## 3.2 iOS アーキテクチャ（SwiftUI）

### レイヤ構成

- `Presentation`（SwiftUI + ViewModel）

- `Domain`（KMP shared or Swift ネイティブ）

- `Data`（Firestore SDK / HTTP クライアント）

### ディレクトリ例

```
iosApp/
  Sources/
    App/
      AppEntry.swift
      DIContainer.swift

    Presentation/
      TaskList/
        TaskListView.swift
        TaskListViewModel.swift
      TaskDetail/
        TaskDetailView.swift
        TaskDetailViewModel.swift
      PlanToday/
        PlanTodayView.swift
        PlanTodayViewModel.swift
      Components/
        TaskRowView.swift
        TagChipView.swift

    Data/
      Api/
        TaskApiClient.swift          // Cloud Functions HTTP 用
        AiApiClient.swift            // /nl/parse-task, /semanticSearch, /plan/today
      Firestore/
        FirestoreTaskStore.swift     // 直接 Firestore を叩く版なら
      Repository/
        TaskRepositoryImpl.swift     // UseCaseから使う実装

    Domain/  (shared を使わない場合に Swift で定義)
      Models/
        Task.swift
        Project.swift
      UseCases/
        CreateTaskUseCase.swift
        UpdateTaskUseCase.swift
        ...

    Resources/
      Localizable.strings
      Assets.xcassets
```

### 典型フロー（例：タスク作成）

1. `TaskEditView` でユーザーが自然文 or フォーム入力

2. 「AI補完」ボタン → `TaskEditViewModel` が `AiApiClient.parseTask()` を呼び出し

3. 返ってきたドラフトを View の `@State` に反映

4. 「保存」ボタン → `CreateTaskUseCase` 経由で `TaskRepository` を呼ぶ

5. `TaskRepository` が Firestore or BFF 経由で保存

6. Firestore 側トリガーでベクトル化（サーバー側）

***

## 3.3 Android アーキテクチャ（Jetpack Compose）

### レイヤ構成

- `Presentation`（Compose + ViewModel + StateFlow）

- `Domain`（KMP shared の usecase）

- `Data`（KMP shared repo + Android 固有の実装が必要なら expect/actual）

### モジュール構成例

```
androidApp/
  app/
    src/main/java/...
      MainActivity.kt
      navigation/
        NavGraph.kt
      ui/tasklist/
        TaskListScreen.kt
        TaskListViewModel.kt
      ui/taskdetail/
        TaskDetailScreen.kt
        TaskDetailViewModel.kt
      ui/plantoday/
        PlanTodayScreen.kt
        PlanTodayViewModel.kt
      di/
        AppModule.kt   // Hilt/Koin で DI
```

- `ViewModel` → shared の `UseCase` を注入して呼び出し

- 結果を `StateFlow` / `MutableStateFlow` で Compose に渡す

### フローの例（セマンティック検索）

1. `TaskListScreen` に検索テキストフィールド

2. 入力イベントで `TaskListViewModel.onSearch(query)`

3. `SemanticSearchUseCase` を呼ぶ

4. UseCase 内で shared の `TaskRepository.semanticSearch(query)` を使う

5. Repository が Ktor で `POST /semanticSearch` を叩く

6. 結果を `StateFlow<List<Task>>` に流す

7. Compose が recomposition して結果リストを表示

***

## 3.4 共通コンセプト

- **Domain層中心**：

  - UI からは UseCase（インターフェース）だけ見る

  - データ取得元（Firestore直 or BFF API）は裏側で差し替え可能

- **AI機能の分離**：

  - `AiRepository` / `AiUseCase` を分けておくと、オンデバイスモデル・別APIへの差し替えが楽

- **テスト**：

  - UseCase / Repository はプラットフォーム非依存にしてユニットテストしやすく

  - ViewModel は Fake UseCase を注入して UIロジックだけテスト



## メモ
- Firebase取得は、自前APIではなくKMP用Firebase SDKにする
