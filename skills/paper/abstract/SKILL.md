---
name: paper-abstract
description: >
  Use when writing or revising a paper's Abstract — 写摘要, abstract, 改摘要.
  Requires the parent paper survey first.
---

# Paper Abstract (child of `paper`)

**Parent:** `paper` (`skills/paper/SKILL.md`) — owns **repo scan** and `PAPER_REPO_SURVEY.md`.  
**This skill:** content menu → user lock → style/format only.

```text
[Parent] Phase S: subagent scan → paper/PAPER_REPO_SURVEY.md
    ↓
Phase 1  Ensure survey; brief user
Phase 2  Content menu (select)
Phase 3  CONTENT_LOCK  ← HARD GATE
Phase 4  Style + format → English abstract + LaTeX
```

**Do not** re-implement full-repo subagent scan here. If `PAPER_REPO_SURVEY.md` (or legacy `ABSTRACT_REPO_SURVEY.md`) is missing/stale, **invoke parent `paper` Phase S**, then continue.

**Hard gate:** No final abstract until user confirms content IDs.  
**No unsolicited git push** to user remotes. **No invented metrics.**

---

## When to run

- User asks for abstract / 写摘要  
- Parent `paper` already scanned, or this skill triggers parent scan first  
- Prefer after results exist in the research repo  

---

## Phase 1 — Depend on parent survey

1. Locate ROOT.  
2. Read in order:
   - `paper/PAPER_REPO_SURVEY.md`  
   - else `paper/ABSTRACT_REPO_SURVEY.md` (legacy)  
   - else **run parent `paper` Phase S** (subagent), wait, re-read  
3. Chinese brief (5–10 lines) from the survey: direction, problem, method, hardest results+paths, conflicts.  
4. State: `参考文档: paper/PAPER_REPO_SURVEY.md`

No full English abstract yet.

---

## Phase 2 — Content menu (from survey only)

Build selectable items citing **survey claim_ids and paths**.

| Block | Meaning | Move after lock |
|-------|---------|-----------------|
| A | 背景与问题 | Context |
| B | 缺口 | Gap |
| C | 方法/贡献 | Pivot + Approach |
| D | 证据数字 | Evidence |
| E | 范围/局限 | Scope |
| F | 关键词 | sprinkled |

IDs: A1, A2, B1, B2, C1… D1… (see `references/required-info.md`).

Each row: **ID | 一句话 | 来源路径 | 建议(推荐/可选)**

Default selection + ask:

> 请选择摘要内容：`默认` / 列出 ID / `不要 …` / 改写某条。  
> **确认前不写最终 Abstract。**

Optional: write `paper/ABSTRACT_MENU.md`.

---

## Phase 3 — HARD GATE

```markdown
# CONTENT_LOCK
- Included: …
- Excluded: …
- Numbers (value ← path from PAPER_REPO_SURVEY): …
- Survey: paper/PAPER_REPO_SURVEY.md
- Status: CONFIRMED
```

Wait for user. Only then Phase 4.

---

## Phase 4 — Style and format

Map lock → 6 moves → prose (150–220 words default) → LaTeX.

```text
[1 Context]  A*
[2 Gap]      B*
[3 Pivot]    C1–C2
[4 Approach] C3–C4
[5 Evidence] D* only
[6 Scope]    E*
```

- Exemplars: `references/examples.md` (structure only)  
- Style: `references/structure-and-style.md`  
- Template: IEEE `abstract` / `IEEEkeywords` if no other kit (`paper-structure`)  
- Terms: use canonical forms from `paper/TERMS.md` verbatim; a `needs-user` term → ask, don't invent.  
- No fabricated citations/numbers; numbers trace to survey `claim_id`s (see `../references/storage-framework.md`).  

Outputs: English abstract; optional Chinese; update `paper/abstract.md` / `main.tex` only after lock and if writing is allowed. Also refresh the `abstract:` line in `paper/STATE.md` (parallel to how `section/SKILL.md` refreshes the sections line — see `../references/storage-framework.md` §4).

Report: IDs, abstract, word count, move map, survey path, files touched.

---

## Anti-patterns

- Spawning a full-repo scan subagent inside this child (parent’s job)  
- Final abstract before CONTENT_LOCK  
- Numbers not in `PAPER_REPO_SURVEY.md`  
- Pushing user git unasked  
- Copying example paper sentences  
- Using a term not in `paper/TERMS.md` / a number not in the survey  

---

## References

- Parent: `../SKILL.md` (`paper`)  
- `references/required-info.md`  
- `references/structure-and-style.md`  
- `references/examples.md`  
