# Related-Work Writing (SP4) — Design Spec

## 0. 元信息

| 项 | 值 |
|----|----|
| 日期 | 2026-07-10 |
| 分支 | `paper-relwork-write` |
| 状态 | Draft（待用户过目 → writing-plans） |
| 范围 | 把 `paper-refs` 选定的引用写成 Related Work 正文（两部分结构 + 真 `\cite` + `refs.bib`） |
| 形态 | **增强**（不新增 skill）：增强 `paper-section` 写 related-work 节这条路径 + `sections/related-work.md` 深潜文档 |

## 1. 背景与目标

### 1.1 现状
`paper-refs` 产出 `REFS_SHORTLIST.md` 的 `USER_SELECTION`（用户选定、已核实、按 `lineage`/`competing` 等角度标记的引用）。但目前把这些写成 Related Work 正文仍靠人工；`paper-section` 写任何节都只发 `\cite{TODO:...}` 占位、不落真引用。

### 1.2 目标
增强 related-work 节的写作，使其：**按两部分结构（对应 paper-refs 的两个收集角度）**、**只引用 `USER_SELECTION` 里选定的 refs**、产出正文 prose + **真 `\cite{key}`** + 生成/追加 **`refs.bib`**，**引用格式随 venue 下载模板**（`GUIDANCE.md`/`.bst`）。写作前先给两部分大纲让用户确认（menu→lock）。写法参照 build 时烘焙的真实顶会顶刊 examples（只学结构不抄句）。

### 1.3 与家族关系
- 消费 `paper-refs` 的 `REFS_SHORTLIST.md`（缺 → 先跑 `paper-refs`）。
- related-work 是 `paper-section` 负责的一个正文节 → 本设计增强该节的处理，**不新增独立 skill**。
- 沿用家族：只用选定/已核实素材、用户门禁、不编造、中文交流、English LaTeX。

## 2. 架构总览

### 2.1 两部分结构 ↔ 角度映射
**每个收集角度 → 一个写作部分**：
| paper_type | 写作部分（对应 paper-refs 角度） |
|------------|-----------------------------------|
| 成果/方法型 | **Part 1 背景与来源** ← `lineage`；**Part 2 相关能力与对比** ← `competing` |
| 理论型 | Part 1 ← `foundation`；Part 2 ← `prior-result` |
| 说明/解释型 | 单部分 ← `existing-explanation` |

- Part 1（lineage/foundation）：我方向/方法**建立在什么之上**（谱系/基础）。
- Part 2（competing/prior-result）：**已有成果的能力 + 优缺点**，并给出 **same/different-axis 定位**（我们与谁相同、与谁不同）。

### 2.2 examples（build 时烘焙，本次实现的一步）
现在去顶会顶刊找 **N 篇（目标 6–8）真实 related-work 段落**，分析其结构（尤其两段式/簇式：谱系段 + 对比段）、过渡句式、same/different 表达、引用密度，产出 `sections/related-work-examples.md`（**结构-teaching，绝不抄句**；像 `abstract/references/examples.md`）。`sections/related-work.md` 链接它。

### 2.3 数据流
```
REFS_SHORTLIST.md (USER_SELECTION, 角度标记) + GUIDANCE.md(bib 风格) + related-work.md/examples
        │
paper-section 写 related-work 节：
  1 读 USER_SELECTION（缺→跑 paper-refs）；按 paper_type 定部分（§2.1）
  2 menu：两部分各放哪些 ref + 大纲 → CONTENT_LOCK（HARD GATE）
  3 写 paper/sections/related-work.tex：每部分 prose，簇内 \cite{key}，same/different 定位
  4 为每个被引 ref 追加 refs.bib 条目（用 paper-refs 已核实元数据），风格随模板
  5 刷 % Status / STATE；自检报告（每个 \cite 都有 bib 条目、都在 USER_SELECTION 内）
```

## 3. 组件清单

| # | 文件 | 动作 | 说明 |
|---|------|------|------|
| 1 | `skills/paper/references/sections/related-work.md` | 改 | 加两部分结构、消费 `REFS_SHORTLIST`、真 `\cite`+`refs.bib`、链 examples、bib key 规则 |
| 2 | `skills/paper/references/sections/related-work-examples.md` | 新增 | build 时研究烘焙的顶会顶刊 related-work 结构范例（不抄句） |
| 3 | `skills/paper/section/SKILL.md` | 改 | related-work 节**特例**：读 `REFS_SHORTLIST`、按两部分、发真 `\cite` + 追加 `refs.bib`（其余节仍 `\cite{TODO:}`） |
| 4 | `skills/paper/references/storage-framework.md` | 改 | 加 `refs.bib` 契约（owner=related-work 写作；风格随模板）+ bib key 命名规则 |

## 4. 关键机制

### 4.1 输入：USER_SELECTION
读 `paper/REFS_SHORTLIST.md` 的 `USER_SELECTION`（`Status: CONFIRMED`）。每条选定 ref 已带 `title/authors/year/venue/link/angle`。
- 未选定 / 无 `REFS_SHORTLIST` / 未 `CONFIRMED` → 先跑 `paper-refs`（或提示用户去确认），**不擅自替用户选**。

### 4.2 真 `\cite` + `refs.bib`
- 每被引 ref 生成一条 **BibTeX 条目**写入 `paper/refs.bib`，字段（title/author/year/booktitle 或 journal/url/doi）来自 paper-refs 已核实元数据——**不新造、不编字段**；缺字段标 `% BIB-INCOMPLETE: <field>` 不臆填。
- 正文用 `\cite{key}` 引用；**每个 `\cite{key}` 必须在 refs.bib 有对应条目**（自检强制）。
- **bib key 命名规则**：`<firstauthorlastname><year><firstsignificantword>`，全小写、去符号（如 `vaswani2017attention`）；冲突加 `a/b`。
- **风格随 venue 模板**：读 `GUIDANCE.md` §6 / vendor 模板的 `\bibliographystyle`（IEEEtran→`IEEEtran`，ACM→`ACM-Reference-Format`，等）；确保 refs.bib 条目含该风格所需字段；在 `main.tex` 用模板要求的 bibstyle（不改模板既有 bibstyle 设定）。

### 4.3 两部分写作
- 按 §2.1 把 `USER_SELECTION` 的 refs 依 `angle` 分到各部分。
- 每部分：主题簇 → 簇内点名代表作（`\cite`）→ same/different-axis 定位（我们与之相同/不同）。参照 `related-work-examples.md` 的结构与过渡句式（不抄句）。
- Part 2 的优缺点/对比**只依据 ref 的已核实内容**，不夸大；**不堆我们自己的结果数字**（那属 Experiments）。

### 4.4 门禁 + 自检
- 写 prose 前给 `CONTENT_LOCK`：两部分各含哪些 ref id + 每部分大纲。用户确认后才写。
- 自检：每个 `\cite{key}` ∈ USER_SELECTION 且 refs.bib 有条目；无越界结果数字；bibstyle 与模板一致；`% Status`/`STATE` 刷新。

## 5. 测试计划（writing-skills 铁律）
- **RED（无增强）**：给一个含 `REFS_SHORTLIST`(USER_SELECTION 角度标记) + related-work 骨架的 fixture，让 agent 写 related-work → 预期：无两部分结构、不严格只引选定 refs、**编造 `\cite`/bib 或不落 bib**、bib 风格不随模板、可能无门禁。
- **GREEN（有增强）**：→ 两部分对应角度、只引 `USER_SELECTION`、真 `\cite`+每条对应 refs.bib（元数据不编、缺字段标记）、bibstyle 随模板、menu→lock 门禁、写法参照 examples。
- **fixture 扩充**：在 `test/fixtures/paper-section/` 加 `paper/REFS_SHORTLIST.md`（几条 lineage + 几条 competing 的 USER_SELECTION，带真实元数据）+ `paper/sections/related-work.tex` 骨架 + `GUIDANCE.md` 标 bibstyle=IEEEtran。

## 6. 最终文件树
```
skills/paper/
├── section/SKILL.md                                  # 改：related-work 特例
└── references/
    ├── storage-framework.md                          # 改：refs.bib 契约 + key 规则
    └── sections/
        ├── related-work.md                           # 改：两部分 + refs 消费 + 真 cite/bib
        └── related-work-examples.md                  # 新增（build 时烘焙）
test/fixtures/paper-section/paper/                     # 改：加 REFS_SHORTLIST + related-work.tex + bibstyle
docs/superpowers/specs/2026-07-10-paper-relwork-write-design.md  # 本 spec
```

## 7. 成功标准（Done-when）
1. related-work 节按 **两部分对应 paper-refs 角度** 写；说明型退化为单部分。
2. 只引 `USER_SELECTION` 选定 refs；**每个 `\cite{key}` 有 refs.bib 真实条目**（元数据来自 paper-refs 核实，不编；缺字段标记）。
3. bib key 按规则命名；bibstyle 随 venue 模板。
4. 写前 menu→CONTENT_LOCK 门禁；不越界写结果数字。
5. `related-work-examples.md` 由真实顶会顶刊 related-work 段落分析烘焙（不抄句）。
6. RED→GREEN 表明增强改变行为（两部分 / 只引选定 / 真 cite+bib 随模板 / 门禁）。
7. related-work.md / paper-section / storage-framework / fixture 一致。

## 8. 范围之外（YAGNI）
- **其余节的真 `\cite`**（method/experiments 等仍 `\cite{TODO:}`）——本次只做 related-work 落真引用。
- 运行时现搜 examples（本次用 build 时烘焙的内置版）。
- 为**未选定**的 refs 生成 bib（只给被引的）。
- 自动编译/跑 BibTeX 校验（只保证 `\cite`↔bib 条目一致，不代跑 latexmk）。

## 9. 风险与开放问题
- **bib 风格差异**：不同 venue 的 `.bst` 需不同字段/条目类型；靠"读模板 bibstyle + 补该风格必需字段 + 缺则标记"处理，不追求覆盖所有风格的完美格式。
- **paper_type=mixed**：角度可能不止两类 → 规则"每角度一部分"仍适用；部分顺序按 lineage/foundation 先、competing/prior-result 后。
- **元数据缺字段**：paper-refs 池未必每条都全 → `% BIB-INCOMPLETE` 标记，交用户补，不臆填。
- **与 paper-refs 的边界**：paper-refs 只采集+入选（不落 bib）；本步落 bib——契约写清 owner，避免双写。
