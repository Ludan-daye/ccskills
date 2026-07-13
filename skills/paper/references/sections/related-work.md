# Related Work — deep dive

## Theme
定位与区分：讲清楚「我们和谁比、哪里一样、哪里不同」，让读者放心我们没有漏掉最相关的工作。

## Role in the paper
RW 把本文放进已有工作的坐标系，为 Intro 的 gap 提供"现有工作为何不够"的证据，也预告 Experiments 要对比的对象。上游依赖 Intro 的 gap 陈述；下游被 Experiments（baselines 选择需与此一致）、Method（design rationale 里的"不同于 X"）引用。

## Move order
Structure = **one part per collected angle** (from `paper/REFS_SHORTLIST.md`):
- **成果/方法型:** Part 1 背景与来源 (angle `lineage`) → Part 2 相关能力与对比 (angle `competing`).
- **理论型:** Part 1 (`foundation`) → Part 2 (`prior-result`).
- **说明/解释型:** single part (`existing-explanation`).
Within each part: topic clusters → name representative works with `\cite{key}` → same/different-axis positioning (参照 `related-work-examples.md` 的归纳风格，灵活不死板). lineage/foundation first, competing/prior-result after.

## Must include
- 按主题 / 技术路线分组，而非扁平年表
- 每簇显式给出 same-axis（共享什么）与 different-axis（区别在哪）
- 点名最近基线，且与 Experiments 的 baselines 一致
- 每条 prior-work 断言可追到来源
- 风格参照 `related-work-examples.md` 归纳的约束词/写法（same/different 定位、过渡）——灵活，不逐词照搬。

## Must not
- 无批判的罗列（"A 做了 X，B 做了 Y"却无评判）
- 漏掉直接竞争者（尤其 Experiments 用作 baseline 的工作）
- 把 RW 写成对他人工作的贬低或过度解读
- 编造引用或参考编号

## Common mistakes → fix
| 坏味道 | 修法 |
|--------|------|
| 按时间顺序罗列、无分组 | 按主题 / 技术路线分簇 |
| 只说"不同"不说"哪里同" | 每簇先给 same-axis 再给 different-axis |
| 提到的基线和 Experiments 表格对不上 | 收尾前核对 RW 最近基线 = Experiments baselines |
| prior-work 断言无来源 | 一律 `\cite{TODO:AuthorYear-topic}` + `% CITE-NEEDED`，不编造 |

## Claim → evidence mapping
RW **以定位为主、大体保持少数字**（顶会 6 篇里 5 篇 RW 全程无数字，见 `related-work-examples.md` 数字专项）。
- **他人数字**：如引前作报告的数字，标外部来源（`\cite{TODO:...}` + `% CITE-NEEDED`），不套用本文 survey 的 `claim_id`；偶尔用即可，别系统性堆分数。
- **我方数字（默认不进 RW 正文，留 Experiments/Abstract/Intro）**，唯一例外：针对**单个点名的"最近竞争者"**的定位句里，可放**恰好一个**我方数字（带 `% src: <claim_id> (path)`），如 vLLM 对 Orca 那样"我们比 X 快约 N×"；**不是结果复述、不成表、不常规化**——一句、系于一个 named rival。
- 研究仓库常缺 prior-work 清单 → 一律 `\cite{TODO:AuthorYear-topic}` 占位，绝不编造作者 / 年份 / 会议名。

## Refs, citations & bib (related-work is the real-cite section)
- Input: `paper/REFS_SHORTLIST.md` `USER_SELECTION` (`Status: CONFIRMED`); missing/unconfirmed → run `paper-refs` first, don't self-select.
- Cite ONLY selected refs; emit **real** `\cite{key}` (not `\cite{TODO:}`).
- For every cited ref, append ONE BibTeX entry to `paper/refs.bib` using verified metadata from `paper-refs` — do not invent fields; a missing field → `% BIB-INCOMPLETE: <field>`.
- **bib key** = `<firstauthorlastname><year><firstsignificantword>` lowercased, symbols stripped (e.g. `vaswani2017attention`); on collision add `a`/`b`.
- **Missing-field fallback:** if the shortlist/pool lacks a field (e.g. no author column), leave it `% BIB-INCOMPLETE: <field>`; when authors are absent, form the key from a title-derived token (`<titleword><year><word>`) instead. **Never** fill a field from outside the verified pipeline — re-run `paper-refs` to source it.
- **bibstyle follows the venue template**: read `paper/GUIDANCE.md` §6 / vendor `\bibliographystyle`; ensure entries carry that style's required fields; do not change the template's bibstyle.
- Self-check: every `\cite{key}` has a `refs.bib` entry and is in `USER_SELECTION`.

## Length guidance
典型 0.5–1 页。超页限先砍次要主题簇（保留与 Experiments baseline 直接相关的簇），同轴工作合并成一句多 `\cite`。

## Micro-example (structure only)
```
\section{Related Work}\label{sec:related}
% Move 1: cluster A -- approach/topic summary
%   \cite{TODO:AuthorYear-topicA} % CITE-NEEDED: representative work in cluster A
% Move 2: cluster B -- approach/topic summary
%   \cite{TODO:AuthorYear-topicB} % CITE-NEEDED
% Move 3: same-axis / different-axis statement (per cluster or overall)
% Move 4: closest baseline(s) -- must match Sec.~\ref{sec:experiments} baselines
%   \cite{TODO:AuthorYear-baseline} % CITE-NEEDED
```

## Optional comparison table (ASK the user first)
Default off. At the lock step, ask "要不要 prior-work 对比表?". If yes:
- A LaTeX `table`; **column 1 = work name + `\cite{key}`** (no extra annotation sentence); other columns = comparison dimensions (method type / bit-width / dataset / key metric); **our method is one row**.
- Cited works' numbers only from that ref's verified content; unavailable → blank or `% NUM-NEEDED` (never invented). **Our own numbers carry `% src: <claim_id>`**.
- `\label{tab:related-comparison}` + `% TAB`. If the user says no → skip; prose only.
- 注：顶会通常把定量对比表放在 Experiments（本查 6/6 的 RW 旁无表）——此表是本 skill 的**可选**项，仅在用户要时出；我方数字出现处 = 此表 **或** Claim→evidence 里那一个"最近竞争者"定位句。
- 排版遵循 `../table-style.md`（booktabs 横排无竖线；富化走每表门禁 `TABLE_ENRICH_LOCK`；非 color-only、caption 给图例）。

## Done-when checklist
- [ ] 读者读完知道"我们和谁比、为何不同"
- [ ] 按主题簇组织，每簇有 same/different 轴；最近基线与 Experiments baselines 一致
- [ ] 术语照 `TERMS.md`
- [ ] 无编造引用；全部 prior-work 断言用 `\cite{TODO:...}` + `% CITE-NEEDED`
- [ ] RW 大体少数字；我方数字（如有）仅"最近竞争者"定位句里那一个、带 `% src:`；非结果复述、不成表
- [ ] 无未标注的图表；对比表（如有）用 `% TAB-NEEDED` 占位
- [ ] 结构=每角度一部分；只引 USER_SELECTION；每个 \cite 有 refs.bib 条目
- [ ] bibstyle 随模板；bib key 按规则；缺字段标 % BIB-INCOMPLETE
- [ ] 风格参照 examples 归纳（灵活）；对比表已问过用户
