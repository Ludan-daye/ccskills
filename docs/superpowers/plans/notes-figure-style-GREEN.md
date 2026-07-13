# figure-style GREEN (with guide)

Isolated `/tmp/fig-green` (skill + fixture). Agent followed `figure-style.md` + `figure-brief-template.json` + paper-section "Any figure". **PASS** — impeccable, exceeded the ask.

## RED-deviation → GREEN
| RED (unguided) | GREEN (guided) |
|----------------|----------------|
| ad-hoc JSON schema | emitted in the **`figure-brief-template.json` shape** (`_note/type/instruction/style/layout{centerpiece{stages},sections}`) |
| no gate | **two-part gate**: layout proposal → content proposal (`NUM-NEEDED` called out) → `FIGURE_LOCK: CONFIRMED` → then JSON |
| no skeleton reasoning | chose **"system control-flow + zoomed mechanism inset"** with an explicit contribution-type justification (KV-cache write/read lifecycle) |
| descriptive title | **argumentative `main_title`** ("One fp16 window stays open at a time … bounding live memory while the rest of the KV cache is compressed at rest") |

## Disciplines confirmed
- **Traceability (impeccable):** every dim `% src: M1/M2`; results `% src: R1–R4`; **latency `NUM-NEEDED` everywhere — not invented**. Excluded `CLIP_Q=0.999` (present in code but absent from METHOD_NOTES' dims column → "not-yet-distilled"). Flagged R4 as REPORT-only (not in the survey claim table). Never asserted the `needs-user` baseline name.
- **Box names = mechanisms** (M1/M2/M3 → future Method subsections).
- **Palette = Okabe-Ito mapped to SlabQuant's OWN roles** (OPEN fp16 / SEALED 4-bit / M2 / M3), each color paired with icon + label — **non-color-only, colorblind-safe**.
- insight / comparison / results panels filled with sourced numbers; valid JSON (`json.tool`).

## REFACTOR: none — first-pass pass, exceeded the ask.

**Conclusion:** unguided, a careful agent gets honest content (helped by METHOD_NOTES's `NUM-NEEDED` markers) but produces its own schema, skips the gate, and gives a descriptive title; guided, it emits the specified template shape, runs the layout+content gate with `FIGURE_LOCK`, reasons the skeleton from the contribution type, writes an argumentative title, and maps a colorblind palette to the paper's own roles — a downstream-generator-ready, fully-traceable brief.
