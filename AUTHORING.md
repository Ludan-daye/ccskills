# Skill Authoring Conventions (ccskills)

本仓库所有 skill 遵循以下约定。**新增或编辑任何 skill 前先读本文件。**

## 1. description = 只说「何时用」
- 第三人称、以 `Use when …` 开头。
- **只写触发条件/症状，绝不总结 skill 的流程或工作步骤。**
  - 坏：`Use when executing plans - dispatches subagent per task with review`
  - 好：`Use when executing implementation plans with independent tasks`
- 原因：description 若总结流程，Claude 会照 description 行事、跳过 skill 正文。
- 长度：frontmatter 整段 ≤1024 字符；description 尽量 <500 字符。
- `name`：仅字母 / 数字 / 连字符。

## 2. token 预算
- 目标 <500 词 / `SKILL.md`。
- 重引用（>100 行的表 / 模板 / API）移到 `references/` 子文件，SKILL.md 内链接。

## 3. 跨 skill 引用
- 用 skill 名 + 显式标记：`**REQUIRED SUB-SKILL:** Use <name>` / `**REQUIRED BACKGROUND:** …`。
- **不用** `@path` 语法（会立即强加载、烧 context）。

## 4. paper skill 家族
- 所有论文写作 skill 一律在 `skills/paper/` 下，不在 `skills/` 顶层新增。
- 仓库扫描只在父 `paper`（Phase S）；子 skill 只消费 `PAPER_REPO_SURVEY.md`。

## 5. 反造假（贯穿 paper 全家）
- 每条数字 / 术语 claim 带 source path。
- 不编造指标 / 引用 / 图表 / 术语。占位约定详见 `skills/paper/references/storage-framework.md`。

## 6. 铁律：先测后写
- 新增 / 编辑任何 skill → 先跑 subagent 基线测试（RED），再写 / 改（GREEN），再堵漏（REFACTOR）。
- 连「只加一段」「只改 description」也要测。详见 `superpowers:writing-skills`。
