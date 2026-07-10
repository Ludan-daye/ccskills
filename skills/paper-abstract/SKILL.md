---
name: paper-abstract
description: >
  Write or revise a CS paper Abstract: on load, dispatch a subagent to scan the user
  research repo (direction, data, content with file paths) and write a survey document;
  then present a selectable content menu; only after user confirms, apply top-venue style
  and LaTeX. Use when writing abstracts, 写摘要, or aligning abstract text with a repo.
---

# Paper Abstract (CS Top Venue)

Write a **submission-grade Abstract**. Fixed order — **do not skip gates**:

```text
Phase 0  ON LOAD: spawn subagent → scan repo → write survey doc (paths required)
Phase 1  Parent reads survey doc → short Chinese brief to user
Phase 2  Content menu for user to select
Phase 3  User confirms  ← HARD GATE
Phase 4  Style + format → English abstract (+ LaTeX)
```

**Hard gate:** No polished final abstract until the user **confirms the content list**.  
**On load:** Immediately dispatch a **repo-scan subagent** (do not wait for extra user wording if a repo/CWD is already available).

Do **not** invent metrics. Do **not** `git push` the user’s paper repo unless they explicitly ask.

---

## When to run

- User wants an abstract and has a **research repo** (CWD, path, or GitHub clone)  
- User pastes a draft + points at a repo  
- Prefer after results exist; survey still runs early (flag weak evidence)

---

## Hard rules

1. **Subagent survey on skill load** when a repo path exists (see Phase 0).  
2. **Every claim in the survey doc must include a file path** (and table/section anchor if possible).  
3. **Content menu → user choice → then style.**  
4. **No fabricated numbers.**  
5. **Chinese discussion** by default; **English abstract** after lock.  
6. **LaTeX:** IEEE default if unspecified.  
7. **No unsolicited push** to user remotes.

---

# Phase 0 — ON LOAD: Subagent repo scan (mandatory)

As soon as this skill is invoked **and** a project root is known (workspace CWD, user-given path, or freshly cloned repo):

### 0.1 Dispatch immediately

Use the platform subagent tool (**`spawn_subagent`** / Task / equivalent):

| Field | Value |
|-------|--------|
| `subagent_type` | `explore` preferred (read-only), else `general-purpose` with **read-only** intent |
| `description` | `Scan repo for abstract` |
| `capability_mode` | `read-only` if available |
| `background` | `true` OK if you can await results before the content menu; otherwise run sync |

**Do not** implement a shallow skim yourself *instead of* the subagent when a full repo is present. Parent may do a tiny peek only to find `ROOT`. If tools cannot spawn subagents, fall back to parent scan **using the same survey doc schema**, and note `scanner: parent-fallback` in the doc.

### 0.2 Subagent prompt (copy and fill)

```text
You are a read-only research-repo scanner for writing a paper abstract later.
Do NOT write the abstract. Do NOT modify git remotes. Do NOT invent numbers.

ROOT = <absolute path to user research repo>

Tasks:
1. Identify research DIRECTION: area, problem, research question, method name/idea.
2. Identify DATA & PROTOCOL: datasets, splits, seeds, metrics definitions.
3. Identify RESULTS: main tables/figures numbers, ablations, baselines, efficiency claims.
4. Identify CONFLICTS: obsolete vs authoritative docs (e.g. old abstract vs FINAL_SYSTEM).
5. List KEY FILE PATHS for everything you claim.

Search priority under ROOT:
- README.md, REPORT.md, CHANGELOG.md
- paper/** (especially FINAL_*, contributions*, GUIDANCE*, STRUCTURE*, abstract*, main.tex)
- results/** (REPORT, tables, *seeds*, *pareto*, comparison*)
- docs/**, experimental*design*, configs/**

Rules:
- Every bullet MUST end with a source like: (path/to/file.md §section or Table N)
- Prefer mean±std / multi-seed over single-seed when both exist; note which.
- Quote numbers exactly as in source; do not round creatively.
- If unsure which doc is authoritative, list both and mark CONFLICT.
- Skip huge binaries; do not load model weights.

Write the full report as Markdown to:
  ROOT/paper/ABSTRACT_REPO_SURVEY.md
If paper/ cannot be created (permissions), write to:
  ROOT/ABSTRACT_REPO_SURVEY.md
and say so in your return message.

Use the exact template below (fill all sections; use "TBD" only with reason).

--- template ---
# ABSTRACT_REPO_SURVEY

- root: <ROOT>
- scanned_at: <ISO timestamp>
- scanner: subagent-explore | subagent-general | parent-fallback
- authoritative_result_doc: <path or TBD>
- obsolete_docs_flagged: <paths>

## 1. Research direction
- area:
- problem:
- research_question:
- method_name:
- method_one_liner:
- paper_type: method | system | theory | empirical | efficiency | diagnosis | mixed
Sources: ...

## 2. Story / narrative (for abstract candidates)
- status_quo:
- failure_mode_or_gap:
- key_insight_or_diagnosis:
- proposed_fix:
Sources: ...

## 3. Data & evaluation protocol
- train_data: ...
- eval_data: ...
- splits_seeds: ...
- metrics: ...
- protocol_notes: ...
Sources: ...

## 4. Main results (with paths)
| claim_id | claim (short) | number/value | source_path | note |
|----------|---------------|--------------|------------|------|
| R1 | | | | |
| R2 | | | | |

## 5. Ablations / diagnostics (with paths)
| claim_id | claim | number/value | source_path | note |
|----------|-------|--------------|------------|------|

## 6. Baselines / comparisons (with paths)
| claim_id | ours vs whom | number/value | source_path | note |
|----------|--------------|--------------|------------|------|

## 7. Efficiency / deploy (optional)
| claim_id | claim | number/value | source_path | note |
|----------|-------|--------------|------------|------|

## 8. Limitations / honesty (from repo)
- ...
Sources: ...

## 9. Keywords / searchable phrases
- ...

## 10. File index (paths only)
### Narrative / paper
- path — why relevant
### Results
- path — why relevant
### Code / config (if needed for method name)
- path — why relevant

## 11. Conflicts
- A says X (path) vs B says Y (path) → recommendation for abstract author

## 12. Suggested abstract menu seeds (IDs only, no prose abstract)
- Recommended: A1, A2, ...
- Optional: ...
- Avoid until user confirms: ...
--- end template ---

Return to parent: (1) path of the written survey file (2) 5-line TL;DR (3) top 3 conflicts if any.
```

### 0.3 Parent responsibilities after subagent returns

1. **Read** `paper/ABSTRACT_REPO_SURVEY.md` (or fallback path).  
2. If the file is missing or thin, **one** repair pass (re-dispatch or parent fill gaps)—do not proceed to final abstract.  
3. Treat this file as the **standing reference doc** for Phases 1–4 (menu items must cite its claim_ids / paths).  
4. Tell the user the survey path, e.g. `已写入 paper/ABSTRACT_REPO_SURVEY.md（含路径）`.

### 0.4 If user forbids writing inside their repo

- Still run the subagent read-only.  
- Write the same template to a **session-only path** the user allows, or paste the full survey in chat under a heading `ABSTRACT_REPO_SURVEY`.  
- Prefer: `ROOT/paper/ABSTRACT_REPO_SURVEY.md` when possible.

### 0.5 Re-scan triggers

Re-dispatch subagent when:

- User points to a **different** repo  
- User says results were updated / “重新扫”  
- Survey is older than the conversation’s known result refresh  

Otherwise reuse the existing survey doc and note its `scanned_at`.

---

# Phase 1 — Brief the user from the survey doc

From `ABSTRACT_REPO_SURVEY.md`, in Chinese (5–10 lines):

- **研究方向：** …  
- **要解决的问题：** …  
- **做法概要：** …  
- **最硬的结果（路径）：** …  
- **冲突 / 不确定：** …  
- **参考文档：** `paper/ABSTRACT_REPO_SURVEY.md`

**No** full English abstract yet.

---

# Phase 2 — Content menu (user selects)

Build menu **from the survey doc** (not from memory alone). Each row:

| ID | 一句话 | 来源路径 (from survey) | 建议 |

Blocks: **A** 背景 **B** 缺口 **C** 方法 **D** 证据 **E** 范围 **F** 关键词  
(IDs as before: A1, B2, C1, D1, …)

Default selection + ask:

> 请选择摘要要写的内容：`默认` / 列出 ID / `不要 …` / 改写某条。  
> **确认前不写最终 Abstract。**

Optionally also write `paper/ABSTRACT_MENU.md` linking to claim rows in the survey.

---

# Phase 3 — HARD GATE: CONTENT_LOCK

Wait for user. Then:

```markdown
# CONTENT_LOCK
- Included: …
- Excluded: …
- Numbers (value ← path): …
- Based on survey: paper/ABSTRACT_REPO_SURVEY.md
- Status: CONFIRMED
```

Only then → Phase 4.

---

# Phase 4 — Style and format (after lock)

Map locked IDs → 6 moves → English abstract (150–220 words default) → LaTeX.

```text
[1 Context]  A*
[2 Gap]      B*
[3 Pivot]    C1–C2
[4 Approach] C3–C4
[5 Evidence] D* only with paths in survey
[6 Scope]    E*
```

Exemplars: `references/examples.md` (structure only).  
Style: `references/structure-and-style.md`.  
Default template: **IEEE** abstract env if no other kit.

Report: confirmed IDs, abstract, word count, move map, survey path, files touched.

---

## No repo available

- Skip subagent file write; ask user for path or paste materials.  
- Menu from user text only; sources = `user-provided`.  
- Still require confirm before style.

---

## Anti-patterns

- Writing final abstract before menu confirm  
- Skipping subagent when a repo root is available  
- Survey bullets **without paths**  
- Ignoring `ABSTRACT_REPO_SURVEY.md` and improvising numbers  
- Pushing to user git unasked  
- Copying sentences from `examples.md`  

---

## Artifact files (reference pack)

| File | Role |
|------|------|
| `paper/ABSTRACT_REPO_SURVEY.md` | **Subagent output** — direction, data, results, **paths** |
| `paper/ABSTRACT_MENU.md` | Optional menu snapshot |
| `paper/abstract.md` / `main.tex` | Final abstract after lock only |

---

## Relationship to other skills

| Skill | Role |
|-------|------|
| `cs-paper-structure` | IEEE/venue kit, GUIDANCE |
| **`paper-abstract`** | Subagent survey doc → menu → lock → style |
| `dispatching-parallel-agents` | Pattern reference for subagent use |

---

## References

- `references/required-info.md` — menu slots  
- `references/structure-and-style.md`  
- `references/examples.md`  
- `references/subagent-survey-prompt.md` — prompt copy-paste  
