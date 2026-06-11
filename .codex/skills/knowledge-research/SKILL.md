---
name: knowledge-research
description: Use when creating, updating, or organizing Markdown research notes in this knowledge repository, especially for AI, Apple platform, Android, SDK, API, framework, or developer documentation investigations.
---

# Knowledge Research

## Overview

Use this skill to turn technical research into clear Markdown notes under this repository's source directories. Treat `AGENTS.md` as the repository-level source of truth for folder policy and writing rules.

## Workflow

1. Identify the topic and destination:
   - AI, LLMs, OpenAI, Apple Foundation Models: `ai/`
   - iOS, macOS, visionOS, Swift, SwiftUI, Apple Developer: `apple/`
   - Android, Kotlin, Jetpack, Google Play, Android Studio: `android/`
   - Local preview or generation helpers: `scripts/`
2. Check whether a related note already exists with `rg --files` and targeted `rg` searches.
3. For current technical facts, verify with primary sources when possible. Official docs, release notes, standards, source code, and vendor announcements are preferred.
4. Write the note as a readable synthesis, not just a collection of links.
5. Preserve uncertainty. Mark stale, conflicting, inferred, or untested information explicitly.
6. Do not manually edit `public/`; it is generated output.

## Note Shape

Prefer this structure unless an existing nearby note uses a clearer pattern:

```md
# Title

- 調査日: YYYY-MM-DD
- 対象: Product, OS, SDK, library, API, or version
- 状態: 調査中 / 検証済み / 要更新

## 要約

## 背景

## 分かったこと

## 実装・利用メモ

## 注意点

## 未確認事項

## 参考
```

## Writing Rules

- Use Japanese as the main language, with English terms where they help searchability.
- Keep filenames lowercase with hyphens, for example `ai/openai-responses-api-notes.md`.
- Include dates for unstable facts such as API behavior, pricing, OS support, model availability, and SDK requirements.
- Separate observed behavior, official claims, and inference.
- When updating an existing note, keep useful historical context instead of silently erasing it.

## Before Finishing

- Run `git status --short`.
- Mention any facts that could not be verified.
- If source links were used, include them in the note or final response as appropriate.
