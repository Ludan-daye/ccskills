# figure-style RED baseline

Isolated `/tmp/fig-red` (fixture only, incl. `METHOD_NOTES.md` + `REPORT.md`), browsing outside `/tmp/fig-red` forbidden. Asked for a JSON design brief for the SlabQuant architecture figure — no guide.

## Soft baseline — careful agent + METHOD_NOTES's own markers
Produced a detailed, honest brief. Notably it **did NOT invent the latency** — it respected `METHOD_NOTES`'s explicit `NUM-NEEDED` and flagged it; also flagged the `needs-user` baseline name, the symbolic head-dim `d`, and the unlabeled R4 accuracy metric as gaps; sourced R1–R4 from REPORT; used a colorblind-ish palette paired with icons (padlock/pencil) + line styles. → The family's traceability infra (`NUM-NEEDED` propagating from METHOD_NOTES) helps even unguided.

## Deviations the guide corrects
1. **Its own ad-hoc JSON schema** (`meta`/`canvas`/`style_guide`/`components`/`data_flow`/…) — **NOT** the `figure-brief-template.json` shape the downstream generator expects.
2. **No two-part gate / `FIGURE_LOCK`** — emitted the brief directly.
3. **No explicit skeleton-by-contribution reasoning** (picked a left→right pipeline + inset without framing it by contribution type).
4. **Descriptive title** ("SlabQuant: Slab-Wise Buffering and Per-Slab Affine 4-bit KV Cache Quantization") rather than an argumentative claim.

→ GREEN must add: the **template shape**, the **layout+content gate (`FIGURE_LOCK`)**, **skeleton-by-contribution**, and an **argumentative title** — on top of the already-held traceability. (Soft RED, like method/table-style/related-work: modern careful agents do decent work; the guide guarantees the specific conventions + the gate + downstream-ready shape.)
