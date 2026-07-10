# Paper Skill 地基与规范（SP1）— 设计规格

## 0. 元信息

| 项 | 值 |
|----|----|
| 日期 | 2026-07-10 |
| 分支 | `paper-foundation-sp1` |
| 状态 | Draft（待用户过目 → writing-plans） |
| 范围 | 三子项目程序中的 **SP1：地基与规范（含重构）** |
| 语言约定 | 讨论中文；skill 正文、LaTeX、标识符、路径英文 |

---

## 1. 背景与目标

### 1.1 现状

`skills/paper/` 下已有三个 skill：

- **`paper`**（父）：加载时派 read-only 子代理扫用户研究仓库 → `PAPER_REPO_SURVEY.md`（每条 claim 带路径），再路由到子 skill。
- **`paper-structure`**：intake Q&A → `GUIDANCE.md`，下载官方 IEEE/venue LaTeX 包，确认架构，填骨架 `.tex`。
- **`paper-abstract`**：读 survey → 内容菜单 → HARD GATE 锁定 → 写 Abstract。

### 1.2 缺口

1. **正文是个洞**：能扫仓库 → 搭结构 → 写摘要，但**没有**任何 skill 起草 Introduction / Related Work / Method / Experiments / Conclusion 正文。skill 树自己写着「future `paper/intro`、`paper/method`…」和计划中的 `paper-draft`。
2. **description 违反 CSO**：`writing-skills` 明确要求 `description` 只说「何时用」，不能总结流程——否则 Claude 会照 description 行事、跳过 skill 正文。现有三个 description 都把完整流程塞进去了。
3. **token 超预算**：目标 <500 词/skill，`paper-structure/SKILL.md` ~570 **行**。
4. **文档漂移**：README「共 10 个 skill」但总表漏了 `paper-structure`；`paper-structure` 被误归到「科研与项目台账」类；`cs-paper-structure` 遗留命名；仓库结构树缩进错乱。

### 1.3 「完善 paperskill」的整体程序

用户要「都做」。分解为三个各自走 design→spec→plan→build 的子项目：

| # | 子项目 | 交付 |
|---|--------|------|
| **SP1** | **地基与规范（本 spec）** | `section-themes` + `paper-section` 引擎 + 存储框架 + 术语机制 + `paper-structure` 重构 + 4 个 description 改写 + `AUTHORING.md` + 文档修正 + 测试 |
| SP2 | 正文深潜内容 | 填满 `references/sections/` 剩 5 篇深潜文档；逐节加深 `paper-section` |
| SP3 | 一个新兄弟 skill | polish / rebuttal / 引文采集 / 图表 中挑一 |

**先做 SP1 的理由**：它定义了后续正文能力所依赖的模具（引擎 + 共享资产 + 存储契约 + 术语机制）。先做可避免 SP2 每节返工。

---

## 2. SP1 架构总览

### 2.1 关键决定（来自 brainstorm）

- **造一个可执行的通用元 skill `paper-section`**（而非被动模板文档或复制骨架）。它是「正文写作能力」本身，因此 **SP2 不再单造 5 个 per-section skill**，只在 SP2 填深潜内容、逐节加深。
- **写手三分**：`paper-structure`(骨架) → `paper-section`(正文各节) → `paper-abstract`(摘要，6-move 特例，保持独立)。
- **术语机制上移到 scanner 层**：术语在 Phase S 扫描时就扒出来、带路径落地成 `TERMS.md`，各节强制照用。

### 2.2 三条产品线

1. **新 skill**：`paper-section` 引擎 + 测试 fixture。
2. **共享参考资产**（父 skill 所有）：`storage-framework.md`、`section-themes.md`（速查索引）、`sections/`（深潜文档，SP1 只出模板 + 可选样板）。
3. **编辑现有**：4 个 description 改 CSO、`paper` 父 skill 同步新子、survey 模板/prompt 加术语、`paper-structure` 瘦身重构、`paper-abstract` 消费 TERMS/占位约定。

### 2.3 横切约定（本 spec 首次定死，所有节共用）

- **反造假占位约定**（cite / fig / table / ref）。
- **数字/术语单一真源**（数字追 survey `claim_id`；术语照 `TERMS.md`）。
- **草稿状态生命周期**（`% Status` 标记 + `STATE.md` 汇总）。
- **写入归属 / 防互踩**。

---

## 3. 组件清单（逐文件）

| # | 文件 | 动作 | 内容要点 | 消费者 |
|---|------|------|----------|--------|
| 1 | `skills/paper/section/SKILL.md` | 新增 | `paper-section` 引擎；menu→lock→write→report；载索引+按需载深潜；强制占位/TERMS/数字真源；刷 `% Status`+`STATE`；页限提示；写完自检 | — |
| 2 | `skills/paper/section/references/fixture/` | 新增 | 小假论文仓库，供 T1 基线测试（见 §5.1） | 测试 |
| 3 | `skills/paper/references/storage-framework.md` | 新增 | 存储框架：用户仓库侧+skill 侧两个空间、写入归属、状态生命周期、占位约定、TERMS/STATE 契约、legacy 迁移 | 全部 |
| 4 | `skills/paper/references/section-themes.md` | 新增 | 各节速查索引（Theme/Must-include/Must-not/Done-when + 典型长度/move 顺序）；Abstract 行指向 `abstract/references` | section, structure, abstract |
| 5 | `skills/paper/references/sections/_TEMPLATE.md` | 新增 | 每节深潜文档模板 | SP2 作者 |
| 6 | `skills/paper/references/sections/method.md` | 新增（可选） | 样板深潜，验证模板；SP1 可出，其余 5 篇 SP2 | paper-section |
| 7 | `skills/paper/references/subagent-survey-prompt.md` | 改 | 加「术语抽取」任务（方法/系统/数据集/指标/缩写 + 路径） | Phase S |
| 8 | `skills/paper/references/survey-template.md` | 改 | 加 Terminology 段（规范写法+展开+路径） | Phase S, TERMS |
| 9 | `skills/paper/SKILL.md` | 改 | description 改 CSO；Hierarchy/路由/Shared-artifacts 加 `paper-section`；Phase S 加术语；从 survey seed `TERMS.md`/`STATE.md`；链 `storage-framework` | — |
| 10 | `skills/paper/structure/SKILL.md` | 改 | 瘦身（删 Step3→链 section-themes；GUIDANCE 模板+投稿表+下载源→references/）；description 改 CSO；用占位约定 | — |
| 11 | `skills/paper/structure/references/guidance-template.md` | 新增 | 承接 #10 移出的 GUIDANCE 模板+投稿链接表 | paper-structure |
| 12 | `skills/paper/structure/references/template-sources.md` | 新增 | 承接 #10 移出的 IEEE/venue 下载源表+class 选项 | paper-structure |
| 13 | `skills/paper/abstract/SKILL.md` | 改 | description 改 CSO；消费 `TERMS.md`+占位约定（轻改，需回归测试 T2/T3） | — |
| 14 | `AUTHORING.md`（仓库根） | 新增 | skill 作者规范（见 §5.9） | 作者 |
| 15 | `README.md` | 改 | 总表加 `paper-structure`/`paper-section`；paper 家族归「论文」类；修数量、`cs-paper-structure` 遗留、仓库结构树缩进、推荐组合/许可行 | 人 |
| 16 | `SOURCES.md` | 改 | 记 `paper-section` 为自研 | 人 |
| 17 | `install.sh` | 查/改 | 确认递归拷 `references/` 嵌套子目录；不行则修 | — |

---

## 4. 关键机制详解

### 4.1 `paper-section` 数据流

1. **定位 ROOT**；读 `PAPER_REPO_SURVEY.md`（缺→回父 skill Phase S 扫）、`GUIDANCE.md`、`TERMS.md`、已确认骨架。
2. **选节**：扫骨架里 `% Status: [ ] not drafted` 列清单让用户挑；或用户直接点名（"写 method"）。
3. **载资产**：总载 `section-themes.md` 索引 + **仅按需**载 `references/sections/<节>.md` 深潜（缺失→优雅回退到索引）。
4. **内容菜单**：用该节 themes 生成**带 survey 路径引用**的可勾选菜单。
5. **HARD GATE**：`CONTENT_LOCK` 前不写 prose。
6. **写入**：只动对应 `.tex`；数字标 `% src: <claim_id> (path)`；引用/图表用占位约定；术语照 `TERMS.md`；刷 `% Status` → `[x] drafted`；刷 `STATE.md`。
7. **自检 + 报告**：跑该节 Done-when + "全部数字可追" 自查；报告写了哪节、引哪些 claim_id、改哪些文件、页限是否超。

### 4.2 术语机制（端到端）

- **扫取（Phase S，父）**：survey 子代理扫描时顺带扒出规范术语——方法名/系统名/数据集名/指标名/关键缩写，每个带 `source_path`。写进 `subagent-survey-prompt.md`（任务）与 `survey-template.md`（Terminology 段）。
- **落地（父）**：从 survey 术语段生成 `<ROOT>/paper/TERMS.md`，每条 `规范写法 | 展开 | source_path | 状态`。
- **状态取值**：`from-repo(path)`（仓库里扫到）/ `user-confirmed`（问过用户）/ `needs-user`（仓库没有或含糊，**先问再用，绝不自造**）。
- **强制（section + abstract）**：各节读 `TERMS.md`，规范写法逐字照用；需表外术语 → 停下问用户，不编。

### 4.3 存储框架（`storage-framework.md`）

两个存储空间讲清：

**① 用户仓库侧** `<ROOT>/paper/`：

| 产物 | owner | consumer | 命名/生命周期 |
|------|-------|----------|----------------|
| `PAPER_REPO_SURVEY.md` | paper（父） | 全部 | Phase S 生成；stale 时重扫 |
| `TERMS.md` | paper（父 seed） | section, abstract | Phase S 后生成；`needs-user` 项补齐 |
| `STATE.md` | 各 skill 收尾刷 | paper 路由 | 项目级进度汇总 |
| `GUIDANCE.md` | paper-structure/paper | 全部 | intake 后建，逐问更新 |
| `vendor/` | paper-structure | — | 官方包，尽量不改 |
| `main.tex` 前导/frontmatter | paper-structure | — | 骨架期建 |
| `sections/*.tex` 正文 | paper-section | — | 起草期写；`% Status` 真源 |
| abstract 正文 | paper-abstract | — | 锁定后写 |
| `refs.bib` | 无人伪造 | SP3 引文 skill | section 只加 `\cite{TODO:...}` |

**② skill 包侧** `skills/paper/references/`：`storage-framework.md`、`section-themes.md`、`sections/*.md`（深潜）、`subagent-survey-prompt.md`、`survey-template.md`。

**写入归属/防互踩规则**：一个 skill 只改自己 owned 的文件/区块；共享文件用 append 或 section-scoped edit；绝不 blind-overwrite；两个 skill 不改同一块。

**Legacy 迁移**：`ABSTRACT_REPO_SURVEY.md`（旧名）→ 读它但优先重命名/复制为 `PAPER_REPO_SURVEY.md`。

### 4.4 反造假占位约定

| 类型 | 约定 | 禁止 |
|------|------|------|
| 引用 | `\cite{TODO:AuthorYear-topic}` + 行内 `% CITE-NEEDED: <该 claim 需要来源>` | 编造看似真实的 cite key |
| 图 | `\ref{fig:TODO-<slug>}` + `% FIG-NEEDED: <描述>` | 伪造图文件/数据 |
| 表 | `\ref{tab:TODO-<slug>}` + `% TAB-NEEDED: <描述>` | 伪造表数值 |
| 交叉引用 | 每节 `\label{sec:<slug>}`；引用用 `\ref`/`\Cref{sec:<slug>}` | slug 各节自造（登记在 storage-framework/STRUCTURE） |
| 数字 | 行内 `% src: <claim_id> (path)`；无 claim_id 支撑 → 不写，标 `% NUM-NEEDED` | 编造/凑整任何指标 |

### 4.5 状态生命周期

`% Status: [ ] not drafted`（structure 写）→ `[~] drafting` → `[x] drafted` → 可选 `[!] needs-rework`。paper-section 写入时切换。`STATE.md` 是**项目级汇总**（哪些节已写、abstract 状态、是否到 polish），由各 skill 收尾刷新；`% Status` 是**每节 in-file 真源**。

### 4.6 CSO description 改写（before → after）

| skill | after（只说何时用，无流程） |
|-------|------------------------------|
| `paper` | `Use when the user works on a CS research paper (写论文, 顶会/顶刊 投稿), needs their research repo turned into paper material, or any paper section task needs shared research context. Parent of paper-structure, paper-section, paper-abstract.` |
| `paper-structure` | `Use when scaffolding a CS paper's LaTeX project — 论文结构, 搭骨架, 下载模板, LaTeX/Overleaf, 先定架构, IEEE/venue 模板, 确认章节架构. Not for section prose (paper-section) or the abstract (paper-abstract).` |
| `paper-abstract` | `Use when writing or revising a paper's Abstract — 写摘要, abstract, 改摘要. Requires the parent paper survey first.` |
| `paper-section` | `Use when drafting or revising a body section of a CS paper — 写正文, 写 intro/related work/method/experiments/limitations/conclusion 某一节. Not for the abstract (paper-abstract) or scaffolding (paper-structure).` |

### 4.7 `paper-structure` 重构映射

- **删** Step 3「Section theme catalog」→ 改为链接 `../references/section-themes.md`（catalog 内容迁入并被三方共用）。
- **移** GUIDANCE.md 大模板 + §1b 投稿链接表 → `structure/references/guidance-template.md`。
- **移** Step 1 IEEE/venue 下载源表 + class 选项 → `structure/references/template-sources.md`。
- **留** SKILL.md：intake Q1–Q5 精简流程、hard rules、step 大纲、references 链接。目标核心 <500 词。

### 4.8 `AUTHORING.md` 内容（仓库根）

- description = 只说何时用（CSO），第三人称，"Use when…"，不塞流程。
- token 预算 <500 词/skill；重引用进 `references/`。
- 跨引用用 skill 名 + `REQUIRED SUB-SKILL/BACKGROUND` 标记；**不用 `@` 强加载**。
- 所有 paper skill 一律在 `skills/paper/`。
- 每条数字/术语 claim 带 source path。
- 反造假占位约定摘要（指向 storage-framework 详版）。
- **铁律**：新增/编辑任何 skill → 先跑 subagent 基线测试（RED→GREEN→REFACTOR）。

### 4.9 README/SOURCES/install 修正

- README：总表补 `paper-structure`+`paper-section`；paper 家族独立「论文」分类；重算「共 N 个 skill」；删 `cs-paper-structure（原）` 遗留；修仓库结构 ASCII 树缩进；更新推荐组合/许可行。
- SOURCES.md：`paper-section` 记为自研。
- install.sh：确认 `cp -R skills/*` 递归带上新 `references/` 嵌套；必要时修。

---

## 5. 测试计划（writing-skills 铁律，分级）

### 5.1 T1 — 完整 RED→GREEN→REFACTOR：`paper-section`

- **fixture**：`skills/paper/section/references/fixture/` = 最小假仓库：`README.md`（方向）、`results/REPORT.md`（含 2~3 个带指标数字）、`paper/PAPER_REPO_SURVEY.md`（预填）、`paper/GUIDANCE.md`（venue=IEEE 默认 + 页限）、`paper/TERMS.md`、`paper/main.tex`+`sections/*.tex`（带 `% Status`）。**提交**（测试脚手架）。
- **RED**：无 skill 时让子代理"写 Method/Experiments 节"，记录它是否编数字/跳 survey/跳用户锁定/自造术语——记原话。
- **GREEN**：有 skill 时应：读 survey、数字带 `% src`、遇 HARD GATE 停、术语照 TERMS、占位不伪造。
- **REFACTOR**：堵新借口（如"随手写个合理 Method"）到稳固。

### 5.2 T2 — 行为点测：4 个改写的 description

验证：① 对的请求能触发对的 skill；② 触发后**去读正文而非照 description 行事**（正是 CSO 要防的坑）。需先快照当前（坏）description 行为作 RED。

### 5.3 T3 — 检索走查

`storage-framework.md` / `section-themes.md` / `_TEMPLATE.md` / TERMS·STATE 流程能被正确取用；`paper-structure` 拆分后端到端仍能走通（找到 guidance 模板、下载源）。

### 5.4 T4 — 免测

README/SOURCES 纯文档（机械改动，不涉 skill 行为）。

---

## 6. 实施分阶段

体量大，实施计划分两阶段（降风险）：

- **SP1a（低风险先落）**：`section-themes.md`、`storage-framework.md`、`sections/_TEMPLATE.md`、survey 模板/prompt 加术语、`paper-structure` 瘦身重构、4 个 description 改写、`AUTHORING.md`、README/SOURCES/install。测试 T2/T3/T4。
- **SP1b（行为关键）**：`paper-section` 引擎 + fixture + `method.md` 样板 + 父 skill 同步 + `paper-abstract` 消费 TERMS/占位。测试 T1（完整 RED-GREEN-REFACTOR）+ abstract 回归。

---

## 7. 最终文件树

```
ccskills/
├── AUTHORING.md                          # 新增
├── README.md                             # 修
├── SOURCES.md                            # 修
├── install.sh                            # 查/修
├── docs/superpowers/specs/2026-07-10-paper-foundation-design.md   # 本 spec
└── skills/paper/
    ├── SKILL.md                          # 改 description + 加子 + 术语 + seed TERMS/STATE + 链 storage-framework
    ├── references/
    │   ├── storage-framework.md          # 新增 ★存储框架
    │   ├── section-themes.md             # 新增：速查索引
    │   ├── sections/
    │   │   ├── _TEMPLATE.md              # 新增：深潜模板
    │   │   └── method.md                 # 可选样板（SP1）；其余5篇→SP2
    │   ├── subagent-survey-prompt.md     # 改：加术语抽取
    │   └── survey-template.md            # 改：加 Terminology 段
    ├── section/
    │   ├── SKILL.md                      # 新增 paper-section 引擎
    │   └── references/fixture/           # 新增：测试假仓库
    ├── structure/
    │   ├── SKILL.md                      # 瘦身 + 改 description
    │   └── references/
    │       ├── guidance-template.md      # 新增
    │       └── template-sources.md       # 新增
    └── abstract/SKILL.md                 # 改 description + 消费 TERMS/占位
```

---

## 8. 成功标准（Done-when）

1. `paper-section` 能对 fixture 的 Method/Experiments 走完 menu→lock→write，**零编造数字**、数字带 `% src`、术语照 TERMS、占位不伪造，T1 通过。
2. 4 个 description 均为 CSO 风格（"Use when…"、无流程），T2 通过。
3. `paper-structure/SKILL.md` 核心降到 <500 词量级，重内容进 references/，拆后 T3 通过。
4. `section-themes.md`、`storage-framework.md`、`_TEMPLATE.md`、`TERMS.md`/`STATE.md` 契约齐备且可被引擎取用。
5. Phase S 扫描产出含术语段（带路径）；`TERMS.md` 能从 survey seed；`needs-user` 项走「问用户」而非自造。
6. README/SOURCES/install/父 skill 与新结构一致，无漂移。
7. 每个新增/编辑 skill 都有对应测试记录（除 T4 免测项）。

---

## 9. 范围之外（YAGNI，明确不在 SP1）

- **真正的引文采集**（查 bib、填真 `\cite`）→ SP3 独立 skill；SP1 只定占位约定。
- **图表生成** → 不做，只留占位。
- **description lint 脚本** → `AUTHORING.md` 写清规则即可，不写工具。
- **SP2 的 5 篇深潜文档正文** → SP2。

---

## 10. 风险与开放问题

- **SP1 体量偏大**：靠 §6 分阶段 + 每步测试控制；SP1a 可独立先合。
- **`paper-abstract` 轻改需回归**：改 description + 接 TERMS 属编辑，按铁律要回归测试，勿静默改。
- **STATE.md 与 `% Status` 潜在重叠**：已界定 STATE=汇总、`% Status`=每节真源；实现时保持单向刷新避免不一致。
- **fixture 真实度**：太假测不出编造倾向，太全增维护；取"含真实指标数字 + 一处 needs-user 术语"的最小集。
