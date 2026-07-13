# Table Style (SP6) — Design Spec

## 0. 元信息

| 项 | 值 |
|----|----|
| 日期 | 2026-07-13 |
| 分支 | `paper-table-style` |
| 状态 | Draft（待用户过目 → writing-plans） |
| 范围 | 共享表格排版规范：结构基座 + 富化工具箱 + 每表富化门禁 + 护栏 |
| 形态 | **新建共享参考** `references/table-style.md`，被 experiments / related-work / method 的表共用 |

## 1. 背景与目标

### 1.1 现状
家族里会出表的地方：Experiments 主结果表、related-work 可选对比表、method notation 表。目前**没有统一表格排版规范**——每处各写各的，排版易翻车（竖线、`\hline`、标头旋转、颜色乱用、caption 位置随意），也没有"如何把表做丰富但 reviewer-safe"的指导。

### 1.2 目标
建一份**共享表格规范** `table-style.md`：把顶会实证得来的**结构铁律** + 用户要的**富化工具箱**（颜色/字体色/箭头/小字涨幅/多层高亮）统一起来，并以**每表自适应门禁**（skill 判断哪些富化适合这张表 → 提议 → 用户确认 → 应用）落地，配一套**护栏**保证"富而不翻车"（非 color-only、灰度/色盲安全、必给图例、delta 真算可追）。

### 1.3 证据基础
研究了 6 篇 venue-verified 顶会表格（vLLM SOSP'23 / QLoRA NeurIPS'23 / Depth Anything CVPR'24 / Self-RAG ICLR'24 / DPO NeurIPS'23 / Self-Instruct ACL'23，LaTeX 源码级），结构规则与富化手法均据此。见 §2.1/§2.4 的 prevalence 标注。

## 2. 核心机制

### 2.1 结构基座（near-universal，定为 MUST）
- **booktabs 三线**：`\toprule`/`\midrule`/`\bottomrule`；**绝不 `\hline`**（6/6）。
- **无竖线**（主结果表 0/6 有）；干净列格 `@{}l...@{}`。
- **标头横排**（`rotatebox`/`sidewaystable` 0/6）；旋转仅"极多窄数字列排行榜"最后手段。
- **方法/标签列靠左、数字列右对齐、同列小数位一致**（左首列 6/6）。
- **表注/符号键(`*` `–`)/指标缩写全进 caption**（threeparttable 0/6）。
- `Table~\ref{}`（波浪号）；`[t]` 顶部浮动；宽表 `table*`（跨栏）或 `\resizebox`/`\small`+缩 `\tabcolsep`。

### 2.2 Caption 位置（随 venue 模板 — 用户定）
证据非普适（4/6 在下、2/6 在上，两篇 NeurIPS 互相矛盾）。→ **读 `GUIDANCE.md` §6 / vendor 模板的惯例自适应**（IEEE 系表题在上；很多 CVPR/ACL 在下）；模板未定则默认表题在上并标注。

### 2.3 不确定度（有 multi-seed 就 ±std — 用户定，比惯例严）
- survey 里有多 seed 数据 → 写 `value ± std`（`% src: <claim_id>`）；不掩盖方差。
- 无多 seed → 点估计；headline 主张可给 `± CI`。
- 数字**只来自 survey claim_id / ref 已核实内容**，缺 → `% NUM-NEEDED`，不编。

### 2.4 富化工具箱（用户"一定要有"）
供 skill 按表选用（非全表套全套，见 §2.5）：
- **颜色辅助**：单元格底色 / 某指标列 heatmap 渐变，高亮我方或最优（顶会 Depth Anything 用过）。
- **字体颜色**：绿=涨 / 红=跌(regression) / 蓝=我方。
- **箭头**：`↑↓` 指标方向（混高低更好时）；`▲▼` 相对 baseline 的涨跌方向。
- **小字涨幅**：值旁小字/上标标 delta，如 `85.2`+小绿字`(+3.1)`。
- **多层高亮**：粗体/下划线/斜体 = 最优/次优/第三（bold=best 6/6）。
- **数字修饰**：K/M 后缀、千分位。

### 2.5 每表富化门禁（用户细化 — 核心交互）
**不给每张表套全套富化**。对**每一张表**：
1. skill 按**表的类型/内容**判断哪些富化合适——例：有 baseline 的对比表 → 我方色 + 方向箭头 + 小字 delta + 粗体最优；notation 表 → 基本不富化；密集指标网格 → 可 heatmap。
2. **提议**给用户：`本表建议富化：[X, Y, Z]（各一句理由）`。
3. 用户 **加/减/确认** → 才应用。（`TABLE_ENRICH_LOCK` 门禁，同家族 menu→lock 纪律。）
4. 用户答"都不要" → 退化为纯结构基座（干净 booktabs 表）。

### 2.6 护栏（让"富"不被 reviewer 扣分 — 源自证据）
- **绝不"仅靠颜色/箭头"编码** → 颜色/箭头必配数字或符号（**灰度打印仍可辨、色盲安全**调色板；避免红绿唯一区分）。
- 用了 颜色/箭头/多层高亮/delta → **caption 必给图例**（"bold=best, ↑ higher better, green=gain over baseline …"）。
- **小字涨幅/delta 必须真算**：我方数 `% src: claim_id`、基线数来自 ref 已核实 → 算出 delta，**不编造、不夸大**；涨跌颜色/箭头方向与指标方向一致（越低越好的指标"降了"是绿）。
- **LaTeX 宏包**：用到的（`booktabs, xcolor, colortbl, multirow, amssymb/以及 \textcolor,\cellcolor` 等）须在 `GUIDANCE.md`/preamble 声明；缺 → 标 `% PKG-NEEDED: <pkg>`，不静默假设。
- 富化**适度**：默认"干净富化"一套即可，别堆到花哨（宁少勿乱）。

## 3. 组件清单

| # | 文件 | 动作 | 说明 |
|---|------|------|------|
| 1 | `skills/paper/references/table-style.md` | 新增 | 结构基座 + caption + ±std + 富化工具箱 + 每表门禁 + 护栏 + 宏包 + 证据来源 |
| 2 | `skills/paper/references/sections/experiments.md` | 改 | 主结果表遵循 table-style（链接）；表 = 富化门禁 |
| 3 | `skills/paper/references/sections/related-work.md` | 改 | 可选对比表改为遵循 table-style（现有对比表小节链过去，富化走门禁） |
| 4 | `skills/paper/references/sections/method.md` | 改 | notation 表遵循 table-style（结构基座即可，通常不富化） |
| 5 | `skills/paper/section/SKILL.md` | 改 | 出任何表时：遵循 `../references/table-style.md`，跑每表富化门禁 |
| 6 | `skills/paper/references/storage-framework.md` | 改 | 记 LaTeX 宏包声明约定（table 富化所需）+ `% PKG-NEEDED` |

## 4. 测试计划（writing-skills 铁律）
- **RED（隔离，无规范）**：给 fixture（survey 有多 seed 结果 + baseline）让 agent"做一张结果对比表"→ 预期：竖线/`\hline`、可能旋转标头、颜色/箭头乱用无图例或 color-only、delta 瞎标或不标、caption 位置随意、无 ±std、宏包不声明。
- **GREEN（有规范）**：→ booktabs 无竖线横排、caption 随模板、有多 seed 给 ±std（追 claim_id）、**每表富化门禁**（提议合适子集 → 模拟用户确认）、富化非 color-only 且带 caption 图例、**delta 真算可追不编**、宏包 `% PKG-NEEDED` 或已声明。
- **fixture 扩充**：给 `results/REPORT.md` 加多 seed（mean±std）+ 一个 baseline 数，让 delta/±std 有真数可算。
- REFACTOR：按暴露的漏洞堵。

## 5. 成功标准（Done-when）
1. `table-style.md` 覆盖：结构基座(MUST) + caption 随模板 + ±std(multi-seed) + 富化工具箱 + **每表门禁** + 护栏 + 宏包。
2. experiments/related-work/method/paper-section 均链接并遵循它。
3. GREEN：booktabs 横排无竖线；富化经**门禁**（提议→用户定）、**非 color-only、带图例、灰度/色盲安全**；**delta/±std 真算可追、不编**；caption 随模板；宏包声明或 `% PKG-NEEDED`。
4. RED 反面成立；storage-framework/fixture 一致。

## 6. 范围之外（YAGNI）
- 真渲染/编译表格或跑 latexmk（只产 LaTeX + 约定）。
- 自动生成配色（给一套色盲安全默认调色板即可，不做算法配色）。
- 图（figure）的排版规范（本次只做 table；figure 另说）。
- 把富化做成一堆可切换主题（默认"干净富化"一套 + 门禁增减足矣）。

## 7. 风险与开放问题
- **"富"与"reviewer-safe"张力**：护栏（非 color-only/灰度安全/图例/适度）是关键；宁可克制。
- **门禁判断的主观性**：skill 提议、**用户最终定**；提议错了用户可推翻。
- **宏包依赖**：富化用色/箭头需宏包，靠 `% PKG-NEEDED` + GUIDANCE 声明兜底，不静默假设 preamble。
- **delta 方向易错**：越低越好的指标（PPL/latency）"下降=改进=绿/↑improvement"——规则须显式说明方向语义，避免把"数值降了"误标成红。
