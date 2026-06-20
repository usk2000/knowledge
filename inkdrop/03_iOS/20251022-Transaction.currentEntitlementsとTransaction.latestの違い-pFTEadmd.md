# Transaction.currentEntitlementsとTransaction.latestの違い


### Transaction.currentEntitlements
- 現在、有効な購入（権利）のみ
- `AsyncSequence<VerificationResult<Transaction>>`
- 配列
- アプリ起動時の権利反映／全体確認

### Transaction.latest(for:)




| 比較項目       | `Transaction.currentEntitlements`                | `Transaction.latest(for:)` |
| ---------- | ------------------------------------------------ | -------------------------- |
| 返す内容       | 現在 **有効な購入（権利）** のみ                              | 指定した product の **最新の取引**   |
| 型          | `AsyncSequence<VerificationResult<Transaction>>` | `Transaction?`（オプショナル）     |
| 対象件数       | 複数（全アイテム）                                        | 単一（productIDごと）            |
| 主な用途       | アプリ起動時の権利反映／全体確認                                 | 個別アイテムの最新状態確認              |
| 有効期限切れアイテム | 含まれない                                            | 含まれる（期限切れでも返る）             |

https://chatgpt.com/g/g-p-687dbb9fc36881919167481fc60bd71c/c/68f5b7f4-d154-8323-93e7-e7f1d5eab605