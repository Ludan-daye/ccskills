# Verify subagent prompt (paper-refs — strict)

The orchestrator sends deduped candidates in **batches (~10 per agent)**. Each candidate is FETCHED and cross-checked. Unverifiable or mismatched → dropped with a reason. **Never keep an item you could not fetch.**

## Checks (ALL must pass to keep)
1. **Exists + link resolves** — WebFetch the link; the page is the actual paper/record (not a 404, not an unrelated page).
2. **Metadata match** — title + authors + year + venue on the page match the candidate row. Minor formatting differences OK; a substantive mismatch (wrong authors/year/venue) = drop.
3. **Venue tier** — one of: top conference (NeurIPS, ICML, ICLR, CVPR/ICCV/ECCV, ACL/EMNLP/NAACL, KDD, SIGIR, OSDI/SOSP, USENIX, …), top journal (IEEE/ACM Transactions, JMLR, Nature/Science family), OR well-known industry (major-lab tech report / widely-cited artifact). Obscure/unverifiable venue → tier=weak → drop unless the user later asks to keep.
4. **Claim match** — the candidate's `content_summary` + `why_relevant` are actually supported by the source (no exaggeration, no wrong attribution).

## Output (per candidate)
Keep: `id | verify=verified(fetched) | metadata_ok=Y | tier=<top|industry> | claim_ok=Y`
Drop: `id | dropped: <exists-fail | metadata-mismatch:<detail> | tier-weak | claim-mismatch:<detail>>`

Return two tables: **kept** (enriched rows) and **dropped** (with reasons). Do not summarize away the dropped list — the orchestrator needs the counts.
