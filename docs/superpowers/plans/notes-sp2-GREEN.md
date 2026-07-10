# SP2 GREEN validation — 5 section deep-dives

Isolated env: skill + fixture copied to `/tmp/sp2-green` (as-if-installed). For each section an agent followed `paper-section` + `sections/<S>.md` to draft that section on the fixture (menu → `CONTENT_LOCK` → concise draft), returning LaTeX only, no writes. **All 5 PASS.**

| Section | Gate | Numbers | needs-user (T3 baseline) | Citations / figures | Verdict |
|---------|------|---------|--------------------------|---------------------|---------|
| introduction | menu + LOCK | none literal; R1/R2/R3 as `% NUM-NEEDED` forward-refs (Intro "no result numbers" rule) | generic "fp16", canonical name not invented | `\cite{TODO:}`+`% CITE-NEEDED` | PASS |
| related-work | menu + LOCK | `Numbers: 无` (results belong to Experiments) | `TODO-BASELINE-NAME` + `% NEEDS-USER` | 2× `% CITE-NEEDED`, zero fabricated cites | PASS |
| experiments | menu + LOCK | R1/R2/R3 each `% src: <claim_id> (path)`, verbatim; **no extras** | `[NEEDS-USER: baseline display name]`, not resolved to "FP16" | `% TAB-NEEDED`; ablations not fabricated | PASS |
| limitations | menu + LOCK | R1 (+0.12 PPL) `% src:`; R2/R3 only via `\ref` | generic "fp16" | `% NUM-NEEDED` for dequant overhead | PASS |
| conclusion | menu + LOCK | none literal; qualitative echo only | T3 excluded, not named | `\ref{sec:experiments}` only (not `sec:intro` — doesn't exist yet) | PASS |

**Standout discipline:** `experiments` *refused* to write "3-seed mean / A100 / batch 32" as prose — those appear in `REPORT.md`'s note column but have no `claim_id` in the survey — marking them `% NUM-NEEDED` instead. Strictest correct reading of "numbers only from survey claim_ids".

**Cross-cutting:** every probe presented a survey-cited content menu + `CONTENT_LOCK` before prose, traced or flagged every number, never invented the `needs-user` baseline name, used placeholder conventions for citations/figures, and honored section-specific rules (no result numbers in Intro/Conclusion; numbers land only in Experiments; heavy `CITE-NEEDED` in Related Work). Several probes also correctly declined to wire `main.tex` (paper-structure's domain).

**REFACTOR:** none needed — all 5 complied on the first pass.
