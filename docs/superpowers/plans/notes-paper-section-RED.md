# paper-section RED baseline (pre-skill behavior)

Two baseline runs drafting the **Method** section of the FastKV/SlabQuant fixture **without** the `paper-section` skill.

## RED v1 — fixture in-repo (contaminated, discarded)
Given the fixture at `skills/paper/section/references/fixture/`, the no-skill agent discovered the skill's own convention docs (`references/sections/method.md`, `storage-framework.md`, the spec) and followed them unprompted → output already disciplined (no result numbers in Method, respected `needs-user` baseline, used `% src:`/`% CITE-NEEDED`/`% FIG-NEEDED`). RED ≈ GREEN → invalid.
**Lesson:** co-locating the fixture with the conventions contaminates the baseline; run RED against an isolated copy. (Also argues the shipped fixture should not sit inside the skill's `references/` — see final review. Resolved: fixture relocated to `test/fixtures/paper-section/`, outside any shipped skill tree.)

## RED v2 — isolated /tmp copy (valid)
Fixture copied to `/tmp/paper-red-fixture`, no access to skill docs. Failures surfaced:
1. **No gate.** Drafted the whole Method directly — no content menu, no `CONTENT_LOCK`, no user confirmation.
2. **Result numbers leaked into Method without traceability.** Closing sentence pulled R1 (+0.12 PPL), R2 (3.8×), R3 (1.9×) into Method — violates Method "no result numbers" and the `% src:` number-traceability rule (none present).
3. **No citation placeholders.** Prior-work claims ("a simple baseline quantizes … which wastes precision") went uncited and unmarked (no `% CITE-NEEDED`).

Correct behavior: did **not** fabricate a name for the `needs-user` baseline even when isolated (a point for the model's care, not evidence the skill is unneeded).

## What `paper-section` must enforce (→ GREEN checks)
- Survey-cited **content menu** + **HARD GATE** (`CONTENT_LOCK`) before any prose.
- Result numbers stay in Experiments; any in-section number carries `% src: <claim_id> (path)` or `% NUM-NEEDED`.
- Prior-work claims use `\cite{TODO:...}` + `% CITE-NEEDED`.
- `needs-user` terms → ask, never invent.
