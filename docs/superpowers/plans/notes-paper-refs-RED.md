# paper-refs RED baseline (pre-skill behavior)

Prompt (isolated, no skill): *"collect ~15 related-work references for a paper on KV-cache quantization for LLM inference; table title|authors|year|venue|link|why."*

## What the no-skill agent did
- Drafted ~15 papers **from domain memory**, then spot-checked each with `WebSearch` (9 searches) + 1 `WebFetch`. Produced 15 real, correctly-linked papers (GPTQ, SmoothQuant, AWQ, FlexGen, H2O, KIVI, KVQuant, GEAR, QServe, ZipCache, Coupled Quantization, …).
- Memory-first drafting: it caught a real error only on re-check (item 15's title/arXiv id was mis-recalled). Even careful ad-hoc verification is fallible — a lazier/unequipped agent would fabricate outright.

## Gaps vs the paper-refs design (what the skill must add)
1. **No `paper_type` → angle taxonomy.** Picked a "topically-sensible mix" by judgment; no `lineage`/`competing`/`foundation`/`prior-result` classification.
2. **No fan-out / over-collect.** Single-pass ~15 to target; no raw ≥100 to survive verification attrition.
3. **No dropped/quarantine log or counts.** Silently omitted anything unconfirmed; no `collected → verified → dropped` record.
4. **No user gate.** Presented the final table directly as "the citations" — no shortlist proposal awaiting `USER_SELECTION: CONFIRMED`.
5. **Verification is opportunistic, not mandatory-per-item.** Spot-checks, not fetch-or-drop for every candidate.

→ GREEN must show: type→angle strategy, fan-out over-collect, **mandatory per-item WebFetch-or-drop with a logged dropped list + counts**, angle classification, and a **user-gated** shortlist.

(Note: the baseline agent was a careful sonnet with web tools, so it was already partly disciplined — the skill's value is in making type-strategy, over-collect+dropped-log, and the user gate **mandatory and structured** rather than left to the agent's judgment.)
