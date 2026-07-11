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
RW 本身不出本文的结果数字；如需引用他人报告的数字做对比，须标注为外部来源（`\cite{TODO:...}` + `% CITE-NEEDED`），不得套用本文 survey 的 `claim_id`。研究仓库常缺 prior-work 清单——这种情况下一律用 `\cite{TODO:AuthorYear-topic}` 占位，绝不编造看似真实的作者 / 年份 / 会议名。

## Refs, citations & bib (related-work is the real-cite section)
- Input: `paper/REFS_SHORTLIST.md` `USER_SELECTION` (`Status: CONFIRMED`); missing/unconfirmed → run `paper-refs` first, don't self-select.
- Cite ONLY selected refs; emit **real** `\cite{key}` (not `\cite{TODO:}`).
- For every cited ref, append ONE BibTeX entry to `paper/refs.bib` using verified metadata from `paper-refs` — do not invent fields; a missing field → `% BIB-INCOMPLETE: <field>`.
- **bib key** = `<firstauthorlastname><year><firstsignificantword>` lowercased, symbols stripped (e.g. `vaswani2017attention`); on collision add `a`/`b`.
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
- Cited works' numbers only from that ref's verified content; unavailable → blank or `% NUM-NEEDED` (never invented). **Our own numbers carry `% src: <claim_id>`** (the comparison table is the ONLY place our numbers may appear in related work).
- `\label{tab:related-comparison}` + `% TAB`. If the user says no → skip; prose only.

## Done-when checklist
- [ ] 读者读完知道"我们和谁比、为何不同"
- [ ] 按主题簇组织，每簇有 same/different 轴；最近基线与 Experiments baselines 一致
- [ ] 术语照 `TERMS.md`
- [ ] 无编造引用；全部 prior-work 断言用 `\cite{TODO:...}` + `% CITE-NEEDED`
- [ ] 无未标注的图表；对比表（如有）用 `% TAB-NEEDED` 占位
- [ ] 结构=每角度一部分；只引 USER_SELECTION；每个 \cite 有 refs.bib 条目
- [ ] bibstyle 随模板；bib key 按规则；缺字段标 % BIB-INCOMPLETE
- [ ] 风格参照 examples 归纳（灵活）；对比表已问过用户
