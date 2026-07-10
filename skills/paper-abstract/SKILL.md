---
name: paper-abstract
description: >
  Write or revise a CS paper Abstract by first surveying the user's research repo,
  summarizing candidate abstract content for the user to select/edit, and only after
  content is confirmed applying top-venue style and LaTeX format. Use when writing
  abstracts, 写摘要, or aligning abstract text with a paper/code repository.
---

# Paper Abstract (CS Top Venue)

Write a **submission-grade Abstract**. Fixed order — **do not skip gates**:

```text
Phase 1  Survey repo → understand research direction & findings
Phase 2  Propose "abstract should cover …" as selectable content
Phase 3  User chooses / edits / confirms  ← HARD GATE
Phase 4  Only then: style + format → English abstract (+ LaTeX)
```

**Hard gate:** Do **not** produce a polished final abstract (and do not write LaTeX abstract body as final) until the user has **confirmed the content list** (what to include / exclude).  
Drafting style before confirmation is forbidden.

Do **not** invent metrics or citations. Do **not** `git push` the user’s paper repo unless they explicitly ask.

---

## When to run

- User points at a **repo / path** and wants an abstract  
- User pastes a draft and a repo to realign  
- Prefer after results exist; still run survey if early (mark weak evidence)

---

## Hard rules

1. **Repo survey first** when a workspace/repo is available.  
2. **Content menu → user choice → then style.**  
3. **No fabricated numbers.** Every candidate metric needs a source path.  
4. **Chinese discussion** by default; **English abstract** unless user asks otherwise.  
5. **LaTeX:** IEEE `abstract` / venue kit after content lock; default IEEE if unspecified.  
6. **No push** to user repos without explicit request.

---

# Phase 1 — Survey the repository (research direction)

Goal: understand **what this research is about**, not write prose yet.

### 1.1 What to figure out

| Question | Output for later menu |
|----------|------------------------|
| Research **area** / problem domain | Direction blurb |
| Core **research question** or claim | Candidate thesis line |
| **Method / system** name and idea | Method bullets |
| Main **findings** (empirical or theoretical) | Finding bullets + sources |
| **Baselines / comparisons** | Comparison bullets |
| **Ablations / diagnostics** | Optional bullets |
| **Deploy / efficiency** angles | Optional bullets |
| **Limitations** the abstract might need | Optional honesty bullets |
| Conflicts between docs (old vs new narrative) | Flag for user |

### 1.2 Where to read (priority)

1. `README.md`, `paper/FINAL_*.md`, `paper/contributions*`, `paper/GUIDANCE.md`, `STRUCTURE.md`  
2. Result tables: `results/**`, `*REPORT*`, main comparison / seed tables  
3. Existing `paper/abstract*`, `main.tex` abstract (treat as **draft**, may be obsolete)  
4. Method docs, CHANGELOG, experiment design notes  

Prefer the doc that claims to be the **writing authority** if numbers conflict; list conflicts for the user.

### 1.3 Short survey report (to user, Chinese)

Before the menu, give 5–10 lines:

- **研究方向：** …  
- **要解决的问题：** …  
- **做法概要：** …  
- **最硬的结果（带来源）：** …  
- **文档冲突 / 不确定点：** …  

Do **not** yet give a full English abstract.

---

# Phase 2 — Summarize what the abstract *could* cover (for user choice)

Build a **content menu** from the survey: each item is optional for the abstract unless marked recommended.

### 2.1 Group items like a checklist

Use clear IDs so the user can reply e.g. `要 A1 A2 B1 C1 D1 D2，不要 E2`.

#### Block A — 背景与问题（通常要 1–2 条）

| ID | 候选内容（从仓库总结的一句话） | 建议 |
|----|--------------------------------|------|
| A1 | 领域/场景 | 推荐 |
| A2 | 具体任务 | 推荐 |
| A3 | 为何重要 | 可选 |

#### Block B — 缺口 / 痛点（通常要）

| ID | 候选内容 | 建议 |
|----|----------|------|
| B1 | 现有做法是什么 | 推荐 |
| B2 | 现有做法失败在哪（如过度拒绝） | 推荐 |
| B3 | 本文的研究问题（表示 vs 规则等） | 视论文而定 |

#### Block C — 方法 / 贡献（通常要）

| ID | 候选内容 | 建议 |
|----|----------|------|
| C1 | 方法/系统名称 | 推荐 |
| C2 | 核心思想一句话 | 推荐 |
| C3 | 关键机制（极短） | 推荐 |
| C4 | 明确不依赖什么（无目标 LLM、冻结编码器…） | 可选 |
| C5a/b/c | 贡献点 1/2/3（拆开勾选） | 可选 |

#### Block D — 证据 / 数字（至少要用户选中的硬结果）

| ID | 候选内容（数值 + 来源路径） | 建议 |
|----|------------------------------|------|
| D1 | 主指标 / 主表结论 | 推荐 |
| D2 | 评测协议（留出、种子数、基准名） | 推荐从简 |
| D3 | 与基线/护栏对比 | 推荐 |
| D4 | 关键消融（如几何规则 vs 判别头） | 诊断类论文推荐 |
| D5 | 效率/压缩/延迟 | 可选 |

#### Block E — 范围与收尾（可选）

| ID | 候选内容 | 建议 |
|----|----------|------|
| E1 | 泛化/多变体 Pareto | 可选 |
| E2 | 必须诚实写的局限 | 可选 |
| E3 | 开源/工件 | 可选 |

#### Block F — 关键词（可改）

| ID | 候选短语列表 |
|----|----------------|
| F1 | 4–8 个检索词，用户可增删 |

### 2.2 Present format (required)

Show the user:

1. Survey blurb (Phase 1)  
2. **「摘要内容菜单」** table(s) with ID / 一句话 / 来源 / 建议(推荐|可选|不建议)  
3. A **default selection** (your recommendation), e.g.:

```text
默认勾选：A1 A2 B1 B2 C1 C2 C3 D1 D3 D4 F1
未勾选：A3 C4 C5* D2 D5 E*
```

4. Ask explicitly:

> 请选择摘要要写的内容：  
> - 回复 `默认` 采用上面默认勾选；或  
> - 列出要的 ID（如 `A1 A2 B2 C1 C2 D1 D4`），可加 `不要 xxx`；或  
> - 指出要改写的条目（如「D1 改成只报 J，不报 FPR」）。  
> **确认内容之前我不会按顶会文风写最终 Abstract。**

Optionally save the menu to `paper/ABSTRACT_MENU.md` (only if writing in that repo is OK).

---

# Phase 3 — HARD GATE: user confirms content

Wait for user response.

Then produce **`CONTENT_LOCK`** (confirmed list only):

```markdown
# CONTENT_LOCK (user confirmed)
- Included: A1, A2, …
- Excluded: …
- Wording overrides: …
- Numbers locked (value ← source): …
- Status: CONFIRMED
```

If user is vague (“差不多就行”), restate the default selection and ask for a one-word **`确认`**.  
If they add a claim with **no repo source**, either drop it or ask for a number/source—do not invent.

**Only after CONTENT_LOCK is CONFIRMED → Phase 4.**

---

# Phase 4 — Style and format (after content lock)

Now (and only now) apply top-venue style and LaTeX shape **using solely CONTENT_LOCK items**.

### 4.1 Map locked items → 6 moves

```text
[1 Context]  ← A*
[2 Gap]      ← B*
[3 Pivot]    ← C1–C2 (+ B3 if locked)
[4 Approach] ← C3–C4 (+ selected C5)
[5 Evidence] ← D* locked only
[6 Scope]    ← E* if locked
```

Sentence budget: Context 1–2, Gap 1–2, Pivot 1, Approach 1–3, Evidence 2–4, Scope 0–2.  
Target **150–220 English words** unless venue limit differs.

### 4.2 Exemplars (structure only)

| Type | Examples in `references/examples.md` |
|------|--------------------------------------|
| Diagnosis + fix | BatchNorm, LoRA |
| New architecture | Transformer, ResNet |
| Efficiency | LoRA, BatchNorm |
| Theory | VAE |
| Large empirical | GPT-3 |

Imitate move density/contrast; **never copy sentences**.

### 4.3 Style rules

- Active: *We propose / show / find*  
- Contrast: *Unlike / Compared to / Whereas*  
- Numbers over bare “significant”  
- No lit review; no hyperparameter dump  
- See `references/structure-and-style.md`  

### 4.4 Self-check

| Check | |
|-------|--|
| Every sentence supported by CONTENT_LOCK | |
| No locked-out IDs leaked in | |
| Closed loop problem→idea→result | |
| Word limit | |
| Keywords from F1 appear naturally | |

### 4.5 Write outputs

1. English abstract (final)  
2. Optional Chinese mirror  
3. LaTeX `\begin{abstract}...\end{abstract}` (+ `IEEEkeywords` if IEEE)  
4. If allowed: `paper/abstract.md`, update `main.tex` abstract env  
5. Optional: keep `ABSTRACT_MENU.md` + `CONTENT_LOCK` section for audit  

### 4.6 Report to user

1. Confirmed content IDs  
2. Final English abstract  
3. Word count  
4. Move map  
5. Exemplars  
6. Files touched (if any)  
7. Risks  

---

## If there is no repo

- Build the same **menu** from user description / pasted draft only  
- Mark sources as `user-provided`  
- Still require Phase 3 confirm before Phase 4  

---

## Anti-patterns

- Jumping to a full English abstract before user selects content  
- Hiding the menu as “internal only”  
- Mixing obsolete README numbers with FINAL tables without flagging  
- Pushing to the user’s git remote unasked  
- Copying example paper sentences  

---

## Relationship to other skills

| Skill | Role |
|-------|------|
| `cs-paper-structure` | IEEE/venue template, GUIDANCE, skeleton |
| **`paper-abstract` (this)** | Repo survey → content menu → lock → style/format |
| future section skills | Intro/Method/… after abstract content is stable |

---

## References

- `references/required-info.md` — slot definitions  
- `references/structure-and-style.md` — style analysis  
- `references/examples.md` — annotated abstracts  
