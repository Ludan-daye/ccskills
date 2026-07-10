---
name: paper
description: >
  Parent skill for CS research paper writing (顶会/顶刊). Owns repo survey via
  subagent (direction, data, results with file paths → paper/PAPER_REPO_SURVEY.md),
  routes to child skills (paper-abstract, structure, later intro/method/…). Use when
  the user works on a paper, 写论文, paper skill, 扫仓库写摘要/各节, or any
  paper/* section skill needs shared research context.
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
└── abstract/                   ← child: paper-abstract
    ├── SKILL.md
    └── references/…
```

| Child (invoke after survey when needed) | Role |
|-----------------------------------------|------|
| **`paper-abstract`** (`paper/abstract/`) | Content menu → user lock → style/format Abstract |
| `cs-paper-structure` (sibling for now) | IEEE/venue LaTeX skeleton + GUIDANCE |
| future `paper-intro` / `paper-method` / … | Section skills under `paper/` |

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
| 搭结构 / 模板 / IEEE | Invoke **`cs-paper-structure`** |
| 重新扫 / 结果更新了 | Re-run Phase S |
| unclear | Ask: abstract / structure / other section |

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
| `paper/GUIDANCE.md` | cs-paper-structure / paper | all |
| `paper/ABSTRACT_MENU.md` | paper-abstract | abstract only |
| `paper/abstract.md`, `main.tex` | paper-abstract after lock | — |

---

## Hard rules

1. **Scan is parent-only.** Children must not spawn a second full-repo survey unless parent survey is missing (then call back into this skill / Phase S).  
2. **No invented metrics.**  
3. **No unsolicited git push** to user remotes.  
4. Default LaTeX kit when unspecified: **IEEE IEEEtran** (see `cs-paper-structure`).  
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
- Child: `abstract/SKILL.md` (`paper-abstract`)  
