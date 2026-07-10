# Conclusion — deep dive

## Theme
闭环：确认 Intro 许下的贡献已被 Method + Experiments 兑现，克制地收尾。

## Role in the paper
Conclusion 闭合 claim→evidence 循环：不引入新证据，只确认 Intro 承诺的贡献已被 Method + Experiments 兑现。上游依赖 Intro 的贡献列表与 Experiments 的发现；下游无（全文最后一节），但常被读者与 Abstract 对照跳读，故需保持一致。

## Move order
1. 问题 / 方法回顾（呼应 Intro 的 motivation/idea，不重复细节，1–2 句）
2. 关键发现复述（呼应 Experiments 主结果，不给新数字）
3. 贡献回声（对齐 Intro 贡献列表）
4. 克制展望（1 句，不承诺具体新实验）

## Must include
- 问题 / 方法的简短回顾（呼应 Intro，不重复细节）
- 关键发现的定性复述（呼应 Experiments，不给新数字）
- 贡献回声，与 Intro 贡献列表对齐
- 克制的未来展望（方向性，非具体承诺）

## Must not
- 新的实验主张或 Experiments 未出现过的数字
- 与 Abstract / Intro 不一致的贡献表述
- 展望写成下一篇论文的立项书
- 逐字复制 Intro 段落

## Common mistakes → fix
| 坏味道 | 修法 |
|--------|------|
| 引入 Experiments 未出现的新数字 / 新实验 | Conclusion 零新证据，只定性复述已有发现 |
| 贡献回声与 Intro 列表对不上 | 收尾前逐条核对 Intro 贡献 vs Conclusion 回声 |
| 展望段落写成下一篇论文的立项书 | 展望克制在 1 句方向性陈述 |
| 与 Abstract 结论用词 / 数字不一致 | 收尾前对照 Abstract 复核措辞 |

## Claim → evidence mapping
Conclusion 不引入新数字；提及已有结果时用定性措辞（"显著提升""大幅降低"）或直接复用 Experiments 已标注的 `% src: <claim_id>`，不重新计算或改写数值。任何在 Experiments / survey 中找不到 `claim_id` 的新主张都不得出现。

## Length guidance
典型 0.2–0.4 页，通常 1 段。超页限先砍展望句（保留 1 句即可），recap → findings → contribution echo 主线不动。

## Micro-example (structure only)
```
\section{Conclusion}\label{sec:conclusion}
% Move 1: problem/method recap (echoes Sec.~\ref{sec:intro}; no new detail)
% Move 2: key findings (qualitative echo of Sec.~\ref{sec:experiments}; no new numbers)
% Move 3: contribution echo (aligned to Sec.~\ref{sec:intro} contributions list)
% Move 4: restrained outlook (1 sentence; no new commitments)
```

## Done-when checklist
- [ ] 与 Abstract / Intro 的贡献表述一致
- [ ] 问题 / 方法回顾 + 发现 + 贡献回声 + 展望四步都在场，非逐字复制 Intro
- [ ] 术语照 `TERMS.md`
- [ ] 无新实验主张；引用已有发现定性复述，不新造或改写数字
- [ ] 交叉引用（如有）用占位约定，不新造 slug
