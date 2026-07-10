---
name: paper-abstract
description: >
  Write or revise the Abstract of a CS top-venue (顶会/顶刊) paper in official LaTeX.
  First extract required abstract facts from the repo into a fact sheet, then rearrange
  them into the 5–6 move abstract format using top-paper style. Use when the user asks
  to write/polish an abstract, 写摘要, abstract for NeurIPS/ICML/CVPR/ACL/IEEE, or when
  drafting the abstract environment after experiments exist.
---

# Paper Abstract (CS Top Venue)

Write a **submission-grade Abstract** for computer science conference/journal papers.

**Pipeline (fixed order):**

```text
1) Know what an abstract must contain (required info)
2) Extract those facts from the repository (+ user text)
3) Fill ABSTRACT_FACTS sheet (no prose yet)
4) Map facts → 6-move abstract outline
5) Write English abstract (+ optional Chinese) into IEEE/venue LaTeX
```

Do **not** invent results or citations. Do **not** jump to pretty prose before the fact sheet is filled (missing cells → ask user or mark TBD).

---

## When to run

- User asks to write / rewrite / shorten / strengthen the abstract  
- Prefer **after** main experimental numbers or proofs exist in the repo  
- Also when user pastes a draft abstract and a code/paper repo to align  

---

## Hard rules

1. **Extract before write.** Always produce (or update) an **ABSTRACT_FACTS** block from the repo first.  
2. **Read first:** `paper/GUIDANCE.md`, `paper/STRUCTURE.md` / `paper/FINAL_SYSTEM.md` / `README.md`, then results tables, then existing abstract.  
3. **No fabricated metrics.** Every number must appear in repo files or explicit user text, with a **source path** on the fact sheet.  
4. **No fake citations** in the abstract.  
5. **Venue limits win.** Default **150–220 English words** unless GUIDANCE/author kit says otherwise.  
6. **LaTeX:** Edit official `abstract` (and `IEEEkeywords` if any). If no project yet, **IEEE IEEEtran** default.  
7. **Chinese discussion / English abstract** unless user requests otherwise.  

---

## Required information (what an abstract must cover)

An abstract is a **closed sales pitch**. Before drafting, ensure these **slots** are filled.  
`Must` = almost always; `If applicable` = only when true for this paper.

### A. Problem & motivation (Must)

| Slot ID | What to capture | Abstract role |
|---------|-----------------|---------------|
| A1 | **Domain / setting** (one phrase) | Context |
| A2 | **Task** the paper addresses | Context |
| A3 | **Why it matters** (safety, cost, accuracy, scale…) | Context |
| A4 | **Who suffers / use case** (optional short) | Context |

### B. Gap (Must)

| Slot ID | What to capture | Abstract role |
|---------|-----------------|---------------|
| B1 | **Status-quo approach** (what people do now) | Gap setup |
| B2 | **Failure mode** of status quo (over-refusal, cost, inaccuracy…) | Gap |
| B3 | **Precise research question** (optional but strong) | Pivot setup |

### C. Contribution / method (Must)

| Slot ID | What to capture | Abstract role |
|---------|-----------------|---------------|
| C1 | **Artifact name** (method/system) or crisp description | Pivot |
| C2 | **Core idea in one sentence** (what you do differently) | Pivot + Approach |
| C3 | **Key mechanism** (not full method) | Approach |
| C4 | **What you deliberately do *not* require** (e.g. no target LLM, frozen encoder) | Contrast |
| C5 | **Contributions list (≤3)** if paper states them | Approach / scope |

### D. Evidence (Must — at least one hard fact)

| Slot ID | What to capture | Abstract role |
|---------|-----------------|---------------|
| D1 | **Main metric(s)** + value(s) | Evidence |
| D2 | **Dataset / protocol** (holdout, seeds, benchmarks) | Evidence |
| D3 | **Baseline comparison** (who/what you beat, by how much) | Evidence |
| D4 | **Ablation / diagnostic finding** (e.g. rule vs representation) | Evidence |
| D5 | **Efficiency** (latency, params, compression) if claimed | Evidence |

### E. Scope & caveats (If applicable)

| Slot ID | What to capture | Abstract role |
|---------|-----------------|---------------|
| E1 | **Generality** (other tasks/encoders) | Scope |
| E2 | **Must-state limitation** that changes interpretation | Scope |
| E3 | **Artifact release** (code/model) if central | Scope |

### F. Keywords / search phrases (Must for indexing)

| Slot ID | What to capture |
|---------|-----------------|
| F1 | 4–8 phrases a reviewer might search (task, method family, benchmarks) |

**Minimum to draft:** A1–A3, B1–B2, C1–C3, **at least one of D1–D4**, F1.  
If D is empty → **stop and ask** for numbers or point to which result file is authoritative.

---

## Step 1 — Extract from the repository

Search the workspace **before** asking the user (user can still override).

### 1.1 Where to look (priority order)

| Priority | Paths / patterns |
|----------|------------------|
| 1 | `paper/GUIDANCE.md`, `paper/STRUCTURE.md`, `paper/FINAL_SYSTEM.md`, `paper/contributions*.md` |
| 2 | `paper/abstract.md`, `paper/main.tex` (`abstract` env), `README.md` (TL;DR / results tables) |
| 3 | `results/**/*.md`, `results/**/*REPORT*`, `results/**/*table*`, `**/comparison*.md` |
| 4 | `results/**/*.json` (metrics dumps; prefer mean±std over single seed if both exist) |
| 5 | `REPORT.md`, `CHANGELOG.md`, experiment design docs |
| 6 | User message (draft Chinese/English abstract, pasted tables) |

### 1.2 How to extract

1. Read authoritative narrative docs for **story** (problem, diagnosis, method).  
2. Read **main result tables** for numbers; prefer files labeled final / 5-seed / main table.  
3. If multiple conflicting numbers, **prefer the doc that claims to be the writing authority** (e.g. `FINAL_SYSTEM.md`); note conflicts on the fact sheet.  
4. Copy numbers **exactly** as reported (rounding only if the paper already rounds).  
5. Record **source path + table/section id** for every D-slot number.

### 1.3 Write the fact sheet (required intermediate)

Create or update:

**`paper/ABSTRACT_FACTS.md`**

(If user forbade writing in their paper repo, keep the sheet **only in the chat reply** and still fill every slot.)

Template:

```markdown
# ABSTRACT_FACTS
> Extracted for paper-abstract. Do not invent. Status: EXTRACTED | NEEDS_USER | READY_TO_DRAFT

## Meta
- Venue / template: (IEEE-default / …)
- Word limit: 
- Paper type: method | system | theory | empirical | efficiency | diagnosis
- Authoritative result doc: `path`
- Extraction date:

## A. Problem & motivation
- A1 Domain:
- A2 Task:
- A3 Why it matters:
- A4 Use case: (optional)

## B. Gap
- B1 Status quo:
- B2 Failure mode:
- B3 Research question: (optional)

## C. Method / contribution
- C1 Name:
- C2 Core idea (1 sentence):
- C3 Mechanism (short):
- C4 Not required / contrast:
- C5 Contributions (≤3):
  1.
  2.
  3.

## D. Evidence (each line: value — source)
- D1 Main metrics:
- D2 Protocol / data:
- D3 vs baselines:
- D4 Ablation / diagnosis:
- D5 Efficiency: (optional)

## E. Scope
- E1 Generality:
- E2 Limitation to mention:
- E3 Release:

## F. Keywords
- F1: …

## Conflicts / TBD
- (list anything inconsistent or missing)

## Sources scanned
- `path` — what was taken
```

Mark status:

- `NEEDS_USER` if Must slots missing  
- `READY_TO_DRAFT` when minimum set is complete  

**Show the fact sheet to the user** (brief table or path). If NEEDS_USER, ask only for missing Must slots—then continue.

---

## Step 2 — Pick exemplars

Open `references/examples.md` and `references/structure-and-style.md`.

| Paper type (from facts) | Prefer examples |
|-------------------------|-----------------|
| New model/architecture | A Transformer, B ResNet |
| Pretrain / representation | C BERT, E GPT-3 |
| Efficiency / adaptation | D LoRA, H BatchNorm |
| Algorithm / RL / optimization | G PPO, F VAE |
| Theory / inference | F VAE |
| Diagnosis + simple fix | H BatchNorm, D LoRA |
| Large empirical | E GPT-3 |

Imitate **move order and density only**, never copy sentences.

---

## Step 3 — Map facts → abstract format (outline)

Rearrange **only from ABSTRACT_FACTS** into six moves:

```text
[1 Context]  ← A1 + A2 (+ A3 short)
[2 Gap]      ← B1 + B2
[3 Pivot]    ← B3? + C1 + C2   ("We propose/show…")
[4 Approach] ← C3 + C4 (+ C5 compressed)
[5 Evidence] ← D1 + D2 + D3 (+ D4/D5 if space)
[6 Scope]    ← E1/E2/E3 if needed for honesty or impact
```

### Mapping rules

| Rule | Detail |
|------|--------|
| One fact → one job | Don’t dump all of C5 into Evidence |
| Numbers only in 5 (or end of 4) | Keep Approach mechanism-light |
| Diagnosis papers | Put D4 (e.g. linear separability / ablation) in Pivot or early Evidence |
| Drop for length | Prefer drop E, then secondary D metrics, then A4 |
| Never add | Claims not on the fact sheet |

Fill:

```text
[1 Context]  ...
[2 Gap]      ...
[3 Pivot]    ...
[4 Approach] ...
[5 Evidence] ...
[6 Scope]    ...
```

Default sentence budget:

| Move | Sentences |
|------|-----------|
| Context | 1–2 |
| Gap | 1–2 |
| Pivot + name | 1 |
| Approach | 1–3 |
| Evidence | 2–4 |
| Scope | 0–2 |

---

## Step 4 — Draft prose from the outline

### Pivot templates (pick one)

- *We propose X, a … that …*  
- *We introduce X, which …*  
- *Here we show that …*  
- *We study whether … and find that …* (diagnosis-style)

### Evidence templates

- *On D, X achieves M, improving over B by Δ.*  
- *Compared to B, X reduces P by × while matching quality on …*  
- *Under protocol P (N seeds), … among K methods …*  
- *In a controlled ablation, metric falls from a→b while … rises.*

### Style

- Active: *We …*  
- Contrast: *Unlike / Whereas / Compared to*  
- Numbers over bare *significant*  
- Name method early; no lit review; no hyperparameter dump  
- Details: `references/structure-and-style.md`  

### Anti-patterns

- Prose without ABSTRACT_FACTS  
- Numbers with no source on the sheet  
- Copying `examples.md`  
- Marketing without mechanism  
- Claims not in Experiments / authoritative doc  

---

## Step 5 — Self-review

| Check | Fail → |
|-------|--------|
| Every Must slot reflected or consciously dropped with note | Fix outline |
| Every number matches ABSTRACT_FACTS source | Correct or remove |
| Closed loop problem→idea→result | Add move |
| 150–220 words (or venue limit) | Cut Scope / extra metrics |
| Search keywords (F1) appear | Insert natural phrases |
| IEEE/venue abstract env OK | Adjust wrappers |

---

## Step 6 — Write into the paper project

1. Prefer sink: `paper/sections/abstract.tex` → `paper/main.tex` `abstract` → `STRUCTURE.md` path.  
2. Write English abstract; optional Chinese mirror in `paper/abstract.md`.  
3. Keep `% Theme` comments; set status drafted.  
4. Ensure `paper/ABSTRACT_FACTS.md` is saved (unless user forbade repo writes).  
5. Append GUIDANCE transcript if `GUIDANCE.md` exists:

```markdown
### YYYY-MM-DD — paper-abstract
- Extracted facts from: …
- Drafted abstract (~N words); exemplars: …
- Numbers used: … (sources …)
```

6. Compile only if GUIDANCE says local TeX; never fake Overleaf.

```latex
\begin{abstract}
... single paragraph default ...
\end{abstract}
```

---

## Step 7 — Report to user

In Chinese (unless user writes English):

1. **Fact sheet summary** (or path to `ABSTRACT_FACTS.md`) — what was extracted  
2. **Missing / TBD** slots (if any)  
3. **Final English abstract** (copy-paste block)  
4. Word count vs limit  
5. **Move map** (1–6) one line each  
6. Exemplars used  
7. Files touched + compile status  
8. Risks (conflict numbers, small eval sets, over-claim)

Do **not** push to the user’s paper repo unless they explicitly ask.

---

## Relationship to other skills

| Skill | Role |
|-------|------|
| `cs-paper-structure` | IEEE/venue template, GUIDANCE, section skeleton |
| **`paper-abstract` (this)** | Extract facts → format → abstract prose |
| future `paper-intro` | Shares C5 contributions; deeper narrative |
| future `paper-polish` | Whole-paper pass |

---

## References

- `references/structure-and-style.md` — structure + language analysis  
- `references/examples.md` — annotated top-paper abstracts  
