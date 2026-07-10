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
