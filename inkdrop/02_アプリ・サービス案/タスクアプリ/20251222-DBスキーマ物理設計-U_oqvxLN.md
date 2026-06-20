# DBスキーマ物理設計

## `users` コレクション

- パス: `users/{userId}`
- フィールド例:
  - `displayName: string`
  - `email: string`
  - `photoUrl: string | null`
  - `timezone: string` (例: `"Asia/Tokyo"`)
  - `createdAt: Timestamp`
  - `updatedAt: Timestamp`
  - `plan: string` (`"free" | "pro"` など)
  - `useCloud: bool`
  - `aiEnabled: bool`
  - `externalServices: [string]`, (`email`や`calendar`など)
---

### 1. タスク: `users/{userId}/folios/{folioId}`

- 必須フィールド
  - `title: string`
  - `status: string`  
    - `"todo" | "doing" | "done" | "archived"`
  - `createdAt: Timestamp`
  - `updatedAt: Timestamp`
- 任意フィールド
  - `details: string`（詳細メモ）
  - `priority: string`  
    - `"low" | "medium" | "high"`
  - `estimateMin: number | null`（見積もり時間・分）
  - `dueAt: Timestamp | null`（期限）
  - `startAt: Timestamp | null`（開始予定）
  - `projectId: string | null`（`projects` への参照ID）
  - `labels: string[]`（ラベル名の配列 or labelId の配列）
  - `source: string`  
    - `"manual" | "ai_generated" | "email" | "calendar" | ...`
  - `aiGenerated: boolean`（AIが生成したタスクか）
  - `snoozedUntil: Timestamp | null`（スヌーズ先）
  - `doneAt: Timestamp | null`（完了日時）
  - `deletedAt: Timestamp | null`（論理削除する場合）
  - `sortOrder: number`

---

### 2. プロジェクト(Holder): `users/{userId}/holders/{holderId}`

- フィールド
  - `name: string`
  - `description: string | null`
  - `color: string | null`（`#RRGGBB` など）
  - `sortOrder: number`（任意）
  - `createdAt: Timestamp`
  - `updatedAt: Timestamp`
  - `archived: boolean`

---

### 3. 設定: `users/{userId}/settings/{settingsId}`

- 1ドキュメントに集約 or 複数カテゴリでもOK
- 例: `users/{userId}/settings/app` にまとめる

フィールド例:
- `language: string` (`"ja" | "en"` など)
- `timezone: string`
- `aiEnabled: boolean`
- `aiUseCalendar: boolean`
- `aiUseEmail: boolean`
- `notifyBeforeDueMinutes: number`（期限前通知）
- `createdAt: Timestamp`
- `updatedAt: Timestamp`