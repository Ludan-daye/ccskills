# Limitations — deep dive

## Theme
失效模式与范围：诚实框定方法的边界，抢在 reviewer 之前说出弱点而不自毁主张。

## Role in the paper
Limitations 为全文主张划定有效范围，抢在 reviewer 之前框定已知弱点，避免评审在 rebuttal 阶段才发现。上游依赖 Method 的假设条件与 Experiments 里出现的边界 / 负面结果；下游被 Conclusion 的克制展望呼应。

## Move order
1. 诚实假设（方法在什么条件下成立）
2. 数据 / 算力 / 规模限制（评测覆盖了什么、没覆盖什么）
3. 负面发现（已观察到的失效场景，哪怕伤害主张普适性）

## Must include
- 方法生效依赖的核心假设，诚实写明
- 数据规模 / 算力 / 评测覆盖的边界
- 已观察到的负面结果或失效模式（如 Experiments 里有）
- 限制对主张适用范围的影响（可选，1 句）

## Must not
- 假谦虚（空泛"未来可以做得更好"不指向具体弱点）
- 把本节写成 future-work 广告
- 自我否定到撤回核心贡献
- 回避 Experiments 里已出现的负面数字 / 现象

## Common mistakes → fix
| 坏味道 | 修法 |
|--------|------|
| 只写"未来工作"、不写"当前弱点" | 先诚实列限制，future-work 最多一句带过 |
| 限制空泛（"可能不适用于所有场景"） | 具体到假设 / 数据 / 场景，说清哪些、为什么 |
| 回避 Experiments 里已出现的负面结果 | 主动引用，框定为已知限制而非隐藏 |
| 语气过度自谦，连带否定核心贡献 | 限制是"范围声明"，不是"撤回声明" |

## Claim → evidence mapping
Limitations 一般不引入新数字；引用 Experiments 里已出现的边界 / 负面数据点时，复用同一个 `% src: <claim_id> (path)`，不重新计算或改写数值。新的、Experiments 未覆盖的"猜测性弱点"允许定性陈述，但不得配一个数字撑场面。

## Length guidance
典型 0.2–0.5 页，1–2 段。超页限先砍非核心假设，保留 reviewer 最可能攻击的 1–2 点与数据 / 算力边界。

## Micro-example (structure only)
```
\section{Limitations}\label{sec:limitations}
% Move 1: honest assumption(s) the method relies on
% Move 2: data/compute scope not covered
%   (if echoing an Experiments finding: % src: <claim_id> (path), same id as Sec.~\ref{sec:experiments})
% Move 3: negative finding / failure mode observed
% Move 4 (optional, <=1 sentence): forward pointer to outlook -- no new claims here
```

## Done-when checklist
- [ ] 预先框定了 reviewer 最可能的攻击点，且未自我否定核心贡献
- [ ] 诚实假设 + 数据 / 算力边界 + 负面发现三者都在场（不是只有 future-work）
- [ ] 术语照 `TERMS.md`
- [ ] 引用 Experiments 已有数字时 `% src:` 与之一致；未引入新数字
- [ ] 如引用外部限制来源，用占位约定：`\cite{TODO:...}` + `% CITE-NEEDED`
