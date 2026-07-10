---
name: paper
description: >
  Use when the user works on a CS research paper (写论文, 顶会/顶刊 投稿), needs their
  research repo turned into paper material, or any paper section task needs shared
  research context. Parent of paper-structure, paper-section, paper-abstract.
---

# Paper (parent skill)

Top-level skill for **writing a CS research paper** against a user research repository.

## Hierarchy

```text
paper/                          ← this skill (scan + routing + shared docs)
├── SKILL.md
├── references/
│   ├── subagent-survey-prompt.md
│   └── survey-template.md
├── abstract/                   ← paper-abstract
│   ├── SKILL.md
│   └── references/…
├── section/                   ← paper-section (body sections)
└── structure/                  ← paper-structure (ex cs-paper-structure)
    └── SKILL.md
```

**All paper-writing skills live under `skills/paper/`.** Do not add new paper section skills at the repo top level.

| Child (invoke after survey when needed) | Role |
|-----------------------------------------|------|
| **`paper-abstract`** (`paper/abstract/`) | Content menu → user lock → style/format Abstract |
| **`paper-section`** (`paper/section/`) | Body section: menu → lock → write prose into LaTeX |
| **`paper-structure`** (`paper/structure/`) | IEEE/venue LaTeX skeleton + GUIDANCE + architecture |
| future `paper/intro`, `paper/method`, … | More section children under `paper/` only |

**Rule:** Repo **scanning lives only here**, not in section children. Children **read** `paper/PAPER_REPO_SURVEY.md`.

---

## When this skill loads

1. Resolve **ROOT** (CWD / user path / clone).  
2. **Immediately run Phase S — repo scan** (subagent).  
3. Brief the user from the survey doc.  
4. Ask what they want next, or if they already asked for a section (e.g. abstract), **load that child skill** and pass the survey path.

If user only said “写 abstract”, still: **this parent scan first**, then follow `paper-abstract`.

---

## Phase S — Repo scan (subagent, mandatory when ROOT exists)

### S.1 Dispatch

| Field | Value |
|-------|--------|
| Tool | `spawn_subagent` / Task |
| `subagent_type` | `explore` (read-only) preferred |
| `description` | `Scan paper research repo` |
| `capability_mode` | `read-only` if available |

If subagents unavailable: parent scans with **same template**, set `scanner: parent-fallback`.

### S.2 Prompt

Use full text in `references/subagent-survey-prompt.md`. Fill `ROOT=...`.

Output file (shared by all paper children):

```text
ROOT/paper/PAPER_REPO_SURVEY.md
```

Fallback: `ROOT/PAPER_REPO_SURVEY.md`.

Schema: `references/survey-template.md`.

**Every claim must include a file path.**

Also acceptable legacy name: `ABSTRACT_REPO_SURVEY.md` — if only that exists, read it and prefer renaming/copying to `PAPER_REPO_SURVEY.md` on next scan.

### S.3 After scan

1. Read `paper/PAPER_REPO_SURVEY.md`.  
2. Chinese TL;DR for user (direction, problem, method, top results+paths, conflicts).  
3. Point to the survey path as **standing reference**.  
4. Route:

| User intent | Next |
|-------------|------|
| 写摘要 / abstract | Invoke **`paper-abstract`** (do **not** re-scan unless stale) |
| 写正文/某节 (intro/method/…) | Invoke **`paper-section`** |
| 搭结构 / 模板 / IEEE | Invoke **`paper-structure`** |
| 重新扫 / 结果更新了 | Re-run Phase S |
| unclear | Ask: abstract / structure / other section |

Also extract terminology (see survey template §1t) and, after scan, seed `paper/TERMS.md` and `paper/STATE.md` from the survey; mark unknown terms `needs-user`.

### S.4 Re-scan when

- Different ROOT  
- User says 重新扫 / results updated  
- Survey missing or clearly obsolete vs user statement  

Otherwise reuse survey and show `scanned_at`.

### S.5 Write forbidden in user repo?

Still scan read-only; put survey body in chat under `PAPER_REPO_SURVEY` or a user-allowed path.

---

## Shared artifacts

| Path | Owner | Consumers |
|------|--------|-----------|
| `paper/PAPER_REPO_SURVEY.md` | **paper** (this) | abstract, intro, method, … |
| `paper/GUIDANCE.md` | paper-structure / paper | all |
| `paper/TERMS.md` | **paper** (seed) | section, abstract |
| `paper/STATE.md` | all (rollup) | paper routing |
| `paper/ABSTRACT_MENU.md` | paper-abstract | abstract only |
| `paper/abstract.md`, `main.tex` | paper-abstract after lock | — |

完整契约见 `references/storage-framework.md`。

---

## Hard rules

1. **Scan is parent-only.** Children must not spawn a second full-repo survey unless parent survey is missing (then call back into this skill / Phase S).  
2. **No invented metrics.**  
3. **No unsolicited git push** to user remotes.  
4. Default LaTeX kit when unspecified: **IEEE IEEEtran** (see `paper-structure`).  
5. Chinese discussion default.

---

## Anti-patterns

- Putting scan Phase 0 inside `paper-abstract` again  
- Section skill ignoring `PAPER_REPO_SURVEY.md` and guessing numbers  
- Survey bullets without paths  
- Writing final abstract inside this parent skill (delegate to child)

---

## References

- `references/subagent-survey-prompt.md`  
- `references/survey-template.md`  
- Children: `abstract/SKILL.md`, `structure/SKILL.md`  
