# Method — deep dive

## Theme
技术贡献：讲清「是什么」和「为什么这样设计」，让同行能重实现核心 idea。

## Role in the paper
承接 Intro 的高层 idea，给出可实现的机制；为 Experiments 的每条主张提供被测对象。上游依赖 problem setup；下游被 Experiments、Conclusion 引用。

## Move order
结构公式 = **总方法(小) + N × 创新点**：
1. Setup / notation（记号集中定义，先定义后使用）
2. Overview（**只占一小部分**：方法框架、模块如何串起、总览图占位 `\ref{fig:TODO-overview}` + 丰富 `% FIG-NEEDED:` 描述图应含的模块/数据流；常规/工程部分在此一句带过，**不单独成节**）
3. **每个 `\subsection` = 一个创新点**（来自 INNOVATION_LOCK 清单，顺序照清单）：动机(为什么需要) → 原理 → 公式(每条配足量文字) → 设计理由
写作流程见 `## Innovation-point flow`；风格参照 `method-examples.md` 归纳（灵活不死板）。

## Innovation-point flow (INNOVATION_LOCK)
```text
Step 1 定结构   method-dig (../method-dig-prompt.md) → paper/METHOD_NOTES.md + survey → 候选创新点
Step 2 清单门禁  创新点清单 → 用户 ← 硬门禁 INNOVATION_LOCK
               每条: 名称 | 一句话原理 | 来源路径 | 建议(核心/次要) | needs-confirm?
               用户 改/删/加/合并/排序；needs-confirm 项逐条确认后才可入正文
Step 3 搭框架   overview 骨架 + 每创新点一个 \subsection 骨架（% Theme / % 原理要点 / % 公式清单）
               落盘后给用户过目（软确认，可喊停；不设第二道硬门禁）
Step 4 逐部分写 默认一次 run 写一个 subsection → 自检(公式验证+配文+零实验) → 报告 → 用户说继续
               （可要求一口气写完）；% Status 按 subsection 粒度: % Status(sub:<slug>): [x] drafted
```
INNOVATION_LOCK 即 method 版 CONTENT_LOCK；**最终以用户改定的清单为准**——skill 不替用户决定什么算创新。

## Idea-dig & METHOD_NOTES (挖思路，不抄代码)
- 写 Method 前派只读 dig 子代理（模板 `../method-dig-prompt.md`）→ `paper/METHOD_NOTES.md`。
- NOTES 记**原理语言**（机制做什么、为什么），`source_path` 只作溯源证据；`needs-confirm` 项未经用户确认不得入正文。
- 正文硬规矩：❌ 贴代码片段 ❌ 变量/函数名级叙述 ❌ 照代码结构逐文件复述；✅ 实现翻译成原理与公式语言。

## Formula discipline (公式纪律)
- 记号先定义后使用（setup 集中定义，跨节一致；方法名照 `TERMS.md`）。
- **每条公式配足量文字**：算什么、每个符号是什么、为什么长这样——禁止裸公式堆砌（参照 method-examples 的 prose-per-formula 观察）。
- **多 agent 公式验证**（Phase 5 自检扩展）：公式逐条交验证子代理（符号定义齐? 量纲/形状自洽? 与 METHOD_NOTES 思路一致? 推导成立?）；问题 → `% FORMULA-CHECK: <issue>`，不静默保留。
- 公式只能来自 METHOD_NOTES 或用户确认的输入——不发明数学。

## Must include
- 形式化的问题定义与记号
- 方法总览（先整体后局部）
- 各核心模块的机制
- 设计理由（为什么不是更简单的做法）

## Must not
- 完整超参表 / 训练细节（放 Experiments）
- 结果数字（放 Experiments）
- 伪造的公式或未定义符号
- 任何实验内容/结果数字/提升幅度（比较留给 \Cref{sec:experiments} 前向引用，不带数值）
- 代码级叙述或代码片段（挖思路不抄代码）
- 裸公式（无文字解释）

## Common mistakes → fix
| 坏味道 | 修法 |
|--------|------|
| 先堆细节后给总览 | 先一段 overview 再下钻 |
| 模块罗列无理由 | 每模块补 1 句 design rationale |
| 记号与 survey/TERMS 不一致 | 方法名 / 符号照 `TERMS.md` |

## Claim → evidence mapping
Method 零实验内容——不出现任何结果数字。机制陈述追 METHOD_NOTES(id+path) 或用户确认项；复杂度/参数量等如需数字，追 survey claim_id 并 % src:，否则 % NUM-NEEDED。

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
- [ ] 结构=总方法(小)+每 subsection 一创新点；清单经 INNOVATION_LOCK
- [ ] 每条公式有配文且通过验证（无未处理 % FORMULA-CHECK）
- [ ] 零实验内容；零代码级叙述；needs-confirm 均已确认
