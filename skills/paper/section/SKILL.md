---
name: paper-section
description: >
  Use when drafting or revising a body section of a CS paper — 写正文,
  写 intro/related work/method/experiments/limitations/conclusion 某一节.
  Not for the abstract (paper-abstract) or scaffolding (paper-structure).
---

# Paper Section (child of `paper`)

**Parent:** `paper` — owns repo scan → `PAPER_REPO_SURVEY.md` + seeds `TERMS.md`/`STATE.md`.
Draft **one body section at a time** into the LaTeX. Same menu→lock→write gate as `paper-abstract`.

**REQUIRED BACKGROUND:** `../references/storage-framework.md` (占位约定 / 写入归属 / 状态).

## Flow

```text
Phase 1  Ensure survey + GUIDANCE + TERMS; pick section
Phase 2  Content menu (from survey, path-cited)
Phase 3  CONTENT_LOCK  ← HARD GATE
Phase 4  Write prose into the .tex
Phase 5  Self-check + report
```

## Phase 1 — Locate & pick
1. Resolve ROOT. Read `paper/PAPER_REPO_SURVEY.md` (missing/stale → run parent `paper` Phase S first), `paper/GUIDANCE.md`, `paper/TERMS.md`.
2. **Pick section:** scan `paper/sections/*.tex` for `% Status: [ ] not drafted` and list them; or take the section the user named.
3. Load `../references/section-themes.md` (always) + `../references/sections/<name>.md` (if present; else fall back to the index row).

## Phase 2 — Content menu
Build selectable items citing survey `claim_id` + path. Each row: `ID | 一句话 | 来源路径 | 建议`.
Numbers only from survey claim_ids. Terms only from `TERMS.md`; a `needs-user` term → ask, do not invent.

## Phase 3 — HARD GATE
```markdown
# CONTENT_LOCK (section=<name>)
- Included: …
- Numbers (value ← claim_id ← path): …
- Terms used (← TERMS.md): …
- Status: CONFIRMED
```
No prose before CONFIRMED.

## Phase 4 — Write
- Edit only `paper/sections/<name>.tex`. Follow that section's **Move order** from themes/deep-dive.
- Every number inline `% src: <claim_id> (path)`; unbacked → `% NUM-NEEDED`, do not write it.
- Citations `\cite{TODO:...}` + `% CITE-NEEDED`; figures/tables `% FIG-NEEDED`/`% TAB-NEEDED` + `\ref{fig:TODO-...}`.
- Flip `% Status:` → `[x] drafted`. Refresh `paper/STATE.md` sections line.

## Phase 5 — Self-check + report
- Run the section's **Done-when** checklist + "every number traces to survey".
- If GUIDANCE page limit known and the draft looks over budget, warn (do not hard-truncate).
- Report: section, claim_ids used, files touched, any `needs-user`/`NUM-NEEDED`/`CITE-NEEDED` left open.

## Related-work special case
When the picked section is **related-work**, additionally (see `../references/sections/related-work.md`):
- Read `paper/REFS_SHORTLIST.md` `USER_SELECTION` (missing/not `CONFIRMED` → run `paper-refs` first). Structure = one part per collected angle (lineage/competing, …).
- Emit **real `\cite{key}`** (not `\cite{TODO:}`) for selected refs; append a matching BibTeX entry to `paper/refs.bib` (bib key rule + venue bibstyle — see `../references/storage-framework.md`).
- At the CONTENT_LOCK step, **ask the user whether to include the optional comparison table**.
- Only `USER_SELECTION` refs; every `\cite{key}` must have a `refs.bib` entry.

Other sections keep `\cite{TODO:...}` + `% CITE-NEEDED` (no bib).

## Method special case
When the picked section is **method** (see `../references/sections/method.md`):
- First dispatch a read-only **method-dig** subagent (`../references/method-dig-prompt.md`) → `paper/METHOD_NOTES.md` (ideas not code; inferred items = `needs-confirm`).
- Structure = small overview + **one `\subsection` per innovation point**. Present the innovation-point list (name | principle | source_path | core/minor | needs-confirm) → user edits → **INNOVATION_LOCK** (hard gate; needs-confirm items must be individually confirmed).
- Then scaffold the frame on disk (overview + per-innovation skeletons), show it (soft check), and write **one subsection per run** by default; `% Status(sub:<slug>)` per subsection.
- **Zero experimental content**; no code-level narration; every formula gets substantial prose and passes multi-agent formula verification (`% FORMULA-CHECK` for issues); formulas trace to METHOD_NOTES/user-confirmed input only.

## Any table (all sections)
When emitting ANY LaTeX table, follow `../references/table-style.md`: booktabs (no vertical lines), horizontal headers, notes in caption; caption position per venue; `±std` when multi-seed. **Enrichment is per-table:** judge which of color/font-color/arrows/small-delta/tiers fit THIS table, propose them to the user (`TABLE_ENRICH_LOCK`), apply only what's confirmed — never color-only, always caption-legended, deltas computed from traceable numbers, required LaTeX packages declared or `% PKG-NEEDED`.

## Hard rules
1. One section per run; edit only that section's `.tex`.
2. **No invented numbers, terms, citations, figures.** Missing → mark + ask.
3. No final prose before CONTENT_LOCK.
4. No unsolicited git push.
5. Chinese discussion; English LaTeX.

## Anti-patterns
- Writing prose before the lock.
- Numbers absent from `PAPER_REPO_SURVEY.md`.
- Inventing a `needs-user` term instead of asking.
- Editing main.tex preamble (that is paper-structure's).

## References
- Parent: `../SKILL.md`
- `../references/storage-framework.md`, `../references/section-themes.md`, `../references/sections/<name>.md`
