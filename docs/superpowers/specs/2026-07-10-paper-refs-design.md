# paper-refs — Related-Work Collection Skill (SP3) — Design Spec

## 0. 元信息

| 项 | 值 |
|----|----|
| 日期 | 2026-07-10 |
| 分支 | `paper-refs` |
| 状态 | Draft（待用户过目 → writing-plans） |
| 范围 | SP3 第一块：相关工作**采集 / 核实 / 入选**（写作后续单独 spec） |
| 语言 | 讨论中文；skill 正文英文为主，中文注释；产物表头可中英混排 |

---

## 1. 背景与目标

### 1.1 现状
`paper` 家族已能：扫仓库 → 搭 LaTeX 骨架 → 写正文各节 → 写摘要，全程反造假。正文里所有引用都是 `\cite{TODO:...}` + `% CITE-NEEDED` 占位——**没有一个真实文献来源**。补真引用目前全靠人工。

### 1.2 目标
新增 `paper-refs`：**围绕仓库的研究方向，用多 agent 搜集 ≥80 条最新、顶会顶刊/业界流行的相关工作，逐条核实真实性/正确性，分类落文件，再选出 ~20+ 条形成表格交用户拍板**。

**只做采集**，不写相关工作正文（写作阶段后续再定）。选定的引用集合是后续写作/`refs.bib` 的输入，本 spec 不落 `refs.bib`。

### 1.3 与家族的关系
- 消费父 `paper` 的 `PAPER_REPO_SURVEY.md` / `TERMS.md` / `paper_type`（不自己扫全库）。
- 沿用家族纪律：**每条带来源（此处为可解析链接）**、**用户决定引用谁（HARD GATE）**、**不编造**、不擅自 git push、中文交流。
- 区别于 `skills/paper/references/sections/related-work.md`（那是正文**写作指南**，给 `paper-section` 用）；本 skill 是**文献采集引擎**。

---

## 2. 架构总览

### 2.1 已定架构选择（来自 brainstorm）
- **种子 = 仓库研究方向**：从 `PAPER_REPO_SURVEY.md`（方向/方法/结果）+ `TERMS.md` + `paper_type` 取种子，非随机、非纯用户输入。
- **自建引文专用多 agent 搜索**：skill 直接编排 `WebSearch`/`WebFetch` subagent，针对论文元数据 + venue + 时间定制（不套 `deep-research`）。
- **最严核实**：逐条 `WebFetch` 抓取核对元数据与 claim；不可核实者丢弃。

### 2.2 八步流水线
```
1 种子     ← PAPER_REPO_SURVEY.md（direction/method/results）+ TERMS.md + paper_type
2 定策略   ← paper_type → 收集角度（§4.1），与用户确认类型
3 扇出搜索 ← K 个 citation 搜索 subagent，按角度/venue/时间分工，过量收集（raw 目标 ≥100）
4 去重归一 ← 同一文献多链接合并；元数据规整（title/authors/year/venue/link）
5 严格核实 ← 逐条抓链接核对（§4.3）；不可核实/不符 → drop + 记原因
6 分类     ← 按 §4.1 角度给每条打簇标签
7 落池     ← paper/REFS_POOL.md（≥80 条已核实，带链接+内容+分类+核实状态）
8 入选门禁 ← 选 ~20–25 → REFS_SHORTLIST.md 表格 → 用户勾选 → USER_SELECTION 锁定
```

---

## 3. 组件清单

| # | 文件 | 动作 | 说明 |
|---|------|------|------|
| 1 | `skills/paper/refs/SKILL.md` | 新增 | 引擎：8 步流水线；CSO description；链接下列 references + storage-framework |
| 2 | `skills/paper/refs/references/type-strategies.md` | 新增 | `paper_type` → 收集角度映射（§4.1，三类） |
| 3 | `skills/paper/refs/references/search-agent-prompt.md` | 新增 | 搜索 subagent 模板 + 返回 schema（§4.2） |
| 4 | `skills/paper/refs/references/verify-agent-prompt.md` | 新增 | 核实 subagent 模板 + 丢弃判据（§4.3） |
| 5 | `skills/paper/refs/references/pool-and-shortlist-schema.md` | 新增 | `REFS_POOL.md` 与 `REFS_SHORTLIST.md` 格式（§4.4/§4.5） |
| 6 | `skills/paper/references/storage-framework.md` | 改 | 加 `REFS_POOL.md` / `REFS_SHORTLIST.md` 产物契约 |
| 7 | `skills/paper/SKILL.md` | 改 | Hierarchy/路由加 `paper-refs`（"找相关工作/引文" → paper-refs） |
| 8 | `README.md` / `SOURCES.md` | 改 | 一览表 + 数量（→ 12 skill）+ 自研记名 |

---

## 4. 关键机制

### 4.1 文章类型 → 收集策略（用户核心要求）
读 survey `paper_type`，映射并**与用户确认类型**后按类型收集：

| 类型（paper_type） | 收集角度 |
|--------------------|----------|
| **成果/方法型**（method / system / empirical / efficiency） | **A. 方向与来源（lineage）**：我方法/方向建立在哪些前人论文/信息上；**B. 已有成果的相关能力 + 优缺点**：解决同问题的现有工作及其优缺点（供对照/基线） |
| **说明/解释型**（explanatory / diagnosis / survey） | 现有解释/说明的**缺陷与特点**（现有账户如何解释、短板在哪、区别特征） |
| **理论型**（theory） | **A. 新理论的基础信息**（所依赖的基础结果/工具）；**B. 以前的成果**（该方向既有结果） |

类型不清或 `mixed` → 向用户提问确认，不默默选。

### 4.2 多 agent 扇出搜索
- **分工**：按（角度 × venue 档 × 时间窗 × 关键词簇）切成 K 个 facet，每 facet 一个搜索 subagent；过量收集（raw 目标 ≥100，留核实损耗余量）。
- **搜索 subagent 返回 schema（每条）**：
  `title | authors | year | venue | link(arXiv/DOI/官方/GitHub) | 详细内容摘要 | why-relevant | angle(§4.1簇)`
- **新近 + 高质约束**：搜索侧优先近 N 年（默认近 3–5 年，经典奠基作例外）+ 顶会/顶刊/知名机构；低质/过旧交由核实侧降级。
- **模板**在 `search-agent-prompt.md`；主 skill 只描述分工与聚合。

### 4.3 严格核实（反造假核心）
- 每条候选交核实 subagent（可批处理，~10 条/批）：实际 `WebFetch` 链接 → 核对：
  1. 链接可解析、文献**真实存在**；
  2. **title + authors + year + venue** 与候选记录一致；
  3. **venue 档次/年份**达标（顶会顶刊/业界流行；过旧或不可考 → 降级或剔除）；
  4. **claim 与原文相符**（why-relevant/内容摘要不夸大、不张冠李戴）。
- 任一不符 → `dropped: <原因>`，进 quarantine 表，不进池。
- **数量纪律**：核实后 verified < 80 → 继续追加搜索（记录已搜 facet 与丢弃数）；**不静默截断**，最终在池头写 `collected→verified→dropped` 计数。

### 4.4 分类 + 池文件 `REFS_POOL.md`
写到 `<ROOT>/paper/REFS_POOL.md`：
```markdown
# REFS_POOL — <direction>
- seeded_from: paper/PAPER_REPO_SURVEY.md ; paper_type: <type>
- counts: collected <raw> → verified <M≥80> → dropped <K>
## Angle A: <lineage / existing-explanations / theory-foundations>
| id | title | authors | year | venue | tier | link | 内容摘要 | why-relevant | verify |
|----|-------|---------|------|-------|------|------|----------|--------------|--------|
| P01 | … | … | 2025 | NeurIPS | top | https://… | … | … | verified(fetched) |
## Angle B: <competing-capabilities / prior-results>  (按类型出现)
…
## Dropped / quarantine
| claimed title | link | reason |
```

### 4.5 入选 + 用户门禁 `REFS_SHORTLIST.md`
从池选 ~20–25 条（覆盖各角度 + 新近 + 高相关 + venue 高），写表交用户：
```markdown
# REFS_SHORTLIST (propose → user decides)
- from: paper/REFS_POOL.md (verified M)
| id | title | venue/year | angle | why cite | link | 建议 | 用户决定 |
|----|-------|-----------|-------|----------|------|------|----------|
| P01 | … | NeurIPS'25 | lineage | 直接前驱 | https://… | 推荐 |  |
## USER_SELECTION  (锁定于用户确认后)
- Included: …
- Excluded: …
- Status: CONFIRMED
```
**HARD GATE**：用户 `CONFIRMED` 前，不把任何一条当"已选定"；skill 不擅自决定引用集合。选定集合是后续写作/`refs.bib` 输入（本 spec 不落 bib）。

### 4.6 集成
- `storage-framework.md`：新增 `REFS_POOL.md`（owner paper-refs）/`REFS_SHORTLIST.md`（owner paper-refs；USER_SELECTION 锁定）行 + 说明它是 `\cite{TODO:...}` 占位后续的真源。
- 父 `paper/SKILL.md`：Hierarchy 加 `refs/`；S.3 路由加一行 `找相关工作 / 引文 / related work 检索 → paper-refs`。
- README（→ 共 12 skill、paper-refs 进"论文"类）、SOURCES（自研）。

---

## 5. 测试计划（writing-skills 铁律）
- **RED（隔离，无 skill）**：给一个真实研究方向让 agent"找相关工作"→ 预期失败：**编造/半编造 cite（不核实链接）**、无类型策略、不分角度、不给用户拍板、数量随意。记录。
- **GREEN（有 skill）**：→ 类型驱动收集、逐条 `WebFetch` 核实（不可核实剔除并记原因）、分角度落池 ≥80、shortlist 表交用户门禁、零编造。
- **实测夹具**：用一个公开、易核实的方向（如 "KV-cache quantization for LLM inference"）跑一次小规模（可将 ≥80 调小做冒烟，但保留"逐条核实 + 门禁 + 不编造"的判据），记 `notes-paper-refs-GREEN.md`。
- **注意**：这是**联网** skill，测试点在**流程纪律**（核实/门禁/不编造/分类）而非具体命中哪几篇。

---

## 6. 最终文件树
```
skills/paper/
├── SKILL.md                       # 改：加 paper-refs 路由/Hierarchy
├── references/storage-framework.md # 改：加 REFS_POOL/REFS_SHORTLIST 契约
└── refs/                          # 新增 paper-refs
    ├── SKILL.md
    └── references/
        ├── type-strategies.md
        ├── search-agent-prompt.md
        ├── verify-agent-prompt.md
        └── pool-and-shortlist-schema.md
README.md / SOURCES.md             # 改
docs/superpowers/specs/2026-07-10-paper-refs-design.md  # 本 spec
```

---

## 7. 成功标准（Done-when）
1. `paper-refs` 能从 survey 取方向 + 判类型（并确认）→ 按 §4.1 角度收集。
2. 多 agent 扇出，**核实后 ≥80 条**入池，每条带可解析链接 + 内容 + 角度 + 核实状态；`collected→verified→dropped` 计数如实。
3. 逐条链接**实际抓取核对**（元数据 + claim）；不可核实的进 quarantine 记原因，**不入池**。
4. shortlist ~20+ 表格交用户，`USER_SELECTION` 门禁后才算选定。
5. RED→GREEN 表明：无 skill 会编造/不核实，有 skill 类型驱动 + 逐条核实 + 门禁 + 零编造。
6. storage-framework / 父 skill / README / SOURCES 同步。

---

## 8. 范围之外（YAGNI）
- **不写相关工作正文**（后续写作 spec）。
- **不落 `refs.bib` / 不生成真 `\cite` key**（选定集合是其输入，转换后续做）。
- 不做全文 PDF 精读/自动摘要抽取超出 verify 所需（verify 只需核对元数据 + claim 相符）。
- 不做 citation graph 可视化。

---

## 9. 风险与开放问题
- **联网体量**：≥80 条逐条抓取 = 100+ 次 fetch，慢且贵；靠批处理核实 + 过量但有上限的搜索控制；冒烟测试可调小数量。
- **venue "顶会顶刊/业界流行" 判定**：需要一份档次判据（核实侧用），列进 `verify-agent-prompt.md`（可维护白名单 + 启发式）。
- **"最新"与"奠基作"张力**：近年优先，但方向来源常是老经典——`type-strategies.md` 明确 lineage/foundations 角度允许经典老文，其余角度偏新近。
- **去重**：arXiv vs 会议正式版同一文献——按标题+作者归一，保留 venue 正式版链接优先。
