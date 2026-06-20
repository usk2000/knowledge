# Cloud Functionサンプル

# 2. Cloud Functions (C3レベル) フォルダ構成サンプル

## ディレクトリ構成

```text
functions/
  package.json
  tsconfig.json
  firebase.json (ルート側でもOK)
  src/
    index.ts

    config/
      env.ts                // 環境変数/設定の読み込み

    lib/
      firestore.ts          // Firestore Admin の薄いラッパ
      auth.ts               // IDトークン検証ヘルパ
      embeddings.ts         // Embeddings API クライアント
      llm.ts                // Chat LLM クライアント
      qdrant.ts             // Qdrant クライアント
      calendar.ts           // Calendar API クライアント
      logger.ts             // ロギング共通

    api/
      tasks.ts              // /tasks 系 REST (CRUD)
      parseTask.ts          // /nl/parse-task
      semanticSearch.ts     // /semanticSearch
      planToday.ts          // /plan/today

    triggers/
      taskOnCreate.ts       // users/{userId}/tasks onCreate → ベクトル化してQdrantへ
      taskOnUpdate.ts       // onUpdate → 必要なら再ベクトル化
      taskOnDelete.ts       // onDelete → Qdrantから削除

    util/
      errors.ts             // 共通エラー型/ハンドリング
      validation.ts         // リクエストバリデーション
      time.ts               // タイムゾーン/日付ユーティリティ

  test/
    api/
      tasks.test.ts
      parseTask.test.ts
      semanticSearch.test.ts
    triggers/
      taskOnCreate.test.ts
      taskOnUpdate.test.ts
```

## src/index.ts
```typescript
import { onRequest } from "firebase-functions/v2/https";
import { apiTasks } from "./api/tasks";
import { apiParseTask } from "./api/parseTask";
import { apiSemanticSearch } from "./api/semanticSearch";
import { apiPlanToday } from "./api/planToday";

import { taskOnCreate } from "./triggers/taskOnCreate";
import { taskOnUpdate } from "./triggers/taskOnUpdate";
import { taskOnDelete } from "./triggers/taskOnDelete";

// HTTP API
export const tasks = onRequest(apiTasks);
export const parseTask = onRequest(apiParseTask);
export const semanticSearch = onRequest(apiSemanticSearch);
export const planToday = onRequest(apiPlanToday);

// Firestore Triggers
export const onTaskCreate = taskOnCreate;
export const onTaskUpdate = taskOnUpdate;
export const onTaskDelete = taskOnDelete;

```

## 役割の整理（コンポーネント）

- `lib/firestore.ts`

  - `getUserTasks(userId)`、`updateTask(...)` などラッパ関数

- `lib/embeddings.ts`

  - `getEmbedding(text: string): Promise<number[]>`

- `lib/qdrant.ts`

  - `upsertTaskVector(...)` / `deleteTaskVector(...)` / `searchTaskVectors(...)`

- `api/parseTask.ts`

  - LLMを呼んで自然文 → 構造化タスクドラフト

- `api/semanticSearch.ts`

  - クエリ → Embedding → Qdrant search → Firestore詳細取得

- `triggers/taskOnCreate.ts`

  - 新タスク → Embedding → Qdrant upsert

- `triggers/taskOnUpdate.ts`

  - タイトル/ノート変更時のみ再Embedding → Qdrant upsert

- `triggers/taskOnDelete.ts`

  - Qdrant から該当ベクトル削除
