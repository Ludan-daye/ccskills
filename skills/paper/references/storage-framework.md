# Paper artifact storage framework (存储框架)

paper 全家的磁盘契约。两个存储空间：用户仓库侧（论文项目产物）与 skill 包侧（参考文档）。

## 1. 用户仓库侧 `<ROOT>/paper/`

| 产物 | owner | consumer | 命名 / 生命周期 |
|------|-------|----------|------------------|
| `PAPER_REPO_SURVEY.md` | paper（父） | 全部 | Phase S 生成；stale 重扫；legacy 名 `ABSTRACT_REPO_SURVEY.md` 读后迁移 |
| `TERMS.md` | paper 父 seed | section, abstract | Phase S 后从 survey 术语段生成；`needs-user` 项补齐后转 `user-confirmed` |
| `REFS_POOL.md` | paper-refs | 写作/引文 | Phase 7：≥80 条已核实相关工作池（含 dropped 计数） |
| `REFS_SHORTLIST.md` | paper-refs | 写作/引文 | Phase 8：~20+ 候选 + `USER_SELECTION`（用户确认的引用集合，后续 refs.bib 的真源） |
| `METHOD_NOTES.md` | paper-section (method dig) | method 写作 | 写 Method 前由只读 dig 生成：机制思路(原理语言,非代码摘录)+source_path+状态(from-repo/needs-confirm)；needs-confirm 未确认不得入正文 |
| `FIGURE_BRIEF_<name>.json` | paper-section (figure) | 下游图像/画图生成器 | 架构图 brief（figure-style schema）；数字溯源 `% src:`/`NUM-NEEDED`；两段门禁 `FIGURE_LOCK` 后生成；只产 brief 不渲染 |
| `STATE.md` | 各 skill 收尾刷 | paper 路由 | 项目级进度汇总（见 §4） |
| `GUIDANCE.md` | paper-structure / paper | 全部 | intake 后建，逐问更新 |
| `vendor/` | paper-structure | — | 官方模板包，尽量不改 |
| `main.tex` 前导 / frontmatter | paper-structure | — | 骨架期建 |
| `sections/*.tex` 正文体 | paper-section | — | 起草期写；`% Status` 为每节真源 |
| abstract 正文 | paper-abstract | — | CONTENT_LOCK 后写 |
| `refs.bib` | paper-section (related-work) | LaTeX 编译 | related-work 写作时为被引选定 refs 追加 BibTeX 条目；key=`<author><year><word>`；bibstyle 随 venue 模板；缺字段标 `% BIB-INCOMPLETE`；每个 `\cite{key}` ↔ 一条 |

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
| 表格宏包 | table 富化用到的宏包（`booktabs/xcolor/colortbl/multirow/amssymb` 等）须在 main.tex/GUIDANCE 声明；缺 → `% PKG-NEEDED: <pkg>` | 不静默假设 preamble |

## 6. TERMS.md 契约
- 每条：`规范写法 | 展开 | source_path | 状态(from-repo(path) / user-confirmed / needs-user)`。
- section / abstract 规范写法逐字照用；需表外术语→停下问用户，不编。
