# Paper Section Deep-Dives (SP2) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: superpowers:subagent-driven-development.

**Goal:** Fill the 5 remaining per-section deep-dive docs under `skills/paper/references/sections/` — `introduction.md`, `related-work.md`, `experiments.md`, `limitations.md`, `conclusion.md` — following the `_TEMPLATE.md` shape and the proven `method.md` exemplar, so `paper-section` loads real depth for every body section.

**Architecture:** Each doc expands `section-themes.md`'s compact row for that section into the 10-heading `_TEMPLATE` structure. These are **generic writing guidance** (how to write section S for any CS paper) — no paper-specific content, no fabrication risk in the docs themselves. The `paper-section` engine is unchanged (it already loads `sections/<name>.md` on demand). Every doc is GREEN-validated by having `paper-section` + the new doc draft that section on the isolated fixture.

**Tech Stack:** Markdown, subagent GREEN probes, git. **Branch:** `paper-sp2-sections` → merge `main` when done.

**Reference exemplar:** `skills/paper/references/sections/method.md` (10 headings). **Source rows:** `skills/paper/references/section-themes.md` (one `##` row per section).

---

## Shared per-section procedure (Tasks 1–5)

For section **S**, write `skills/paper/references/sections/<S>.md` filling **all 10** `_TEMPLATE.md` headings, in order:

1. `## Theme` — one-line mission (from `section-themes.md` <S> row).
2. `## Role in the paper` — what S contributes to the claim→evidence loop; upstream deps / downstream consumers.
3. `## Move order` — the ordered steps (from the <S> row's move order).
4. `## Must include` — bullets (from the row's Must-include).
5. `## Must not` — bullets (from the row's Must-not).
6. `## Common mistakes → fix` — table of ≥3 smell→fix rows, section-specific.
7. `## Claim → evidence mapping` — what numbers/claims belong in S and the traceability rule (`% src: <claim_id>` / `% NUM-NEEDED`).
8. `## Length guidance` — typical pages/paras (from the row's typical length) + how to cut under a page limit.
9. `## Micro-example (structure only)` — a `\section{...}\label{sec:...}` skeleton with `% move` comments and placeholder conventions; **no copyable prose sentences**.
10. `## Done-when checklist` — aligned to the row's Done-when + "numbers carry `% src:`" + "terms from TERMS.md" + "citations/figures use placeholders".

Content is generic and section-appropriate; do NOT invent facts, and do NOT write paper-specific prose. Match `method.md`'s depth and tone.

**Verify (each):** `diff <(grep '^## ' _TEMPLATE.md) <(grep '^## ' <S>.md)` → empty (10-heading parity). **Commit:** `Add sections/<S>.md deep dive`.

---

## Tasks

### Task 1: `introduction.md`
Theme: narrative + testable contributions. Move order: motivation → gap → high-level idea → contributions list → optional roadmap. Must-not: full method detail; RW-style survey. Claim→evidence: Intro states contributions (no result numbers); any forward-referenced metric stays un-valued or `% src:`.

### Task 2: `related-work.md`
Theme: positioning & differentiation. Move order: topic clusters → same/different axes → closest baselines. Emphasize: since a research repo often lacks a prior-work list, prior-work claims use `\cite{TODO:...}` + `% CITE-NEEDED`; never fabricate citations. Must-not: uncritical laundry list; missing direct competitors.

### Task 3: `experiments.md` (highest-risk — numbers live here)
Theme: evidence for claims. Move order: protocol/data/baselines → main results → ablations/analysis. Claim→evidence: **result numbers belong in this section**, each tagged `% src: <claim_id> (path)` traced to the survey; do NOT invent numbers beyond survey claim_ids; a `needs-user` baseline name → ask, not invent. Must: each major claim maps to a table/figure (`% TAB-NEEDED`/`% FIG-NEEDED`).

### Task 4: `limitations.md`
Theme: failure modes & scope. Move order: honest assumptions → data/compute limits → negative findings. Must-not: fake humility; pure future-work marketing.

### Task 5: `conclusion.md`
Theme: close the loop. Move order: problem/method recap → findings → contribution echo → restrained outlook. Must-not: new experimental claims. Done-when: consistent with Abstract/Intro.

---

## Task 6: GREEN validation (all 5, per user choice)

For each S, run an isolated probe: copy the current skill tree + fixture to `/tmp` (as in SP1's GREEN), have an agent follow `paper-section` + `sections/<S>.md` to draft S for the fixture (return LaTeX, do not write). **Assert:**
- Presents a survey-cited content menu + `CONTENT_LOCK` gate before prose.
- Any number carries `% src: <claim_id>`; nothing beyond survey claim_ids; `needs-user`/missing → marked, not invented.
- Prior-work claims → `\cite{TODO:...}` + `% CITE-NEEDED`; figures/tables → `% FIG-NEEDED`/`% TAB-NEEDED`.
- `% Status` flipped; Phase-5 self-check run.

`experiments` is the key check: R1/R2/R3 appear **with `% src:`**, no extra invented metrics. Probes may run in parallel (each returns LaTeX, no shared writes). Record to `docs/superpowers/plans/notes-sp2-GREEN.md`. Any failure → refine that doc and re-probe (REFACTOR).

---

## Done-when
1. All 5 docs exist, each with 10-heading parity vs `_TEMPLATE.md`.
2. All 5 GREEN probes pass (gate + traceability + no fabrication); `experiments` cites R1/R2/R3 with `% src:`.
3. `notes-sp2-GREEN.md` records the runs.
4. Merged to `main`.

## Out of scope (YAGNI)
- No `paper-section` engine change (already loads `sections/<name>.md`).
- No new sibling skill (that is SP3).
- No real citation/figure content (placeholders only).
