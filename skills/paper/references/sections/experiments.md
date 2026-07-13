# Experiments — deep dive

## Theme
为主张提供证据：把 Intro/Method 里的每条主张换算成可复现的协议、数字与图表。

## Role in the paper
Experiments 是 claim→evidence 闭环的落地点：Intro 的贡献、Method 的设计动机都要在这里被数字坐实。上游依赖 survey 的 data/eval protocol、main results、ablations、baselines 表；下游被 Abstract/Intro 引用其顶层数字、被 Conclusion 复述发现、被 Limitations 引用边界 / 负面结果。

## Move order
1. Protocol（数据集 / 任务、指标、切分与 seed）
2. Baselines（对比对象，需与 Related Work 点名的一致）
3. Main results（核心表 / 图 + 对应主张，逐数字标 `% src:`）
4. Ablations / analysis（拆解设计选择的贡献，回应 Method 的 design rationale）

## Must include
- 完整实验协议（数据、指标、切分、seed、baselines）不隐藏
- 主结果表 / 图，每条主张能指到具体行 / 列
- 消融或分析，回应 Method 提出的设计选择
- 每个数字都有 `% src: <claim_id> (path)` 可追溯
- 所有表遵循 `../table-style.md`（结构基座 MUST + 每表富化门禁 `TABLE_ENRICH_LOCK`）；数字追 survey `claim_id`（`% src:`），多 seed 给 `±std`

## Must not
- 无表 / 图支撑的主张
- 隐藏协议细节（切分 / seed / 是否调参未交代）
- 超出 survey `claim_id` 范围的数字，哪怕"看起来合理"
- 把 `needs-user` 状态的 baseline 名称照写、不问用户

## Common mistakes → fix
| 坏味道 | 修法 |
|--------|------|
| 主张先行、数字事后去"配" | 反过来：先从 survey `claim_id` 找数字，再写主张 |
| 消融放在主结果之前 | main results 先行，ablations/analysis 收尾 |
| 数字无 `% src:` 标注，日后无法溯源 | 起草时逐数字加 `% src: <claim_id> (path)`，缺失标 `% NUM-NEEDED` |
| baseline 名称是 `needs-user` 却照写 | 停下问用户，不用占位名字硬填 |
| 协议细节（seed/切分）语焉不详 | 逐项列出；缺的标注待补，不留隐性假设 |

## Claim → evidence mapping
本节是全篇唯一允许出现结果数字的地方，规则从严：
- 每个数字行内标 `% src: <claim_id> (path)`，`claim_id` 必须来自 `PAPER_REPO_SURVEY.md` 的 main results / ablations / baselines / efficiency 表；
- survey 里找不到对应 `claim_id` 的数字一律不写，标 `% NUM-NEEDED`，不得"合理估计"或凑整；
- baseline / 方法名若在 `TERMS.md` 或 survey 里标为 `needs-user`，停下来问用户，不臆造名字；
- 每条主张（叙述句或数字）都要能映射到一个具体表 / 图（`% TAB-NEEDED` / `% FIG-NEEDED`），孤立主张视为未完成。

## Length guidance
典型 1.5–3 页。超页限先砍次要 ablation（保留能证伪核心贡献的那些），协议细节可移 appendix（若 venue 允许）但正文留一句摘要；main results 表 / 图不可砍。

## Micro-example (structure only)
```
\section{Experiments}\label{sec:experiments}
% Move 1: protocol -- dataset/task, metric, split, seed
%   % NUM-NEEDED: any protocol number not yet in survey
% Move 2: baselines -- must match Sec.~\ref{sec:related}
%   \cite{TODO:AuthorYear-baseline} % CITE-NEEDED
% Move 3: main results (Table~\ref{tab:TODO-main})  % TAB-NEEDED: main results table
%   <claim> ... <value> % src: <claim_id> (path)
% Move 4: ablations/analysis (Table~\ref{tab:TODO-ablation} or Figure~\ref{fig:TODO-analysis})
%   % TAB-NEEDED / % FIG-NEEDED
%   <claim> ... <value> % src: <claim_id> (path)
```

## Done-when checklist
- [ ] 每条主张都映射到某个具体表 / 图
- [ ] 协议完整（数据 / 指标 / 切分 / seed），未隐藏
- [ ] 术语照 `TERMS.md`；baseline 名称非 `needs-user` 状态臆填
- [ ] 每个数字都带 `% src: <claim_id> (path)`；无来源的标 `% NUM-NEEDED`，不臆造
- [ ] 图表 / 引用用占位约定：`% TAB-NEEDED` / `% FIG-NEEDED` / `\cite{TODO:...}` + `% CITE-NEEDED`
