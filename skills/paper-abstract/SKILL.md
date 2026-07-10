---
name: paper-abstract
description: >
  Write or revise the Abstract of a CS top-venue (顶会/顶刊) paper in official LaTeX.
  Uses a 5–6 move structure (context, gap, pivot, approach, evidence, implication),
  style patterns from annotated top-paper abstracts, and real user results only.
  Use when the user asks to write/polish an abstract, 写摘要, abstract for NeurIPS/ICML/CVPR/ACL,
  or when drafting the abstract environment after experiments exist.
---

# Paper Abstract (CS Top Venue)

Write a **submission-grade Abstract** for computer science conference/journal papers.  
This skill fills the paper’s **LaTeX `abstract` environment** (or `paper/sections/abstract.tex`). It does **not** invent results or citations.

## When to run

- User asks to write / rewrite / shorten / strengthen the abstract  
- `cs-paper-structure` skeleton exists and real results (or theoretical claims) are available  
- Prefer running **after** main experimental numbers or proofs are locked; rewrite if claims change  

## Hard rules

1. **Read first:** `paper/GUIDANCE.md` (venue, word limits, submit links), then `paper/STRUCTURE.md` if present, then current `main.tex` / abstract file.  
2. **No fabricated metrics.** Every number must come from user-provided results, tables in the repo, or explicit user text. If missing, ask—do not invent BLEU/accuracy/speedups.  
3. **No fake citations** in the abstract (top CS abstracts often have zero).  
4. **Venue limits win.** If author kit / GUIDANCE states a max length (words/characters), enforce it. Default target: **150–220 words** unless venue says otherwise.  
5. **Match the LaTeX project.** Edit the official template’s abstract environment; keep surrounding class options untouched.  
6. **Chinese discussion / English abstract** unless the user requests another language for the abstract itself.

---

## Step 1 — Load context

Collect:

| Item | Source |
|------|--------|
| Venue + stage + length limit | `GUIDANCE.md` |
| One-line problem / idea | `GUIDANCE.md` / user |
| Method name | user / Method section |
| Top claims (≤3) | STRUCTURE contributions or user |
| Hard numbers | experiments, tables, user paste |
| Paper type | method / system / theory / empirical / efficiency |

If numbers or contribution bullets are missing, **ask before drafting** (batch OK):

1. Method/system name (or OK to leave unnamed)?  
2. Strongest 1–3 quantitative results (metric, dataset, baseline comparison)?  
3. Main gap vs prior work in one sentence?  
4. Any must-mention secondary result or must-state limitation?

---

## Step 2 — Pick exemplars

Open `references/examples.md` and `references/structure-and-style.md`.

Choose **1–2 examples** of the same type:

| User paper type | Prefer examples |
|-----------------|-----------------|
| New model/architecture | A Transformer, B ResNet |
| Pretrain / representation | C BERT, E GPT-3 |
| Efficiency / adaptation | D LoRA, H BatchNorm |
| Algorithm / RL / optimization | G PPO, F VAE |
| Theory / inference | F VAE |
| Large empirical | E GPT-3 |

Tell the user briefly which exemplars you are imitating **for structure only**.

---

## Step 3 — Outline moves (show user if drafting from scratch)

Fill this checklist **in English** before prose:

```text
[1 Context]  ...
[2 Gap]      ...
[3 Pivot]    We propose/introduce/show ...
[4 Approach] ...
[5 Evidence] metric@dataset: ...  (must be real)
[6 Scope]    optional generality / caveat / artifact
```

If the user wants approval gates, show the move outline first; otherwise proceed to draft and show the full abstract.

---

## Step 4 — Draft with the standard formula

### Default sentence budget

| Move | Sentences |
|------|-----------|
| Context | 1–2 |
| Gap | 1–2 |
| Pivot + name | 1 |
| Approach | 1–3 |
| Evidence | 2–4 |
| Scope / implication | 0–2 |

### Pivot templates (pick one; do not stack clichés)

- *We propose X, a … that …*  
- *We introduce X, which …*  
- *Here we show that …*  
- *We present a … framework to …*  

### Evidence templates

- *On D, X achieves M, improving over B by Δ.*  
- *Compared to B, X reduces P by × while matching quality on …*  
- *X obtains state-of-the-art on T1, T2, … including score (Δ).*  

### Style constraints (from top-venue analysis)

- Active voice: *We …*  
- Explicit contrast: *Unlike / Whereas / dispensing with / Compared to*  
- Prefer numbers over *significant / substantially* alone  
- Name the method early; reuse the name  
- No literature review; no hyperparameter laundry list  
- See `references/structure-and-style.md` for full analysis  

### Anti-patterns

- Abstract longer than the body contribution warrants  
- Claims not supported in Experiments/Method  
- “In this paper, we study…” with no gap or result  
- Marketing adjectives without mechanism  
- Copying sentences from `examples.md`  

---

## Step 5 — Self-review rubric

Before writing files, score the draft:

| Check | Action if fail |
|-------|----------------|
| Closed loop (problem→idea→result) | Add missing move |
| ≥1 concrete evidence (or theory two-fold claims) | Ask user for numbers or soften claim |
| Within length limit | Cut weakest sentence; merge clauses |
| Search keywords (task, method, benchmark) | Insert standard names |
| Consistent with GUIDANCE contributions | Align wording |
| No secret/private links | Remove |

Optional: compare length and density to the chosen exemplar (±20% words).

---

## Step 6 — Write into the paper repo

1. Locate abstract sink (priority order):
   - `paper/sections/abstract.tex` if `\input`’d  
   - `abstract` environment inside `paper/main.tex`  
   - path noted in `STRUCTURE.md`  
2. Replace placeholder / TODO with the final abstract text.  
3. Keep `% Theme` header comments if present; set `% Status: [x] drafted`.  
4. If `STRUCTURE.md` exists, mark Abstract done and note word count.  
5. Append a short entry to `GUIDANCE.md` §4 transcript:

```markdown
### YYYY-MM-DD — paper-abstract
- **Q:** (user request)
- **A:** Drafted abstract (~N words); exemplars: …
- **Guidance:** Numbers used: …; length limit: …
```

6. Compile if GUIDANCE says local TeX; do not fake Overleaf success.

### LaTeX shape

```latex
\begin{abstract}
% ... final paragraph(s) ...
\end{abstract}
```

Single paragraph is default for most ML templates; multi-paragraph only if the venue example uses it.

---

## Step 7 — Report to user

In Chinese (unless user writes English):

1. Final abstract (English) in a copy-paste block  
2. Word count vs limit  
3. Move map (1–6) one line each  
4. Which exemplars guided structure  
5. File path edited + compile status  
6. Risks: missing numbers, over-claim, need human polish  

Offer one **tighter** and one **more detailed** variant only if the user asks or length is borderline.

---

## Relationship to other skills

| Skill | Role |
|-------|------|
| `cs-paper-structure` | Venue, template, GUIDANCE, section skeleton |
| **`paper-abstract` (this)** | Abstract prose only |
| future `paper-intro` | Introduction (can share contribution bullets) |
| future `paper-polish` | Whole-paper language pass |

---

## References (must use)

- `references/structure-and-style.md` — structure + language analysis  
- `references/examples.md` — annotated top-paper abstracts  
