# Method Writing (SP5) — Design Spec

## 0. 元信息

| 项 | 值 |
|----|----|
| 日期 | 2026-07-12 |
| 分支 | `paper-method-write` |
| 状态 | Draft（待用户过目 → writing-plans） |
| 范围 | Method 节写作增强：创新点驱动结构 + 代码思路挖掘 + 公式纪律 + examples |
| 形态 | **增强**（不新增 skill）：`paper-section` method 路径 + `sections/method.md`（照 SP4 模式） |

## 1. 背景与目标

### 1.1 现状
- `paper-section` 通用引擎能写 Method（SP1 GREEN 用它验证过），`sections/method.md` 有基础 move 顺序（setup→overview→modules→rationale）。
- 但素材太薄：survey 只有 `method_name` + 一句话；机制细节在仓库**代码**里，无环节去挖——SP1 GREEN 里 agent 只能满屏 `% NUM-NEEDED`。
- 无顶会 Method examples（related-work 有 7 篇 + 风格归纳，Method 没有）。
- Method 特有元素（公式/记号、架构图、创新点结构）无约定。

### 1.2 目标（用户定的结构公式与流程）
1. **结构 = 总方法(小) + N × 创新点**：overview 只占一小部分；每个 `\subsection` 对应一个创新点；**不是方法的每个部分都要写**（常规/工程部分 overview 一句带过）。
2. **只讲原理和公式，零实验内容**：比"结果数字放 Experiments"更严——Method 里连"提升多少"都不出现，纯机制。
3. **流程**：定结构 → 创新点清单给用户（改/删/加/合并/排序 → 确认）→ 先搭框架 → 逐 subsection 写。
4. **挖思路不抄代码**：code-dig 提取方法思想，`source_path` 只作溯源证据；正文不贴代码、不函数名级叙述。
5. **公式纪律**：每条公式配足量文字；多 agent 验证；记号先定义。
6. **examples 照 related-work 同款**：真去顶会找 → 逐篇分析写法与结构 → 归纳灵活风格总结（不抄句）。

## 2. 核心机制

### 2.1 结构公式与四步流程（两道确认，一硬一软）
```
Step 1  定结构：method-dig(§2.2) → METHOD_NOTES + survey → 提取候选创新点
Step 2  创新点清单 → 用户 ← 门禁1(硬, INNOVATION_LOCK)
        每条：创新点名 | 一句话原理 | 来源路径 | 建议(核心/次要) | needs-confirm?
        用户改/删/加/合并/排序 → 确认（needs-confirm 项逐条确认）
Step 3  搭框架落盘：overview 骨架 + 每创新点一个 \subsection 骨架
        （骨架带 % Theme / % 原理要点 / % 公式清单 占位）
        → 给用户看一眼（软确认：透明展示，可喊停；不设第二道硬门禁）
Step 4  逐部分写：默认一次 run 写一个 subsection，写完自检
        （公式验证 + 每公式配文字 + 零实验内容）→ 报告 → 用户说继续再写下一个
        （用户可要求"一口气写完"）
```
- 门禁 1 (`INNOVATION_LOCK`) 是 method 版的 CONTENT_LOCK：锁"哪几个创新点、各叫什么、什么顺序、needs-confirm 是否确认"。
- `% Status` 按 **subsection 粒度**跟踪（`% Status(sub:slab-partition): [x] drafted`），Method 可跨多轮会话写完。

### 2.2 method-dig：挖思路，不抄代码
- 写 Method 前派**只读 dig 子代理**扫仓库代码/配置/文档，产出 `paper/METHOD_NOTES.md`。
- **任务是提取思想**：机制在做什么、为什么这么设计、算法原理步骤（人话+数学）——**不是代码摘录**；`source_path` 只回答"这条思路我从哪看出来的"。
- 每条：`思路/机制描述 | source_path | 状态`；状态 = `from-repo(path)`（代码/文档明确体现）/ `needs-confirm`（从代码**推断**的机制，用户确认前不得入正文）。
- 正文硬规矩：❌ 贴代码片段 ❌ 变量/函数名级叙述 ❌ 照代码结构逐文件复述；✅ 实现翻译成原理与公式语言。
- 与家族规则：这是 method 专用**聚焦提取**，不是第二次全库 survey（父 skill 的 Phase S 不动）；契约登记 storage-framework（owner = paper-section/method）。

### 2.3 公式纪律
- **记号先定义后使用**（setup 处集中定义，跨节一致；方法名入 TERMS）。
- **每条公式配足量文字描述**：算什么、每个符号是什么、为什么长这样——**禁止裸公式堆砌**（examples 研究量化"顶会每公式配多少文字"作参照）。
- **多 agent 公式验证**（Phase 5 自检的 method 扩展）：草稿完成后公式逐条交验证子代理（可多视角并行——符号定义齐？量纲/形状自洽？与 METHOD_NOTES/代码思路一致？推导成立？）；问题 → `% FORMULA-CHECK: <issue>` 待修，不静默保留。
- 公式只能来自 METHOD_NOTES 或用户确认的输入——**不发明数学**。
- **零实验内容**：无任何结果数字/提升幅度/数据集表现（比较性能的话留给 Experiments 前向引用 `\Cref{sec:experiments}`，不带数值）。

### 2.4 `method-examples.md`（build 时烘焙，与 related-work-examples 同款流程）
研究子代理去顶会找 **6–8 篇真实 Method 章节**，逐篇分析（**不抄句**）：
- 总方法/overview 占比与写法；创新点/组件怎么分 subsection；
- 设计理由（why）怎么穿插；**公式密度 + 每条公式配多少文字**；
- 记号引入方式；总览图怎么用；
最后归纳 `## Style — 写法总结 (summarized, flexible)`——从范例观察归纳（非预设清单），**灵活参照、不逐词照搬、不死板**。

### 2.5 架构图占位规范
overview 必配 `\ref{fig:TODO-overview}` + 内容丰富的 `% FIG-NEEDED:`（图应含哪些模块/数据流），供后续画图。

## 3. 组件清单

| # | 文件 | 动作 | 说明 |
|---|------|------|------|
| 1 | `skills/paper/references/sections/method.md` | 改（大） | 吸收 §2.1–2.3/2.5：创新点结构公式、四步流程、挖思路不抄代码、公式纪律、零实验、链 examples |
| 2 | `skills/paper/references/sections/method-examples.md` | 新增 | build 时研究烘焙（§2.4） |
| 3 | `skills/paper/references/method-dig-prompt.md` | 新增 | dig 子代理模板：提思路不抄代码 + METHOD_NOTES schema + from-repo/needs-confirm 判据 |
| 4 | `skills/paper/section/SKILL.md` | 改 | method 特例块：dig→INNOVATION_LOCK→框架→逐 subsection；公式验证；零实验 |
| 5 | `skills/paper/references/storage-framework.md` | 改 | 加 `METHOD_NOTES.md` 契约（owner=paper-section/method；from-repo/needs-confirm） |
| 6 | `test/fixtures/paper-section/code/slabquant.py`（+可选 config） | 新增 | 假实现（量化函数+slab 分块+配置），供 dig 挖掘；含一处只能"推断"的机制点（测 needs-confirm） |
| 7 | RED/GREEN notes | 新增 | `notes-method-write-RED/GREEN.md` |

## 4. 测试计划（writing-skills 铁律）
- **RED（隔离，无增强）**：fixture（含假代码）让 agent"写 Method"→ 预期失败：无创新点清单门禁、结构不是"总方法+创新点"、可能照代码结构复述或贴代码、裸公式/无验证、实验内容渗入、needs-confirm 机制直接当事实写。
- **GREEN（有增强）**：dig 产出 METHOD_NOTES（思路语言+路径+needs-confirm）→ 创新点清单给用户（模拟确认，含一条 needs-confirm 处理）→ 框架落盘 → 写一个 subsection：每公式带文字、公式验证跑过（FORMULA-CHECK 机制演示）、零实验内容、无代码级叙述。
- REFACTOR：按暴露的漏洞堵。

## 5. 成功标准（Done-when）
1. Method 结构 = 总方法(小) + 每 subsection 一个创新点；非创新部分不单独成节。
2. 创新点清单先给用户（含来源路径 + needs-confirm 标记），`INNOVATION_LOCK` 确认后才搭框架/写作；框架落盘给用户过目（软）。
3. METHOD_NOTES 是思路语言（非代码摘录），每条带路径与状态；正文零代码级叙述。
4. 每条公式配足量文字；多 agent 验证跑过，问题标 `% FORMULA-CHECK`；记号先定义；不发明数学。
5. **零实验内容**（无数字、无提升幅度）。
6. `method-examples.md` 由 6–8 篇真实顶会 Method 分析归纳（同 related-work-examples 流程，不抄句）。
7. RED→GREEN 证明行为改变；storage-framework/fixture/引擎一致。

## 6. 范围之外（YAGNI）
- 真画架构图（只留丰富占位）。
- Method 落真 `\cite`（仍 `\cite{TODO:}`+`% CITE-NEEDED`；真引用目前仅 related-work）。
- 自动编译 LaTeX / 公式数值仿真验证（验证是推理级核查，非跑代码）。
- 其余节的类似深挖（experiments 的协议挖掘等留后续）。

## 7. 风险与开放问题
- **dig 推断的机制可能错**：靠 needs-confirm 门禁兜底——推断项必须用户确认；宁可清单短也不猜。
- **公式验证的边界**：验证子代理做推理级核查（符号/量纲/一致性），不是形式化证明；标记问题交人判。
- **创新点从谁定**：候选由 dig+survey 提取，但**最终以用户改定的清单为准**——skill 不替用户决定什么算创新。
- **fixture 假代码的可挖性**：要有 2–3 个可提取的机制点 + 1 个需推断的点，太浅测不出 needs-confirm。
