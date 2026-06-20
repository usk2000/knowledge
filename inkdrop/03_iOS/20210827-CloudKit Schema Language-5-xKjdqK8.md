# CloudKit Schema Language

https://developer.apple.com/documentation/cloudkit/integrating_a_text-based_schema_into_your_workflow
CLIはない。[デベロッパー用のコンソール](https://icloud.developer.apple.com/)のDatabaseから、`Export Schema`, `Import Schema`する。
`.ckdb`ファイル形式。

→後でまとめる。使えそう。

## サンプル

```
DEFINE SCHEMA

    RECORD TYPE Category (
        "___createTime" TIMESTAMP,
        "___createdBy"  REFERENCE,
        "___etag"       STRING,
        "___modTime"    TIMESTAMP,
        "___modifiedBy" REFERENCE,
        "___recordID"   REFERENCE QUERYABLE,
        name            STRING QUERYABLE SEARCHABLE SORTABLE,
        GRANT WRITE TO "_creator",
        GRANT CREATE TO "_icloud",
        GRANT READ TO "_world"
    );

    RECORD TYPE Habit (
        "___createTime" TIMESTAMP QUERYABLE SORTABLE,
        "___createdBy"  REFERENCE,
        "___etag"       STRING,
        "___modTime"    TIMESTAMP QUERYABLE SORTABLE,
        "___modifiedBy" REFERENCE,
        "___recordID"   REFERENCE QUERYABLE,
        archived        INT64 QUERYABLE SORTABLE,
        category        STRING QUERYABLE,
        childCount      INT64,
        children        LIST<STRING> QUERYABLE,
        index           INT64 QUERYABLE SORTABLE,
        isParent        INT64 QUERYABLE,
        memo            STRING,
        parent          STRING QUERYABLE,
        shown           INT64 QUERYABLE SORTABLE,
        text            STRING QUERYABLE SEARCHABLE SORTABLE,
        GRANT WRITE TO "_creator",
        GRANT CREATE TO "_icloud",
        GRANT READ TO "_world"
    );

    RECORD TYPE Users (
        "___createTime" TIMESTAMP,
        "___createdBy"  REFERENCE,
        "___etag"       STRING,
        "___modTime"    TIMESTAMP,
        "___modifiedBy" REFERENCE,
        "___recordID"   REFERENCE,
        roles           LIST<INT64>,
        GRANT WRITE TO "_creator",
        GRANT READ TO "_world"
    );

```

## デフォルトのRole

- `_creator`: データ作成者
- `_world`: 全ユーザー
- `_icloud`: 全iCloudユーザー