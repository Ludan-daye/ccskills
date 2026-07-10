---
name: cs-paper-structure
description: >
  Build and confirm a CS top-venue paper architecture, then write a structure README
  that defines each section's theme, job, and done criteria. Use when starting a
  computer science research paper (顶会/顶刊), scaffolding paper/, outlining
  Abstract–Conclusion structure, or when the user says "论文结构", "paper structure",
  "先定架构", "结构 README", or wants a section map before drafting.
---

# CS Paper Structure (Structure README)

For **computer science conference/journal papers** (顶会/顶刊). This skill does **not** draft full section prose. It only:

1. Confirms the paper **architecture** with the user  
2. Writes a **structure README** under `paper/` that every later draft skill must follow  

If the user wants full drafting or polishing, stop after the structure file and point them to future `paper-draft` / `paper-polish` skills (or write sections only if they explicitly ask).

## Hard rules

- **Never invent a final architecture silently.** Always show the default (or adapted) architecture and get explicit confirmation before writing files.
- **Do not overwrite** an existing `paper/STRUCTURE.md` or `paper/README.md` without asking.
- Prefer **Chinese discussion** with the user unless they write in English; the structure file itself may be **bilingual or English** (academic default: English section titles + Chinese notes if user prefers).
- Keep claims honest: section guidance below is the field norm (IMRaD + CS conference practice), not a specific venue template. Always remind: **final order/names follow the target venue**.

## Default architecture (CS top venue)

Propose this **default** unless the user or venue says otherwise:

```text
1. Abstract
2. Introduction
3. Related Work
4. Method          (a.k.a. Approach / System / Model)
5. Experiments     (a.k.a. Evaluation / Results — setup + results + analysis)
6. Limitations
7. Conclusion
```

### Common legal variants (offer only if relevant)

| Variant | When |
|---------|------|
| Related Work **after** Method/Experiments | Some ML venues put RW late so narrative stays problem→idea→evidence first |
| Limitations **inside** Discussion/Conclusion | Short papers; still keep a dedicated limitations *checklist* in the structure file |
| Separate Results vs Discussion | Journals / longer papers; CS conferences often merge into Experiments |
| Extra: Background, Preliminaries, Ethics, Reproducibility, Appendix | Theory, systems, or venue checklist items |

**Title / Keywords / References / Appendix** are supporting, not “body sections,” but list them in the structure file footer.

---

## Step 1 — Capture context (short)

Ask only what is missing (batch is OK here; keep it short):

1. **Target venue** (e.g. NeurIPS / ICML / CVPR / ACL / SOSP / journal name) if known  
2. **Paper type**: method / system / theory / empirical / survey (rare for “top venue original research”)  
3. **One-sentence problem + one-sentence idea** (rough is fine)  
4. **Existing materials**: notes, old draft, experiment results path  

If the user only wants a blank structure scaffold, skip deep content and still confirm architecture.

---

## Step 2 — Confirm architecture with the user

Present:

1. The **section order** as a numbered list  
2. **One-line theme** per section (use the catalog below)  
3. Any **variant** you recommend for their venue/type, with one sentence why  

Then ask explicitly:

> 请确认：是否采用以上架构？需要增删/调序哪些节？

**Do not write files until they confirm** (or give a clear edit list you then restate and confirm once).

---

## Step 3 — Section theme catalog (fill STRUCTURE.md from this)

Use these **themes** (主题 = 这一节在论文里的“工作岗位”). Expand into the structure file with bullet “must cover” items tailored to the user’s problem/idea when known.

### Abstract

| | |
|--|--|
| **主题** | 全文独立摘要：问题、方法、关键证据、结论一句话闭环 |
| **读者怎么用** | 决定是否继续读；常被单独收录 |
| **应包含** | 背景/问题 → 缺口或目标 → 方法要点 → 主要结果（尽量可量化）→ 意义 |
| **不应** | 新信息未在正文出现；空话口号；过多引用 |
| **完成标准** | 不读正文也能复述“做了什么、为什么重要、证据是什么” |

### Introduction

| | |
|--|--|
| **主题** | 叙事与贡献声明：为何在此刻需要这项工作 |
| **读者怎么用** | 建立问题意识、理解贡献、决定是否信你的故事 |
| **应包含** | 问题动机 → 现状不足/gap → 本文思路（高层次）→ **Contributions（可检验条目）** → 结果预告（可选）→ 论文结构地图（可选） |
| **不应** | 展开全部公式与实现细节；Related Work 式长综述 |
| **完成标准** | 审稿人能用 3 条 contribution 概括本文；gap 与 method 对得上 |

### Related Work

| | |
|--|--|
| **主题** | 定位：别人做了什么、差在哪、本文落在哪条研究线上 |
| **读者怎么用** | 判断 novelty 与 scholarship |
| **应包含** | 按 **主题/方法线** 分组（非流水账）；每组对比维度；**明确差异化**（assumptions / setting / metric / capability） |
| **不应** | 只罗列不对比；攻击式贬低；漏掉直接竞争基线 |
| **完成标准** | 每个主要相关方向都有“同/异”；读者知道本文该和谁比 |

### Method

| | |
|--|--|
| **主题** | 技术贡献本体：算法/模型/系统/分析 **是什么、为何这样设计** |
| **读者怎么用** | 理解可复现的核心思想；评估正确性与设计合理性 |
| **应包含** | 问题形式化或设定 → 总览图/流水线 → 关键模块 → 设计动机与取舍 → 必要复杂度/保证（若有） |
| **不应** | 实验超参大全（放到 Experiments）；只堆公式无直觉 |
| **完成标准** | 同领域研究生能据此实现主要算法；每个非显然设计有一句 why |

### Experiments（Evaluation / Results）

| | |
|--|--|
| **主题** | 用证据支撑 Method 的主张：设置可复现 + 结果可辩护 |
| **读者怎么用** | 检查 claim 是否被数据支持；寻找漏洞 |
| **应包含** | 研究问题/hypotheses → 数据集与任务 → 基线与实现细节 → 主结果 → 消融/分析 → 失败案例（加分） |
| **不应** | 无对比的自说自话；与 Intro 贡献不一致的指标狂欢；隐藏关键设置 |
| **完成标准** | Intro 每条重要 claim 都能指到图/表；别人能复现评估协议 |

### Limitations

| | |
|--|--|
| **主题** | 边界条件：何时失效、何种假设、何种代价 |
| **读者怎么用** | 判断可信度与适用面；顶会越来越看重诚实边界 |
| **应包含** | 数据/设定限制 → 方法假设 → 计算/规模 → 负面结果或未解决问题 → **不**把 limitation 写成假谦虚的优点 |
| **不应** | “未来工作”清单冒充局限；与正文结果矛盾的轻描淡写 |
| **完成标准** | 审稿人挑刺的点你已主动框住，且不削弱已声明的有效贡献 |

### Conclusion

| | |
|--|--|
| **主题** | 收束：贡献回顾 + 证据呼应 + 影响/展望（克制） |
| **读者怎么用** | 离开前的最终印象 |
| **应包含** | 问题与方法一句复述 → 主要发现 → 贡献呼应 → 简短展望（可选） |
| **不应** | 新实验、新 claim；重复 Abstract 逐句拷贝而无提升 |
| **完成标准** | 与 Abstract/Intro 贡献一致；无新未支持的断言 |

---

## Step 4 — Write the structure README

After architecture is confirmed, create:

**Primary file:** `paper/STRUCTURE.md`  
(If the repo already uses `paper/README.md` as the structure map and user prefers that name, use it instead—ask once if both exist.)

Also ensure `paper/` exists. Optionally add empty stubs **only if user asks**:

```text
paper/
├── STRUCTURE.md          # required — architecture + section themes
├── abstract.md           # optional stubs
├── introduction.md
├── related_work.md
├── method.md
├── experiments.md
├── limitations.md
└── conclusion.md
```

### Required content of `STRUCTURE.md`

Use this template (fill brackets; delete guidance comments):

```markdown
# Paper Structure

## Meta
- Working title:
- Target venue:
- Paper type: (method / system / theory / empirical)
- One-line problem:
- One-line idea:
- Confirmed architecture date:
- Status: DRAFT STRUCTURE — prose not written

## Architecture (confirmed)
1. Abstract
2. Introduction
3. Related Work
4. Method
5. Experiments
6. Limitations
7. Conclusion

(Note any venue-specific renames or reordering here.)

## Story line
- Problem:
- Gap:
- Approach (high level):
- Key evidence we will show:

## Contributions (draft, must be testable)
1.
2.
3.

## Section map

### 1. Abstract
- **Theme:** …
- **Must include:** …
- **Must not:** …
- **Depends on:** final results numbers, final contribution wording
- **Done when:** …
- **Draft file:** `paper/abstract.md`
- **Status:** [ ]

### 2. Introduction
- **Theme:** …
- **Must include:** …
- **Must not:** …
- **Key figures/tables promised:** …
- **Done when:** …
- **Draft file:** `paper/introduction.md`
- **Status:** [ ]

### 3. Related Work
- **Theme:** …
- **Taxonomy / groups:** (list planned clusters)
- **Closest baselines / competitors:** …
- **Done when:** …
- **Draft file:** `paper/related_work.md`
- **Status:** [ ]

### 4. Method
- **Theme:** …
- **Subsections (planned):** …
- **Notation / symbols to lock:** …
- **Done when:** …
- **Draft file:** `paper/method.md`
- **Status:** [ ]

### 5. Experiments
- **Theme:** …
- **Claims → evidence map:**
  - Claim A → Figure/Table ?
  - Claim B → Figure/Table ?
- **Datasets / benchmarks:** …
- **Baselines:** …
- **Done when:** …
- **Draft file:** `paper/experiments.md`
- **Status:** [ ]

### 6. Limitations
- **Theme:** …
- **Known limits to disclose:** …
- **Done when:** …
- **Draft file:** `paper/limitations.md`
- **Status:** [ ]

### 7. Conclusion
- **Theme:** …
- **Done when:** …
- **Draft file:** `paper/conclusion.md`
- **Status:** [ ]

## Writing order (recommended)
Do **not** write top-to-bottom on the first pass. Recommended:

1. Lock contributions + story line (this file)
2. Method (core)
3. Experiments (evidence)
4. Introduction (sell with real claims)
5. Related Work (position against real baselines)
6. Limitations
7. Conclusion
8. Abstract (last)

## Consistency checklist
- [ ] Every contribution appears in Intro and is echoed in Conclusion/Abstract
- [ ] Every major claim has an experiment or proof pointer
- [ ] Terminology/symbols match across Method and Experiments
- [ ] Related Work covers all main baselines used in Experiments

## Changelog
- YYYY-MM-DD: architecture confirmed; STRUCTURE.md created
```

Fill themes from the catalog; tailor “Must include” to the user’s problem when possible. Leave honest `TBD` only where user data is missing—do not fabricate datasets, numbers, or citations.

---

## Step 5 — Report back

In Chinese (unless user uses English), report:

1. Confirmed architecture (final list)  
2. Path of the written file  
3. Recommended next step: lock contributions → draft Method (or open `paper-draft` when available)  
4. Remind: venue template may rename/reorder sections  

## Anti-patterns

- Skipping confirmation and dumping a full paper  
- Writing 10 pages of Method inside this skill  
- Treating Limitations as “future work marketing”  
- Related Work as annotated bibliography without contrast  
- Abstract written first with fake numbers  

## Relationship to other skills

| Skill | Role |
|-------|------|
| `managing-research-projects` | Repo TODO / experiments / data layout |
| **`cs-paper-structure` (this)** | Confirm architecture + `paper/STRUCTURE.md` |
| future `paper-draft` | Write section prose following STRUCTURE.md |
| future `paper-polish` | Review/revise full draft for submission |
