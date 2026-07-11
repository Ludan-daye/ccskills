# related-work writing RED baseline (no enhancement)

Isolated `/tmp/rw-red` (fixture only, no skill docs). Agent asked to draft Related Work from `paper/REFS_SHORTLIST.md`.

**Soft baseline:** given the fixture's angle-tagged `USER_SELECTION`, the no-skill agent already did well — two-part structure (lineage vs competing, inferred from the angle tags), cited only the 4 selected refs 1:1, real `\cite` keys, a real `refs.bib`, kept SlabQuant's own numbers out of the prose. The angle-tagged shortlist scaffolds most of the structure.

**But it skipped the skill's disciplines:**
1. **No gate.** Drafted directly — no content menu, no `CONTENT_LOCK`, no user confirmation.
2. **No comparison-table question.** Never asked whether to include a table.
3. **Reached outside the verified pipeline.** `REFS_SHORTLIST` has no authors column; the agent **fetched author names from arXiv** and filled the bib (flagged `% BIB-NOTE`) — instead of the skill rule (use `paper-refs` verified metadata; missing → `% BIB-INCOMPLETE`, don't reach out or invent).
4. No explicit examples-style posture-matching (decent positioning organically, but not by rule).

→ GREEN must show: menu→lock gate, table **asked**, `% BIB-INCOMPLETE` (not an external fetch), and examples-style soft-vs-sharp posture chosen by the real relationship.

(Honest note: this RED is soft — a careful agent given a good `REFS_SHORTLIST` already produces reasonable RW. The enhancement's value is the **mandatory gate + table-ask + stay-within-verified-metadata + summarized-style guidance**, not the two-part idea itself, which the angle tags already imply.)
