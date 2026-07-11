# related-work writing GREEN (with enhancement)

Isolated `/tmp/rw-green` (enhanced skill + fixture). Agent followed `paper-section` related-work special case + `related-work.md` + `related-work-examples.md`. **PASS.**

## RED gap → GREEN
| RED gap | GREEN |
|---------|-------|
| No gate | content menu (two parts by angle) + `CONTENT_LOCK` before any prose |
| No table question | **asked** "要不要 prior-work 对比表?" → simulated 「不要」 → skipped |
| Reached outside pipeline for authors | `author = {}` + `% BIB-INCOMPLETE: author` on all 4 (did NOT fetch or invent) |
| No examples-style | **posture matched to relationship**: PagedAttention framed complementary/orthogonal (soft), KIVI/KVQuant as competitors (sharp same/different, named closest baselines, higher density) — per the summarized flexible style |

## Discipline confirmed
- Two-part by angle: Part 1 lineage {P01 GPTQ, P05 PagedAttention}, Part 2 competing {P08 KIVI, P09 KVQuant}.
- Only `USER_SELECTION` cited; every `\cite{key}` 1:1 with a `refs.bib` entry (grep cross-checked).
- bibstyle IEEEtran respected; entries carry IEEEtran fields; missing author/pages → `% BIB-INCOMPLETE` (not invented).
- No own-paper numbers in prose (table declined).
- `% Status` flipped `[ ]`→`[x]`; flagged RW-vs-Experiments closest-baseline cross-check as OPEN (experiments.tex still empty) rather than assuming.

## REFACTOR
Fixture `REFS_SHORTLIST` lacks an authors column (the real `REFS_POOL` carries authors), so the agent couldn't form `<firstauthor><year><word>` keys → it used a title-derived token + `% BIB-INCOMPLETE: author`. Correct (no invention). **Codified this fallback in `related-work.md`** so it's deterministic: when authors are absent, use a title-token key + mark `% BIB-INCOMPLETE`, and re-run `paper-refs` to source authors — never fill from outside the verified pipeline.

**Conclusion:** without the enhancement, a careful agent drafts directly, skips the gate/table-ask, and reaches outside the repo for bib fields; with it, the agent gates, asks about the table, stays within verified metadata (`% BIB-INCOMPLETE`), and matches contrast posture to the real relationship per the summarized style.
