# paper-refs GREEN (smoke) — with skill

Isolated env `/tmp/refs-green` (skill copy + seed survey: direction = slab-wise 4-bit KV-cache quantization, `paper_type: efficiency`). Agent followed `paper-refs` at smoke-scale (raw ~15 / pool ~8). **PASS.**

## RED gap → GREEN outcome
| RED gap | GREEN |
|---------|-------|
| No `paper_type`/angle taxonomy | `efficiency` → 成果/方法型 → angles **lineage + competing** (per `type-strategies.md`) |
| No fan-out / over-collect | 4 facets (2 lineage + 2 competing), raw = 16 |
| No dropped/quarantine log or counts | **collected 16 → verified 14 → dropped 2**, each drop logged: GEAR = NeurIPS *workshop* not main track; WKVQuant = preprint, no confirmed top-venue → both `tier-weak` |
| No user gate | shortlist 8 proposed, balanced by angle; `USER_SELECTION` left **NOT CONFIRMED** — stopped at the gate |
| Opportunistic verification | **WebFetch'd all 16 links** + 6 follow-up venue searches; kept only fetched + tier-OK + claim-matched |

## Discipline confirmed
- **Zero fabrication:** all 14 kept are real, fetched, correctly-linked (lineage: GPTQ / AWQ / SmoothQuant / LLM.int8() / PagedAttention / GQA / MQA; competing: KIVI / KVQuant / Atom / FlexGen / H2O / StreamingLLM / SnapKV).
- Angle classification applied (lineage = 7, competing = 7).
- `REFS_POOL.md` + `REFS_SHORTLIST.md` written per schema, with `collected→verified→dropped` counts + gate.
- Strict tier bar working: dropped a NeurIPS *workshop* paper and an unaccepted preprint with transparent reasons — matches the "顶会顶刊" requirement.

## REFACTOR: none needed — complied on the first pass. `refs/SKILL.md` unchanged.

**Conclusion:** without the skill, a (careful) agent self-selects an ad-hoc list with no gate and opportunistic verification; with the skill it is type-driven, fetch-verifies every item with a logged dropped list, classifies by angle, and stops at the user gate. The skill demonstrably changes behavior. (Smoke-scale used ~15/~8 in place of ≥100/≥80; the discipline judged — not the raw count — is what GREEN validates.)
