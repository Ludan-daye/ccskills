# table-style GREEN (with guide)

Isolated `/tmp/tbl-green` (skill + fixture). Agent followed `table-style.md` + paper-section "Any table". **PASS** — more disciplined than the probe prompt asked.

## RED-deviation → GREEN
| RED (unguided) | GREEN (guided) |
|----------------|----------------|
| `threeparttable` for notes | notes/legend in the **caption** (no threeparttable) |
| metrics-as-rows / methods-as-columns | **method column left, methods as rows**, metrics as columns |
| enrichment applied directly | **per-table gate**: proposed a fitting set (ours-color + arrows + small-delta + bold-best) with one-line reasons, explained why NOT heatmap/tiers (only 2 rows), emitted `TABLE_ENRICH_LOCK: CONFIRMED` |
| % deltas | absolute delta + direction arrow, per-metric direction semantics |

## Disciplines confirmed
- booktabs / no vertical lines / horizontal headers; caption **above** per IEEEtran GUIDANCE.
- **±std** on R1/R4 (multi-seed) each with `% src:`; R2/R3 point estimates (no std in the data).
- **Non-color-only**: row color paired with bold; every delta = color + arrow + number; grayscale/colorblind-safe; caption legend present.
- **Direction semantics (the key check):** R1 (PPL, lower-better) ours 6.42 **> baseline 6.30 → REGRESSION → red, not bolded** (baseline wins the column). It **refused the probe prompt's mistaken "R1 is a gain" hint**, computed the real sign, and said forcing green "would violate the never-exaggerated guardrail" — caught the controller's own error.
- **bold-best per column, computed** (did not blanket-bold the "ours" row).
- **PKG-NEEDED**: grep-verified no `\usepackage` in the fixture → flagged all needed packages (incl. `xcolor[dvipsnames]` for the named colors), left `main.tex` preamble untouched (paper-structure's turf).
- `needs-user` baseline name → used literal "FP16", not invented.

## REFACTOR: none — first-pass pass; exceeded the ask (caught a controller prompt error).

**Conclusion:** unguided, a careful agent gets the basics but diverges on venue conventions (threeparttable, transposed orientation) and skips the gate; guided, it puts notes in the caption, uses method-as-rows/left, runs the per-table enrichment gate, and enforces exact direction-semantics deltas + ±std + package declaration — **rich but reviewer-safe**.
