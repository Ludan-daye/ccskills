# Related Work — deep dive

## Theme
定位与区分：讲清楚「我们和谁比、哪里一样、哪里不同」，让读者放心我们没有漏掉最相关的工作。

## Role in the paper
RW 把本文放进已有工作的坐标系，为 Intro 的 gap 提供"现有工作为何不够"的证据，也预告 Experiments 要对比的对象。上游依赖 Intro 的 gap 陈述；下游被 Experiments（baselines 选择需与此一致）、Method（design rationale 里的"不同于 X"）引用。

## Move order
1. 划分主题簇（按方法路线 / 问题设定分组，不按年份罗列）
2. 每簇内 1–2 句总结代表性工作
3. 显式给出 same-axis（我们和该簇共享什么）与 different-axis（区别点）
4. 点名最近基线（Experiments 要对比的对象），说明为何最相关

## Must include
- 按主题 / 技术路线分组，而非扁平年表
- 每簇显式给出 same-axis（共享什么）与 different-axis（区别在哪）
- 点名最近基线，且与 Experiments 的 baselines 一致
- 每条 prior-work 断言可追到来源

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

## Done-when checklist
- [ ] 读者读完知道"我们和谁比、为何不同"
- [ ] 按主题簇组织，每簇有 same/different 轴；最近基线与 Experiments baselines 一致
- [ ] 术语照 `TERMS.md`
- [ ] 无编造引用；全部 prior-work 断言用 `\cite{TODO:...}` + `% CITE-NEEDED`
- [ ] 无未标注的图表；对比表（如有）用 `% TAB-NEEDED` 占位
