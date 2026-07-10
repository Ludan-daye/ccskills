# Introduction — deep dive

## Theme
叙事驱动 + 可检验贡献：让读者读完第一节就知道「问题是什么、我们做了什么、能不能被验证」。

## Role in the paper
承接全篇的入口：Intro 提出的 gap 必须被 Method 解决、贡献列表必须被 Experiments 证实。上游依赖 motivation / gap（来自 survey 的 story 段）；下游被 Method（兑现 high-level idea）、Experiments（证实贡献里的可检验主张）、Conclusion（回声贡献列表）引用。

## Move order
1. Motivation（为什么这个问题重要，1 段）
2. Gap（现有方法为什么不够，承接 motivation）
3. High-level idea（一段话讲清做法核心，不下钻实现）
4. Contributions list（可枚举、可检验，通常 3 条上下）
5. （可选）Roadmap（各节一句话导航，非必需）

## Must include
- Motivation → gap → idea 的因果链条，环环相扣
- 贡献列表逐条独立、可被后文验证或证伪
- gap 陈述与 Method 实际解决的问题一致
- high-level idea 只给直觉，不给实现细节

## Must not
- 完整方法细节（公式、模块图，属于 Method）
- related-work 式的逐篇综述（属于 Related Work）
- 提前给出具体结果数值
- 贡献写成空泛形容词（"novel"、"effective"）而非可检验陈述

## Common mistakes → fix
| 坏味道 | 修法 |
|--------|------|
| 一上来就讲实现细节 | 先铺 motivation/gap，再引出 idea |
| 贡献是形容词堆砌，无法证伪 | 每条贡献改写成可被 Experiments/Method 验证的陈述 |
| gap 和 Method 实际解决的问题对不上 | 收尾前核对 gap 陈述 vs Method 覆盖范围 |
| roadmap 段落照抄目录、无信息量 | 可选项，无新增价值就直接删 |

## Claim → evidence mapping
Intro 不出结果数字——贡献列表里的主张必须可检验，但数值留给 Experiments 落地。若某条贡献不得不前向引用一个指标（如"提速 N×"），数值处只能占位或标 `% NUM-NEEDED`，等 Experiments 定稿后回填并补 `% src: <claim_id> (path)`；不得先写一个"看起来合理"的数字占位。

## Length guidance
典型 0.75–1.25 页，约 3–5 段（motivation / gap / idea / contributions / 可选 roadmap）。超页限先砍 roadmap，其次精简 motivation 到 1–2 句，保留 gap → idea → contributions 主线不动。

## Micro-example (structure only)
```
\section{Introduction}\label{sec:intro}
% Move 1: motivation (1 para)
% Move 2: gap / problem statement
% Move 3: high-level idea (1 para, no implementation detail)
% Move 4: contributions (itemize; each item independently testable)
\begin{itemize}
  \item <contribution 1>  % NUM-NEEDED if forward-referencing a metric
  \item <contribution 2>
  \item <contribution 3>
\end{itemize}
% Move 5 (optional): roadmap -- \ref{sec:method}, \ref{sec:experiments}, ...
```

## Done-when checklist
- [ ] reviewer 读完能复述约 3 条贡献
- [ ] gap 陈述与 Method / Experiments 实际覆盖一致；无完整方法细节或 RW 式罗列
- [ ] 术语照 `TERMS.md`
- [ ] 无结果数字越界；前向引用的指标带 `% NUM-NEEDED`，不臆造
- [ ] 引用（如有）用占位约定：`\cite{TODO:...}` + `% CITE-NEEDED`
