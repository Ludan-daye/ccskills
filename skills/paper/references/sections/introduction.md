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
- 风格与「数字用法」参照 `introduction-examples.md`（8 篇顶会 intro 归纳，灵活不死板）

## Must not
- 完整方法细节（公式、模块图，属于 Method）
- related-work 式的逐篇综述（属于 Related Work）
- 完整结果表格 / 大批数字（表留 Experiments；Intro 只放一小撮 headline，见 Claim→evidence）
- 把数字塞进贡献列表的条目里（数字放列表前后的过渡句，条目本身保持无指标——顶会惯例）
- 无出处 / 编造的数字；用形容词（"novel"、"effective"）代替可检验陈述

## Common mistakes → fix
| 坏味道 | 修法 |
|--------|------|
| 一上来就讲实现细节 | 先铺 motivation/gap，再引出 idea |
| 贡献是形容词堆砌，无法证伪 | 每条贡献改写成可被 Experiments/Method 验证的陈述 |
| gap 和 Method 实际解决的问题对不上 | 收尾前核对 gap 陈述 vs Method 覆盖范围 |
| roadmap 段落照抄目录、无信息量 | 可选项，无新增价值就直接删 |
| 数字塞进贡献 bullet / 搬整张结果表进 Intro | 数字移到列表前后的过渡句、只留 2–5 个 headline、表格留 Experiments |
| 为放而放硬凑数字 | 数字非必需——干净算法/新框架型可走定性；只在能坐实动机/gap/结果时放 |

## Claim → evidence mapping
**Intro 可以放数字**（顶会惯例，见 `introduction-examples.md`：8 篇中 6 篇有），但要克制且有出处：
- **量**：一小撮 headline（约 2–5 个），**不放整张结果表**（表留 Experiments）。
- **三种合法用途**：① field-context 动机（外部/公认数字，`\cite{TODO:}` 或引用来源）；② gap 量化（多为自测，坐实现有方法的不足）；③ 自有 headline 结果预览。
- **溯源**：自有结果数字 `% src: <claim_id> (path)` 追 survey；外部数字带引用。**无出处不写、不编**。
- **位置**：数字放贡献列表**前后的过渡句**，**别塞进 bullet**（条目保持无指标）。
- **可选**：数字非必需——"干净算法/新框架"型论文（如 DPO/SAM）刻意走定性最高级、把大数字留给 Abstract/Experiments，也完全合法；**不要为放而放**。
- 自有结果尚未定稿的前向引用指标 → `% NUM-NEEDED`，Experiments 定稿后回填 `% src:`；不先写"看起来合理"的占位数字。

## Length guidance
典型 0.75–1.25 页，约 3–5 段（motivation / gap / idea / contributions / 可选 roadmap）。超页限先砍 roadmap，其次精简 motivation 到 1–2 句，保留 gap → idea → contributions 主线不动。

## Micro-example (structure only)
```
\section{Introduction}\label{sec:intro}
% Move 1: motivation (1 para)
% Move 2: gap / problem statement
% Move 3: high-level idea (1 para, no implementation detail)
% Move 4a (optional): headline-number preview bridge -- a small set (2-5), traceable,
%   NOT inside the bullets. own results % src: <claim_id> (path); external via \cite{TODO:}.
% Move 4b: contributions (itemize; each item independently testable; metric-free bullets)
\begin{itemize}
  \item <contribution 1>
  \item <contribution 2>
  \item <contribution 3>
\end{itemize}
% Move 5 (optional): roadmap -- \ref{sec:method}, \ref{sec:experiments}, ...
```

## Done-when checklist
- [ ] reviewer 读完能复述约 3 条贡献
- [ ] gap 陈述与 Method / Experiments 实际覆盖一致；无完整方法细节或 RW 式罗列
- [ ] 术语照 `TERMS.md`
- [ ] 数字（如有）是一小撮 headline、在贡献列表前后的过渡句、不在 bullet 内、无整表；每个可追 `% src:`(自有)或外部引用；未定稿的标 `% NUM-NEEDED`，不臆造
- [ ] 引用（如有）用占位约定：`\cite{TODO:...}` + `% CITE-NEEDED`
