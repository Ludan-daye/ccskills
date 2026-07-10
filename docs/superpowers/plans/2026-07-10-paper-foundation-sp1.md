# Paper Foundation (SP1) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the shared foundation for the paper-skill family — a generic `paper-section` drafting engine plus the reference assets, storage contract, terminology mechanism, conventions doc, and refactors it depends on.

**Architecture:** Everything lives under `skills/paper/`. The parent `paper` skill owns the repo scan and seeds shared artifacts (`PAPER_REPO_SURVEY.md`, `TERMS.md`, `STATE.md`) in the user's research repo. Section skills (`paper-section`, `paper-abstract`) consume those and write LaTeX. Skill-side reference docs (`references/*.md`) carry reusable guidance loaded on demand. Skill authoring follows writing-skills RED→GREEN→REFACTOR.

**Tech Stack:** Markdown SKILL.md files (Claude Code Agent Skills), YAML frontmatter, LaTeX conventions, subagent pressure-testing, git.

**Phasing:** **SP1a** = docs / conventions / refactor / existing-description CSO (low risk, Tasks 1–8). **SP1b** = `paper-section` engine + wiring + full RED-GREEN-REFACTOR test + docs sync (Tasks 9–16).

**Reference:** spec at `docs/superpowers/specs/2026-07-10-paper-foundation-design.md`.

**Convention for this plan:** "the repo" = ccskills working tree. Skill files are English-ish with Chinese notes (existing house style). Discussion/commit bodies may be Chinese. Every commit stays local (no push unless the user asks).

---

## PHASE SP1a — Foundation docs, refactor, CSO descriptions

### Task 1: `AUTHORING.md` (repo-root skill authoring conventions)

**Files:**
- Create: `AUTHORING.md`

- [ ] **Step 1: Write the file**

Create `AUTHORING.md` with exactly this content:

```markdown
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
```

- [ ] **Step 2: Verify length + required anchors**

Run: `wc -w AUTHORING.md && grep -c "^## " AUTHORING.md`
Expected: word count < 350; heading count = 6.

- [ ] **Step 3: Commit**

```bash
git add AUTHORING.md
git commit -m "Add AUTHORING.md: repo skill-authoring conventions"
```

---

### Task 2: `section-themes.md` (per-section quick index)

Extracts and reformats the catalog currently inline in `skills/paper/structure/SKILL.md` Step 3 (lines ~394–447) into a shared index. Adds typical length + move order.

**Files:**
- Create: `skills/paper/references/section-themes.md`

- [ ] **Step 1: Write the file**

Create `skills/paper/references/section-themes.md` with this content:

```markdown
# Section themes (quick index)

各节速查索引，供 `paper-section`（正文）、`paper-structure`（骨架注释）共用。
深潜细节见 `sections/<name>.md`（缺失时以本索引为准）。
**Abstract 不在此展开** —— 见 `../abstract/references/`。

| 节 | Theme | 典型长度 | Move 顺序 |
|----|-------|----------|-----------|
| Introduction | 叙事 + 可检验贡献 | 0.75–1.25 页 | 动机→gap→高层 idea→贡献列表→(路线图) |
| Related Work | 定位与区分 | 0.5–1 页 | 主题簇→相同/不同轴→最近基线 |
| Method | 技术贡献：是什么 + 为什么 | 1.5–3 页 | setup/形式化→总览→模块→设计理由 |
| Experiments | 为主张提供证据 | 1.5–3 页 | 协议/数据/基线→主结果→消融/分析 |
| Limitations | 失效模式与范围 | 0.2–0.5 页 | 诚实假设→数据/算力限→负面发现 |
| Conclusion | 闭环 | 0.2–0.4 页 | 问题/方法回顾→发现→贡献回声→克制展望 |

## Introduction
- **Must include:** motivation → gap → high-level idea → contributions（可枚举、可检验）→ optional roadmap
- **Must not:** 完整方法细节；related-work 式综述
- **Done when:** reviewer 能复述约 3 条贡献；gap 与 method 对得上

## Related Work
- **Must include:** 主题簇；显式 same/different 轴；最近基线
- **Must not:** 无批判的罗列；漏掉直接竞争者
- **Done when:** 读者知道我们和谁比、为何不同

## Method
- **Must include:** setup/formalism → overview → modules → design rationale
- **Must not:** 完整超参表（放 Experiments）
- **Done when:** 同行能重实现核心 idea

## Experiments
- **Must include:** protocol、data、baselines、main results、ablations/analysis
- **Must not:** 无表/图支撑的主张；隐藏协议
- **Done when:** 每条主张都映射到某图/表

## Limitations
- **Must include:** 诚实假设、数据/算力限、负面发现
- **Must not:** 假谦虚；纯 future-work 营销
- **Done when:** 明显的 reviewer 攻击已被预先框定且不自毁主张

## Conclusion
- **Must include:** 问题/方法回顾、发现、贡献回声、克制展望
- **Must not:** 新实验主张
- **Done when:** 与 Abstract/Intro 一致
```

- [ ] **Step 2: Verify**

Run: `grep -c "^## " skills/paper/references/section-themes.md`
Expected: 6 (Introduction, Related Work, Method, Experiments, Limitations, Conclusion).

- [ ] **Step 3: Commit**

```bash
git add skills/paper/references/section-themes.md
git commit -m "Add section-themes.md: shared per-section quick index"
```

---

### Task 3: `storage-framework.md` (artifact storage contract)

**Files:**
- Create: `skills/paper/references/storage-framework.md`

- [ ] **Step 1: Write the file**

Create `skills/paper/references/storage-framework.md` with this content:

```markdown
# Paper artifact storage framework (存储框架)

paper 全家的磁盘契约。两个存储空间：用户仓库侧（论文项目产物）与 skill 包侧（参考文档）。

## 1. 用户仓库侧 `<ROOT>/paper/`

| 产物 | owner | consumer | 命名 / 生命周期 |
|------|-------|----------|------------------|
| `PAPER_REPO_SURVEY.md` | paper（父） | 全部 | Phase S 生成；stale 重扫；legacy 名 `ABSTRACT_REPO_SURVEY.md` 读后迁移 |
| `TERMS.md` | paper 父 seed | section, abstract | Phase S 后从 survey 术语段生成；`needs-user` 项补齐后转 `user-confirmed` |
| `STATE.md` | 各 skill 收尾刷 | paper 路由 | 项目级进度汇总（见 §4） |
| `GUIDANCE.md` | paper-structure / paper | 全部 | intake 后建，逐问更新 |
| `vendor/` | paper-structure | — | 官方模板包，尽量不改 |
| `main.tex` 前导 / frontmatter | paper-structure | — | 骨架期建 |
| `sections/*.tex` 正文体 | paper-section | — | 起草期写；`% Status` 为每节真源 |
| abstract 正文 | paper-abstract | — | CONTENT_LOCK 后写 |
| `refs.bib` | 无人伪造 | SP3 引文 skill | section 只写 `\cite{TODO:...}` 占位 |

## 2. skill 包侧 `skills/paper/references/`

`storage-framework.md`（本文件）、`section-themes.md`（速查索引）、`sections/*.md`（深潜文档）、
`subagent-survey-prompt.md`、`survey-template.md`。

## 3. 写入归属 / 防互踩
- 一个 skill 只改自己 owned 的文件 / 区块。
- 共享文件用 append 或 section-scoped edit；**绝不 blind-overwrite**。
- 两个 skill 不改同一块（如 main.tex 前导只归 paper-structure）。

## 4. 状态生命周期
- 每节 `.tex` 顶部：`% Status: [ ] not drafted` → `[~] drafting` → `[x] drafted` → 可选 `[!] needs-rework`。
- `% Status` 是每节 **in-file 真源**；`STATE.md` 是**项目级汇总**（哪些节已写、abstract 状态、是否到 polish），由各 skill 收尾单向刷新。
- `STATE.md` 建议格式：

```
# STATE
- survey: done (paper/PAPER_REPO_SURVEY.md)
- terms: seeded (2 needs-user)
- structure: done (venue=IEEE-default)
- sections: intro[x] related[ ] method[x] experiments[~] limitations[ ] conclusion[ ]
- abstract: not-started
- polish: n/a
```

## 5. 反造假占位约定

| 类型 | 约定 | 禁止 |
|------|------|------|
| 引用 | `\cite{TODO:AuthorYear-topic}` + 行内 `% CITE-NEEDED: <该 claim 需要来源>` | 编造看似真实的 cite key |
| 图 | `\ref{fig:TODO-<slug>}` + `% FIG-NEEDED: <描述>` | 伪造图文件 / 数据 |
| 表 | `\ref{tab:TODO-<slug>}` + `% TAB-NEEDED: <描述>` | 伪造表数值 |
| 交叉引用 | 每节 `\label{sec:<slug>}`；引用用 `\ref`/`\Cref{sec:<slug>}` | 各节自造 slug 命名 |
| 数字 | 行内 `% src: <claim_id> (path)`；无 claim_id 支撑→不写，标 `% NUM-NEEDED` | 编造 / 凑整任何指标 |

## 6. TERMS.md 契约
- 每条：`规范写法 | 展开 | source_path | 状态(from-repo(path) / user-confirmed / needs-user)`。
- section / abstract 规范写法逐字照用；需表外术语→停下问用户，不编。
```

- [ ] **Step 2: Verify**

Run: `grep -n "NUM-NEEDED\|CITE-NEEDED\|from-repo\|blind-overwrite" skills/paper/references/storage-framework.md | wc -l`
Expected: ≥ 4 (all key conventions present).

- [ ] **Step 3: Commit**

```bash
git add skills/paper/references/storage-framework.md
git commit -m "Add storage-framework.md: paper artifact storage contract"
```

---

### Task 4: `sections/_TEMPLATE.md` (per-section deep-dive template)

**Files:**
- Create: `skills/paper/references/sections/_TEMPLATE.md`

- [ ] **Step 1: Write the file**

Create `skills/paper/references/sections/_TEMPLATE.md`:

```markdown
# <Section name> — deep dive

> 每节深潜文档的模板。复制本文件为 `<section>.md` 填写。SP2 填满 intro/related-work/experiments/limitations/conclusion；SP1 已出 method.md 样板。
> 与 `../section-themes.md` 的关系：索引给一屏速查，本文件给 `paper-section` 起草该节时按需加载的细节。

## Theme
一句话本节使命。

## Role in the paper
本节在 claim→evidence 闭环里承担什么；上游依赖哪节、下游被谁引用。

## Move order
有序步骤（3–6 步），每步 1 行。

## Must include
- 逐条列，可勾。

## Must not
- 逐条列常见越界。

## Common mistakes → fix
| 坏味道 | 修法 |
|--------|------|
|  |  |

## Claim → evidence mapping
本节允许出现的数字类型、必须追到的 survey claim 段（如 Experiments 追 R*/A*）。无 claim_id→`% NUM-NEEDED`。

## Length guidance
典型页数 / 段数；超 GUIDANCE 页限时如何裁。

## Micro-example (structure only)
只给骨架/占位，**不给可抄的成稿句子**。

## Done-when checklist
- [ ] 与 `section-themes.md` 的 Done-when 对齐
- [ ] 全部数字带 `% src:`
- [ ] 术语照 `TERMS.md`
- [ ] 引用 / 图表用占位约定
```

- [ ] **Step 2: Verify**

Run: `grep -c "^## " skills/paper/references/sections/_TEMPLATE.md`
Expected: 10.

- [ ] **Step 3: Commit**

```bash
git add skills/paper/references/sections/_TEMPLATE.md
git commit -m "Add sections/_TEMPLATE.md: per-section deep-dive template"
```

---

### Task 5: `sections/method.md` (sample deep dive validating the template)

**Files:**
- Create: `skills/paper/references/sections/method.md`

- [ ] **Step 1: Write the file** (fill `_TEMPLATE.md` for Method)

```markdown
# Method — deep dive

## Theme
技术贡献：讲清「是什么」和「为什么这样设计」，让同行能重实现核心 idea。

## Role in the paper
承接 Intro 的高层 idea，给出可实现的机制；为 Experiments 的每条主张提供被测对象。上游依赖 problem setup；下游被 Experiments、Conclusion 引用。

## Move order
1. Setup / formalism（记号、问题定义）
2. Approach overview（一段话 + 可选总览图占位）
3. 逐模块展开（每模块：做什么 → 怎么做 → 为何）
4. Design rationale（关键选择的理由，对比可能的替代）

## Must include
- 形式化的问题定义与记号
- 方法总览（先整体后局部）
- 各核心模块的机制
- 设计理由（为什么不是更简单的做法）

## Must not
- 完整超参表 / 训练细节（放 Experiments）
- 结果数字（放 Experiments）
- 伪造的公式或未定义符号

## Common mistakes → fix
| 坏味道 | 修法 |
|--------|------|
| 先堆细节后给总览 | 先一段 overview 再下钻 |
| 模块罗列无理由 | 每模块补 1 句 design rationale |
| 记号与 survey/TERMS 不一致 | 方法名 / 符号照 `TERMS.md` |

## Claim → evidence mapping
Method 一般**不出数字**；若引复杂度 / 参数量等，追 survey 效率类 claim（如 R*/效率段），行内标 `% src:`；无来源→`% NUM-NEEDED`。

## Length guidance
典型 1.5–3 页。超页限先砍 rationale 的次要分支与冗余记号，保留 overview + 核心模块。

## Micro-example (structure only)
```
\section{Method}\label{sec:method}
% Move 1: setup/formalism
% Move 2: overview (\ref{fig:TODO-overview})  % FIG-NEEDED: system overview
% Move 3: module A ... module B ...
% Move 4: design rationale
```

## Done-when checklist
- [ ] 同行能据此重实现核心 idea
- [ ] overview 在细节之前
- [ ] 方法名 / 记号照 `TERMS.md`
- [ ] 无结果数字越界；任何数字带 `% src:`
- [ ] 图 / 交叉引用用占位约定
```

- [ ] **Step 2: Verify template parity**

Run: `diff <(grep "^## " skills/paper/references/sections/_TEMPLATE.md) <(grep "^## " skills/paper/references/sections/method.md)`
Expected: no differences (method.md fills every template heading).

- [ ] **Step 3: Commit**

```bash
git add skills/paper/references/sections/method.md
git commit -m "Add sections/method.md: sample deep dive for Method"
```

---

### Task 6: Terminology extraction into survey scan

**Files:**
- Modify: `skills/paper/references/subagent-survey-prompt.md`
- Modify: `skills/paper/references/survey-template.md`

- [ ] **Step 1: Add extraction task to the subagent prompt**

In `skills/paper/references/subagent-survey-prompt.md`, inside the fenced prompt block, after the line `5. PATHS: every claim needs a file path.` add:

```text
6. TERMINOLOGY: canonical method/system/dataset/metric names and key abbreviations, each with source_path. If a name is absent or ambiguous in the repo, mark it needs-user (do NOT invent).
```

And in that file's "Fill the template" area, ensure it points at the new `## Terminology` section of the survey template (add a sentence: `Also fill the Terminology section (canonical names + abbreviations + paths).`).

- [ ] **Step 2: Add Terminology section to the survey template**

In `skills/paper/references/survey-template.md`, inside the fenced template, after the `## 1. Research direction` block (before `## 2. Story / narrative`), insert:

```markdown
## 1t. Terminology (canonical + paths)
| term_id | canonical | expansion | source_path | status |
|---------|-----------|-----------|-------------|--------|
| T1 | | | | from-repo / needs-user |
```

- [ ] **Step 3: Verify**

Run: `grep -n "TERMINOLOGY\|1t. Terminology\|needs-user" skills/paper/references/subagent-survey-prompt.md skills/paper/references/survey-template.md`
Expected: matches in both files.

- [ ] **Step 4: Commit**

```bash
git add skills/paper/references/subagent-survey-prompt.md skills/paper/references/survey-template.md
git commit -m "Scan terminology in Phase S survey (feeds TERMS.md)"
```

---

### Task 7: Refactor `paper-structure/SKILL.md` (slim + split references)

Source line ranges (from current file): GUIDANCE template ≈ 133–244; Step 1 sources ≈ 246–346; Step 3 catalog ≈ 394–447.

**Files:**
- Create: `skills/paper/structure/references/guidance-template.md`
- Create: `skills/paper/structure/references/template-sources.md`
- Modify: `skills/paper/structure/SKILL.md`

- [ ] **Step 1: Extract GUIDANCE template**

Create `skills/paper/structure/references/guidance-template.md`. Move the entire `### paper/GUIDANCE.md template` block (current SKILL.md lines ~133–244, i.e. the ` ```markdown # Paper setup guidance … ` template through the "After each Q&A…" paragraph) into this new file verbatim, prefixed with:

```markdown
# GUIDANCE.md template (used by paper-structure)

> paper-structure 在 intake 时创建 `<ROOT>/paper/GUIDANCE.md` 并逐问更新。禁止写 token/密码/私钥。
```

- [ ] **Step 2: Extract template sources**

Create `skills/paper/structure/references/template-sources.md`. Move the Step 1 content (current lines ~246–346: §1.0 IEEE default path, §1.1 official source priority, §1.2 download layout, §1.3 failure handling, and the class-options tables) verbatim, prefixed with:

```markdown
# Official template sources & download (used by paper-structure)
```

- [ ] **Step 3: Edit SKILL.md — replace moved blocks with links**

In `skills/paper/structure/SKILL.md`:
- Replace the whole `### paper/GUIDANCE.md template` block with:
  `完整 GUIDANCE.md 模板见 **`references/guidance-template.md`**。intake 时据此创建并逐问更新。`
- Replace the whole `## Step 1 — Locate and download the official format` body with a 3-line summary + link:
  ```markdown
  ## Step 1 — Locate and download the official format
  默认 IEEE IEEEtran；指定 venue 用其官方包。完整下载源、优先级、目录布局、失败处理见 **`references/template-sources.md`**。下载后写 `paper/TEMPLATE_SOURCE.md` 并回填 GUIDANCE §1b/§6。
  ```
- Replace the whole `## Step 3 — Section theme catalog …` block with:
  ```markdown
  ## Step 3 — Section themes
  各节 Theme / Must include / Must not / Done-when 见 **`../references/section-themes.md`**（与 `paper-section` 共用）。填骨架注释时引用它。
  ```

- [ ] **Step 4: Verify size dropped and links resolve**

Run: `wc -l skills/paper/structure/SKILL.md && ls skills/paper/structure/references/ && grep -c "references/guidance-template.md\|references/template-sources.md\|references/section-themes.md" skills/paper/structure/SKILL.md`
Expected: SKILL.md line count roughly halved (< ~320 lines); two new reference files listed; ≥ 3 link references present.

- [ ] **Step 5: Commit**

```bash
git add skills/paper/structure/SKILL.md skills/paper/structure/references/
git commit -m "Refactor paper-structure: split GUIDANCE/sources to references, link section-themes"
```

---

### Task 8: Rewrite 3 existing descriptions to CSO (RED → GREEN)

**Files:**
- Modify: `skills/paper/SKILL.md` (frontmatter `description`)
- Modify: `skills/paper/structure/SKILL.md` (frontmatter `description`)
- Modify: `skills/paper/abstract/SKILL.md` (frontmatter `description`)

- [ ] **Step 1: RED — capture current behavior**

Dispatch a subagent with the CURRENT three descriptions only (no bodies), prompt:
`Given only these skill descriptions, a user says "帮我根据仓库写 method 正文". Which skill(s) would you load, and would you act directly from the description or open the skill body first? Answer concretely.`
Record the answer. Expected failure signal: it treats the workflow embedded in the description as instructions / picks wrong skill / says it can act without reading the body. Save verbatim into the commit body of Step 4.

- [ ] **Step 2: Rewrite the three descriptions**

Set `skills/paper/SKILL.md` frontmatter `description` to:

```yaml
description: >
  Use when the user works on a CS research paper (写论文, 顶会/顶刊 投稿), needs their
  research repo turned into paper material, or any paper section task needs shared
  research context. Parent of paper-structure, paper-section, paper-abstract.
```

Set `skills/paper/structure/SKILL.md` `description` to:

```yaml
description: >
  Use when scaffolding a CS paper's LaTeX project — 论文结构, 搭骨架, 下载模板,
  LaTeX/Overleaf, 先定架构, IEEE/venue 模板, 确认章节架构. Not for section prose
  (paper-section) or the abstract (paper-abstract).
```

Set `skills/paper/abstract/SKILL.md` `description` to:

```yaml
description: >
  Use when writing or revising a paper's Abstract — 写摘要, abstract, 改摘要.
  Requires the parent paper survey first.
```

- [ ] **Step 3: GREEN — re-run the scenario**

Dispatch a fresh subagent with the THREE new descriptions, same prompt as Step 1.
Expected pass: it does NOT pick a body-writing skill from these three (correctly notes none of the three matches "写 method 正文" — that is `paper-section`, added later), and says it must open the skill body before acting. Record the answer.

- [ ] **Step 4: Verify frontmatter still valid + commit**

Run: `for f in skills/paper/SKILL.md skills/paper/structure/SKILL.md skills/paper/abstract/SKILL.md; do echo "== $f =="; sed -n '1,12p' "$f"; done | grep -c "Use when"`
Expected: 3.

```bash
git add skills/paper/SKILL.md skills/paper/structure/SKILL.md skills/paper/abstract/SKILL.md
git commit -m "Rewrite paper descriptions to CSO (when-to-use only)

RED/GREEN subagent transcripts:
<paste Step 1 and Step 3 answers here>"
```

- [ ] **Step 5: SP1a checkpoint**

Run: `git log --oneline -8 && wc -l skills/paper/structure/SKILL.md`
Confirm 8 SP1a commits present and structure SKILL.md slimmed. Pause for review before SP1b.

---

## PHASE SP1b — `paper-section` engine + wiring + full test

### Task 9: Test fixture (fake research repo)

**Files:**
- Create: `skills/paper/section/references/fixture/README.md`
- Create: `skills/paper/section/references/fixture/results/REPORT.md`
- Create: `skills/paper/section/references/fixture/paper/PAPER_REPO_SURVEY.md`
- Create: `skills/paper/section/references/fixture/paper/GUIDANCE.md`
- Create: `skills/paper/section/references/fixture/paper/TERMS.md`
- Create: `skills/paper/section/references/fixture/paper/main.tex`
- Create: `skills/paper/section/references/fixture/paper/sections/method.tex`
- Create: `skills/paper/section/references/fixture/paper/sections/experiments.tex`

- [ ] **Step 1: Write fixture files**

`README.md`:
```markdown
# FastKV (fixture repo — NOT a real project)
Direction: KV-cache compression for LLM inference. Method: SlabQuant, a slab-wise
4-bit quantizer for attention KV. See results/REPORT.md.
```

`results/REPORT.md`:
```markdown
# Results
| id | claim | value | note |
|----|-------|-------|------|
| R1 | perplexity vs fp16 baseline | +0.12 PPL @ WikiText-103 | 3-seed mean |
| R2 | KV memory reduction | 3.8x | vs fp16 |
| R3 | throughput | 1.9x tokens/s | A100, batch 32 |
```

`paper/PAPER_REPO_SURVEY.md` (pre-filled, abbreviated — must include claim_ids and a Terminology section):
```markdown
# PAPER_REPO_SURVEY
- root: <fixture>
- scanned_at: 2026-07-10
## 1. Research direction
- method_name: SlabQuant
Sources: README.md
## 1t. Terminology
| term_id | canonical | expansion | source_path | status |
|---------|-----------|-----------|-------------|--------|
| T1 | SlabQuant | slab-wise 4-bit KV quantizer | README.md | from-repo(README.md) |
| T2 | WikiText-103 | eval corpus | results/REPORT.md | from-repo(results/REPORT.md) |
| T3 | (baseline name) | fp16 KV cache | results/REPORT.md | needs-user |
## 4. Main results
| claim_id | claim | number/value | source_path |
|----------|-------|--------------|-------------|
| R1 | PPL vs fp16 | +0.12 PPL | results/REPORT.md |
| R2 | KV mem | 3.8x | results/REPORT.md |
| R3 | throughput | 1.9x | results/REPORT.md |
```

`paper/GUIDANCE.md`:
```markdown
# Paper setup guidance
## 1. Venue
| 类型 | 具体 | 模板策略 | 页限 |
|------|------|----------|------|
| conference | IEEE-default | IEEE-default | 8 |
```

`paper/TERMS.md`:
```markdown
# TERMS
| canonical | expansion | source_path | status |
|-----------|-----------|-------------|--------|
| SlabQuant | slab-wise 4-bit KV quantizer | README.md | from-repo(README.md) |
| WikiText-103 | eval corpus | results/REPORT.md | from-repo |
| (baseline name) | fp16 KV cache | results/REPORT.md | needs-user |
```

`paper/main.tex`:
```latex
\documentclass[conference]{IEEEtran}
\begin{document}
\title{SlabQuant}
\input{sections/method}
\input{sections/experiments}
\end{document}
```

`paper/sections/method.tex`:
```latex
% Status: [ ] not drafted
\section{Method}\label{sec:method}
```

`paper/sections/experiments.tex`:
```latex
% Status: [ ] not drafted
\section{Experiments}\label{sec:experiments}
```

- [ ] **Step 2: Verify fixture completeness**

Run: `find skills/paper/section/references/fixture -type f | sort && grep -rn "needs-user" skills/paper/section/references/fixture`
Expected: 8 files; ≥ 1 `needs-user` term present (drives the "ask, don't invent" test).

- [ ] **Step 3: Commit**

```bash
git add skills/paper/section/references/fixture
git commit -m "Add paper-section test fixture (fake FastKV repo)"
```

---

### Task 10: RED baseline for `paper-section`

- [ ] **Step 1: Run baseline WITHOUT the skill**

Dispatch a subagent (no paper-section skill available), prompt:
`Here is a research repo at <fixture path>. Draft the Method section into paper/sections/method.tex. Return the LaTeX you would write.`

- [ ] **Step 2: Record failure signals verbatim**

Look for and write down (used to shape GREEN counters): does it (a) invent numbers not in REPORT/survey, (b) invent a baseline name instead of flagging T3 `needs-user`, (c) skip any user confirmation/menu, (d) write real-looking `\cite{}` keys, (e) omit `% src:` traceability? Save transcript to `docs/superpowers/plans/notes-paper-section-RED.md` (create it) and commit.

```bash
git add docs/superpowers/plans/notes-paper-section-RED.md
git commit -m "Record paper-section RED baseline (pre-skill behavior)"
```

---

### Task 11: Write `paper-section/SKILL.md` (GREEN)

**Files:**
- Create: `skills/paper/section/SKILL.md`

- [ ] **Step 1: Write the engine**

Create `skills/paper/section/SKILL.md`:

```markdown
---
name: paper-section
description: >
  Use when drafting or revising a body section of a CS paper — 写正文,
  写 intro/related work/method/experiments/limitations/conclusion 某一节.
  Not for the abstract (paper-abstract) or scaffolding (paper-structure).
---

# Paper Section (child of `paper`)

**Parent:** `paper` — owns repo scan → `PAPER_REPO_SURVEY.md` + seeds `TERMS.md`/`STATE.md`.
Draft **one body section at a time** into the LaTeX. Same menu→lock→write gate as `paper-abstract`.

**REQUIRED BACKGROUND:** `../references/storage-framework.md` (占位约定 / 写入归属 / 状态).

## Flow

```text
Phase 1  Ensure survey + GUIDANCE + TERMS; pick section
Phase 2  Content menu (from survey, path-cited)
Phase 3  CONTENT_LOCK  ← HARD GATE
Phase 4  Write prose into the .tex
Phase 5  Self-check + report
```

## Phase 1 — Locate & pick
1. Resolve ROOT. Read `paper/PAPER_REPO_SURVEY.md` (missing/stale → run parent `paper` Phase S first), `paper/GUIDANCE.md`, `paper/TERMS.md`.
2. **Pick section:** scan `paper/sections/*.tex` for `% Status: [ ] not drafted` and list them; or take the section the user named.
3. Load `../references/section-themes.md` (always) + `../references/sections/<name>.md` (if present; else fall back to the index row).

## Phase 2 — Content menu
Build selectable items citing survey `claim_id` + path. Each row: `ID | 一句话 | 来源路径 | 建议`.
Numbers only from survey claim_ids. Terms only from `TERMS.md`; a `needs-user` term → ask, do not invent.

## Phase 3 — HARD GATE
```markdown
# CONTENT_LOCK (section=<name>)
- Included: …
- Numbers (value ← claim_id ← path): …
- Terms used (← TERMS.md): …
- Status: CONFIRMED
```
No prose before CONFIRMED.

## Phase 4 — Write
- Edit only `paper/sections/<name>.tex`. Follow that section's **Move order** from themes/deep-dive.
- Every number inline `% src: <claim_id> (path)`; unbacked → `% NUM-NEEDED`, do not write it.
- Citations `\cite{TODO:...}` + `% CITE-NEEDED`; figures/tables `% FIG-NEEDED`/`% TAB-NEEDED` + `\ref{fig:TODO-...}`.
- Flip `% Status:` → `[x] drafted`. Refresh `paper/STATE.md` sections line.

## Phase 5 — Self-check + report
- Run the section's **Done-when** checklist + "every number traces to survey".
- If GUIDANCE page limit known and the draft looks over budget, warn (do not hard-truncate).
- Report: section, claim_ids used, files touched, any `needs-user`/`NUM-NEEDED`/`CITE-NEEDED` left open.

## Hard rules
1. One section per run; edit only that section's `.tex`.
2. **No invented numbers, terms, citations, figures.** Missing → mark + ask.
3. No final prose before CONTENT_LOCK.
4. No unsolicited git push.
5. Chinese discussion; English LaTeX.

## Anti-patterns
- Writing prose before the lock.
- Numbers absent from `PAPER_REPO_SURVEY.md`.
- Inventing a `needs-user` term instead of asking.
- Editing main.tex preamble (that is paper-structure's).

## References
- Parent: `../SKILL.md`
- `../references/storage-framework.md`, `../references/section-themes.md`, `../references/sections/<name>.md`
```

- [ ] **Step 2: Verify frontmatter + word budget**

Run: `sed -n '1,10p' skills/paper/section/SKILL.md | grep -c "Use when" && wc -w skills/paper/section/SKILL.md`
Expected: 1; word count < 550 (acceptable for a gated engine; trim if > 600).

- [ ] **Step 3: Commit**

```bash
git add skills/paper/section/SKILL.md
git commit -m "Add paper-section engine (menu->lock->write body sections)"
```

---

### Task 12: GREEN — verify `paper-section` on the fixture

- [ ] **Step 1: Run WITH the skill**

Dispatch a subagent that loads `paper-section`, prompt:
`Using paper-section, draft the Method section for the repo at <fixture path>. Show the menu, the CONTENT_LOCK, and the final method.tex.`

- [ ] **Step 2: Assert pass criteria**

Confirm ALL hold; if any fails, it is a REFACTOR item (Task 13):
- Presents a content menu citing claim_ids/paths before writing.
- Emits a `CONTENT_LOCK` and waits.
- Final `method.tex`: numbers carry `% src:`; no number absent from survey; baseline term (`T3 needs-user`) is flagged/asked, not invented; citations use `\cite{TODO:...}`; `% Status:` flipped to `[x] drafted`.

- [ ] **Step 3: Record transcript + commit**

```bash
git add docs/superpowers/plans/notes-paper-section-GREEN.md
git commit -m "Record paper-section GREEN run on fixture"
```

---

### Task 13: REFACTOR — close loopholes

- [ ] **Step 1: For each Task 12 failure, add an explicit counter**

Edit `skills/paper/section/SKILL.md`: add the specific rationalization to Anti-patterns and, if it is a rule violation, to Hard rules. Example counters to include if seen: "『合理补个 baseline 名』= 造假，必须问用户"; "『先写 prose 再补锁』= 违反 gate".

- [ ] **Step 2: Re-run Task 12 Step 1 until all pass criteria hold**

Repeat GREEN. Expected: all Task 12 assertions pass.

- [ ] **Step 3: Commit**

```bash
git add skills/paper/section/SKILL.md
git commit -m "Harden paper-section against fixture-surfaced loopholes"
```

---

### Task 14: Wire the parent `paper/SKILL.md`

**Files:**
- Modify: `skills/paper/SKILL.md` (body: Hierarchy, routing table, Shared artifacts, Phase S, hard rules)

- [ ] **Step 1: Add `paper-section` to the hierarchy tree**

In the `## Hierarchy` code block, add under the tree:
```text
├── section/                   ← paper-section (body sections)
```
and add to the children table a row:
`| **`paper-section`** (`paper/section/`) | Body section: menu → lock → write prose into LaTeX |`

- [ ] **Step 2: Add routing + Phase S terminology + artifacts**

- In the S.3 routing table add a row: `| 写正文/某节 (intro/method/…) | Invoke **`paper-section`** |`.
- In Phase S description, add: `Also extract terminology (see survey template §1t) and, after scan, seed `paper/TERMS.md` and `paper/STATE.md` from the survey; mark unknown terms `needs-user`.`
- In the `## Shared artifacts` table add rows for `paper/TERMS.md` (owner paper), `paper/STATE.md` (owner: all, rollup), and link the full contract: `完整契约见 references/storage-framework.md`.

- [ ] **Step 3: Verify**

Run: `grep -c "paper-section\|TERMS.md\|STATE.md\|storage-framework" skills/paper/SKILL.md`
Expected: ≥ 5.

- [ ] **Step 4: Commit**

```bash
git add skills/paper/SKILL.md
git commit -m "Wire parent paper skill to paper-section + TERMS/STATE + storage-framework"
```

---

### Task 15: `paper-abstract` consumes TERMS + placeholder conventions (regression)

**Files:**
- Modify: `skills/paper/abstract/SKILL.md`

- [ ] **Step 1: Add TERMS + placeholder rules**

In `skills/paper/abstract/SKILL.md` Phase 4 (style/format), add two bullets:
- `Terms: use canonical forms from `../TERMS.md` verbatim; a `needs-user` term → ask, don't invent.`
- `No fabricated citations/numbers; numbers trace to survey claim_ids (see `../references/storage-framework.md`).`

Add to Anti-patterns: `- Using a term not in TERMS.md / a number not in the survey`.

- [ ] **Step 2: Regression — abstract still works**

Dispatch a subagent loading `paper-abstract` on the fixture, prompt: `Draft the abstract.` Confirm it still reaches CONTENT_LOCK and cites only survey numbers, and now respects TERMS (uses "SlabQuant", flags T3).

- [ ] **Step 3: Commit**

```bash
git add skills/paper/abstract/SKILL.md
git commit -m "paper-abstract: consume TERMS.md + placeholder conventions"
```

---

### Task 16: Docs sync — README, SOURCES, install.sh

**Files:**
- Modify: `README.md`
- Modify: `SOURCES.md`
- Modify: `install.sh`

- [ ] **Step 1: README fixes**

- Add rows to the 一览 table for `paper-structure` (was missing) and `paper-section` (new).
- Regroup: put `paper` / `paper-structure` / `paper-section` / `paper-abstract` together under a 论文 category; remove `paper-structure` from the 科研 category and drop the `（原 cs-paper-structure）` leftover naming.
- Recount the "共 N 个 skill" line to the actual number (count `find skills -name SKILL.md | wc -l`).
- Fix the 仓库结构 ASCII tree indentation so `paper/` nests under `skills/` with its children.
- Update 推荐组合 / 许可 rows to name `paper-section`.

- [ ] **Step 2: SOURCES.md**

Add `paper-section` to the self-authored list (same license note as other 自研 skills).

- [ ] **Step 3: install.sh recursion check**

Run: `bash -n install.sh && grep -n "cp -R\|cp -r" install.sh`
Confirm it copies `skills/*` recursively (so new nested `references/` dirs are included). If it enumerates skills explicitly, add `paper` (whole tree) — do NOT list children separately. Fix if needed.

- [ ] **Step 4: Verify counts + commit**

Run: `n=$(find skills -name SKILL.md | wc -l); echo "skills=$n"; grep -n "$n" README.md | head -1`
Expected: README's total matches `$n`.

```bash
git add README.md SOURCES.md install.sh
git commit -m "Docs sync: add paper-section, fix README table/category/count/tree"
```

- [ ] **Step 5: SP1 done — final check**

Run: `git log --oneline | head -20 && find skills/paper -name '*.md' | sort`
Confirm all planned files exist and all tasks committed.

---

## Self-review (author checklist — completed before handoff)

- **Spec coverage:** every spec §3 component (1–17) maps to a task: AUTHORING(T1), section-themes(T2), storage-framework(T3), _TEMPLATE(T4), method.md(T5), survey terms(T6), structure refactor+references(T7), descriptions(T8), fixture(T9), paper-section(T10–13), parent wiring(T14), abstract(T15), README/SOURCES/install(T16). Terminology mechanism spread across T6/T9/T14/T15. Tests T1(T10-13)/T2(T8)/T3(T2,T3,T7)/T4(T16).
- **Placeholders:** none — every file step carries real content; `TODO:`/`NEEDED` tokens are intentional LaTeX placeholder conventions, not plan gaps.
- **Type/name consistency:** artifact names (`PAPER_REPO_SURVEY.md`, `TERMS.md`, `STATE.md`), status tokens (`[ ]/[~]/[x]/[!]`), and placeholder markers (`% src:`, `% NUM-NEEDED`, `\cite{TODO:...}`) are used identically across storage-framework, paper-section, and abstract tasks.
```

