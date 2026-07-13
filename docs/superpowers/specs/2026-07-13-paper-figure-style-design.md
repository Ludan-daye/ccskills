# Figure Style (SP7) — Design Spec

## 0. 元信息

| 项 | 值 |
|----|----|
| 日期 | 2026-07-13 |
| 分支 | `paper-figure-style` |
| 状态 | Draft（待用户过目 → writing-plans） |
| 范围 | 论文主架构/流程图工具：产出结构化「图 brief」（喂下游图像/画图生成器） |
| 形态 | 新建共享 `references/figure-style.md`；method overview 图 + 通用 `% FIG` 走它 |

## 1. 背景与目标

### 1.1 现状
家族里图（figure）只有裸 `% FIG-NEEDED: <描述>` 占位——没有"怎么设计一张顶会级架构/流程图"的规范，也没有可交给下游图像/画图生成器的结构化产物。

### 1.2 目标
建 `figure-style.md`：把顶会实证的**图结构惯例** + 用户给定的**图 brief 模版**统一，使 skill 能——按贡献类型选骨架、按研究惯例填样式默认、**从 `METHOD_NOTES`/survey 取可溯源内容**、**两段门禁（排版+内容）确认后**产出一份结构化 **figure-brief（JSON）**，交下游生成器/设计师渲染。**只产 brief，不渲染图。**

### 1.3 证据基础
研究 6 篇 venue-verified 顶会主架构图（SAM ICCV'23、SAM2 ICLR'25、ControlNet ICCV'23、DPO NeurIPS'23、Self-RAG ICLR'24、vLLM SOSP'23）。最强惯例：**图 box 名 = Method 小节名**（6/6）；创新点靠命名/隔离/省略标记（非只居中/颜色）；block 级不到代码；冻结灰/创新亮；**caption 做论点**。

## 2. 输出 = 结构化 figure-brief（用户给定模版为 schema）

**学习边界（重要）**：从用户给的 JSON 学的**只是格式/字段 schema**，**不是它的具体内容**——例子里的 stages、维度数字、`red=harmful/blue=benign` 语义、那 4 个面板，都是**某安全论文的示范填充**，非规定。

| 从哪学 | 学什么 |
|--------|--------|
| 用户给的 **JSON** | 只学**格式 / 字段 schema**（`type/instruction/style/layout` 的结构与嵌套）|
| 研究 **examples**（6 篇顶会图）+ 贡献类型 | **排版**：骨架选型、面板组合、创新点放哪、配色/图标惯例 |
| **`METHOD_NOTES`/survey/Method 小节**（skill 家族） | **内容**：部件、维度、latency、结果数字、box 名 |

产物 `<ROOT>/paper/FIGURE_BRIEF_<name>.json`（LaTeX 里 `% FIG-NEEDED` 链接它）。三层字段结构（= 从 JSON 学的 schema）：

- **`type` / `instruction`**：图类型 + 设计原则（schematic、每 block/箭头/字形都带信息、标 tensor 维度 + latency、顶会清晰度、留白胜堆砌）。
- **`style{render,palette,typography,modules}`**：每项 `{argument name=... default=...}` 可覆盖；**默认值 = 研究惯例**——clean flat 矢量 schematic；**Okabe-Ito 色盲安全调色板**，颜色**按本论文自身的语义角色分配**（JSON 例子的 `red=harmful/blue=benign/green=ALLOW/vermilion=BLOCK` 是那篇安全论文的语义，**非通用**——换论文按其自身角色重映射）；geometric sans + monospace 张量 + small-caps 头；rounded block + **雪花/锁=frozen**。
- **`layout{main_title, centerpiece{position,description,count,stages[]}, sections[]{position,title,description,count,items/blocks/labels}}`**：`main_title` 是论点式标题；`centerpiece` 是主数据流（stages 逐段标维度+latency）；`sections` 是支撑面板（insight「为什么成立」几何/机制 · comparison「gained/lost」设计选择 · results band 真实结果数字）。

## 3. 核心机制

### 3.1 骨架选型（按贡献类型 — 研究得来）
提议匹配的骨架，不用默认：
| 骨架 | 适合 |
|------|------|
| 多分支→汇合 | 融合异构输入 |
| 基线流水线 + 时间反馈环 | 序列/视频扩展 |
| 冻结主干 + 可训练副本 + 特殊连接件 | adapter/控制/微调 |
| 基线 vs 本文 并排 | 卖点是"减步骤/简化" |
| 内联决策分支流程图 | 解码时/agentic 控制 |
| 系统控制流 + 单独放大机制图 | 系统论文 |
`centerpiece` 用主骨架；`sections` 面板（insight/comparison/results）按需增减。

### 3.2 内容来源 + 溯源（防"图里全是编的"）
- **维度 / latency / 架构部件** ← `paper/METHOD_NOTES.md`（method-dig 产出的机制思路，`source_path`）。
- **结果数字**（如 Youden's J、σ、倍数、AUC）← survey `claim_id`，逐个 `% src: <claim_id>`。
- **图 box 名 = `METHOD_NOTES` 机制 / Method 小节名**（6/6 惯例）；术语照 `TERMS.md`。
- **每个数字有据才填；无据 → `NUM-NEEDED`（brief 里标出），绝不编造/凑数**。用户给的填满范例是"有据成品"；skill 规矩是有据才填。
- 抽象 **block 级、不抄代码**（承接 method 的"挖思路不抄代码"）。

### 3.3 两段门禁（`FIGURE_LOCK` — 生成前必问）
1. **排版**：提议骨架 + 有哪些面板 + 各部件位置 + 富化（高亮/zoom-in inset/before-after/frozen 图标） → 用户加减确认。
2. **内容**：提议各槽位放什么（stages 部件与维度、insight 讲什么、comparison 的 gained/lost、results 放哪几个数字**及其来源**）→ 用户确认（`NUM-NEEDED` 项逐条点明）。
3. 两段都确认 → `FIGURE_LOCK: CONFIRMED` → **才生成**最终 JSON brief。用户改则回上一步。

### 3.4 护栏
- 名 = Method 小节名；block 级不抄代码；**不编造不在 `METHOD_NOTES` 的部件/数字**。
- `main_title`/caption **做论点**（不是"X 的示意图"）。
- 配色沿用 table-style 护栏：**Okabe-Ito 色盲安全、灰度可读、非 color-only**（语义靠颜色+图标+文字多重编码）；frozen=雪花/锁图标非仅灰。
- 富化**适度**：每元素带信息，留白胜装饰。

## 4. 组件清单

| # | 文件 | 动作 | 说明 |
|---|------|------|------|
| 1 | `skills/paper/references/figure-style.md` | 新增 | 图 brief schema + 样式默认(研究惯例) + 骨架选型 + 溯源填充 + 两段门禁 + 护栏 + 证据来源 |
| 2 | `skills/paper/references/figure-brief-template.json` | 新增 | 用户给定的模版（arg 默认 + 槽位），skill 据此产 brief |
| 3 | `skills/paper/references/sections/method.md` | 改 | overview 图 = 产 figure-brief（走 figure-style，box 名=小节名） |
| 4 | `skills/paper/section/SKILL.md` | 改 | 出任何图：遵循 `../references/figure-style.md` + 两段门禁 |
| 5 | `skills/paper/references/storage-framework.md` | 改 | 加 `FIGURE_BRIEF_<name>.json` 产物契约（owner=paper-section/figure；数字溯源/NUM-NEEDED） |

## 5. 测试计划（writing-skills 铁律）
- **RED（隔离，无规范）**：给 fixture（含 `METHOD_NOTES` + survey 结果）让 agent"做一张 method 架构图 brief"→ 预期：**编造维度/latency/结果数字**、无骨架-贡献匹配、box 名与 Method 小节不一致、无两段门禁、caption 只描述不论点、颜色非色盲安全或 color-only。
- **GREEN（有规范）**：→ 按贡献选骨架、样式默认=研究惯例、**内容全溯源**（维度/latency ← METHOD_NOTES、结果 ← claim_id `% src:`，无据标 `NUM-NEEDED`）、box 名=小节名、**两段门禁**（提议排版+内容→模拟用户确认→`FIGURE_LOCK`）、caption 论点、Okabe-Ito 非 color-only → 产出合规 JSON brief。
- **fixture 扩充**：`METHOD_NOTES` 给部件维度（如 KV `d`、slab `S=64`、4-bit）+ latency 占位；survey 结果已有（R1–R4）。
- REFACTOR：按暴露漏洞堵。

## 6. 成功标准（Done-when）
1. `figure-style.md` + `figure-brief-template.json` 覆盖：schema + 样式默认 + 骨架选型 + 溯源填充 + 两段门禁 + 护栏。
2. method/paper-section/storage-framework 接线。
3. GREEN：骨架按贡献；内容全溯源（`% src:`/`NUM-NEEDED`，零编造）；box 名=小节名；两段门禁 `FIGURE_LOCK`；caption 论点；色盲安全非 color-only；产出结构化 brief。RED 反面成立。

## 7. 范围之外（YAGNI）
- **真渲染/生成图像**（只产 brief，交下游生成器/设计师）。
- TikZ/mermaid 代码生成（brief 是给图像生成器的，不是 LaTeX 绘图栈）。
- 非架构图（结果图、示意插图）的专门规范（本次只做 method 主架构/流程图）。
- 多套可切换视觉主题（一套研究默认 + arg 覆盖足矣）。

## 8. 风险与开放问题
- **图里数字造假**：最大风险——漂亮模版易诱导编造 latency/维度/结果。靠 §3.2 溯源 + §3.3 内容门禁（逐个来源）+ `NUM-NEEDED` 兜底；宁缺不编。
- **依赖 METHOD_NOTES**：无 method-dig 产出时，部件/维度缺 → 门禁提示先跑 method-dig 或用户补，不臆造。
- **模版 arg 语法**：`{argument name=... default=...}` 是可覆盖占位；skill 填默认、用户可在排版门禁里改。
- **下游渲染不可控**：brief 只保证"结构正确、内容可追、样式合规"，最终像素由下游生成器/设计师负责。
