# table-style RED baseline

## RED v1 — /tmp fixture but agent reachable to the real repo (contaminated, discarded)
Probe ran in `/tmp/tbl-red` (fixture only) but browsed the actual `ccskills` tree, found `table-style.md` + the spec, and read them → output already followed the guide (booktabs, correct delta direction, ±std, caption legend, `% PKG-NEEDED`). RED ≈ GREEN → invalid. Same lesson as paper-section RED v1: a *reachable* guide gets discovered. (It did independently flag PPL as a regression — a point for the direction-semantics rule being natural to a careful agent.)

## RED v2 — inline data, filesystem access forbidden (valid)
Numbers pasted inline + "do not read files". The unguided output was a careful table but with real, guide-correctable deviations:
1. **Used `threeparttable`** for notes — the guide forbids it (0/6 top venues); notes/legend belong in the **caption**.
2. **Transposed layout**: metrics-as-rows / methods-as-columns (`Metric | FP16 | Ours | Δ`) — opposite of the 6/6 convention (**method column on the LEFT, methods as rows**, metrics as columns).
3. **No per-table enrichment gate** — applied enrichment directly, no propose → user-confirm.
4. Deltas as **percentages** (+1.9% / −73.7% / +90%) rather than absolute delta + direction arrow.

Did well unguided (careful sonnet): booktabs no-vlines, horizontal headers, honestly flagged PPL as a loss (amber, not bolded for ours), colorblind double-encoding (color + ✓/∼), ±std shown, packages declared.

→ GREEN must enforce: **notes-in-caption (no threeparttable)**, **method-as-rows/left orientation**, the **per-table enrichment gate** (propose → lock), and **consistent direction-arrow deltas** — on top of the disciplines a careful agent already does. (Like method/related-work, this RED is "soft": modern careful agents produce decent tables; the guide's job is guaranteeing the specific top-venue conventions + the gate, not preventing disaster.)
