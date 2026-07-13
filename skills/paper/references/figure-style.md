# Figure style — shared guide (paper architecture/overview figures)

Output: a structured **figure-brief** (`paper/FIGURE_BRIEF_<name>.json`, schema = `figure-brief-template.json`) for a downstream image/diagram generator — **not a rendered image**. Used by Method (overview figure) and any `% FIG`.

Evidence: 6 venue-verified top-venue architecture figures (SAM ICCV'23, SAM2 ICLR'25, ControlNet ICCV'23, DPO NeurIPS'23, Self-RAG ICLR'24, vLLM SOSP'23).

## What is learned from where
| source | learn |
|--------|-------|
| user JSON (`figure-brief-template.json`) | **FORMAT / field schema only** — not any example's content |
| research examples + contribution type | **LAYOUT**: skeleton, panels, where novelty goes, color/icon conventions |
| `METHOD_NOTES` / survey / Method subsections | **CONTENT**: components, dims, latency, result numbers, box names |

## Skeleton — choose by contribution type (not a default)
- multi-branch → fusion (heterogeneous inputs)
- base pipeline + temporal feedback loop (sequence/video extension)
- frozen backbone + trainable copy + special connector (adapter/control/finetune)
- baseline vs proposed side-by-side (contribution simplifies/removes steps)
- inline-decision flowchart (decoding-time/agentic control)
- system control-flow + separate zoomed mechanism figure (systems)

`centerpiece` = the chosen backbone; `sections` panels (insight / comparison / results) added as they fit.

## Conventions (from the examples)
- **Box name = Method subsection heading** (6/6 — strongest convention); lets the reader jump figure→text.
- Mark novelty by **naming / isolation / omission** (the only new-labeled box; a zoom-in inset; before/after "missing step"; an inline arrow symbol) — not just center-placement or color.
- **Block/module level, not code**; tensor shapes only where they add info (headline figure stays clean).
- **Frozen/reused = muted + lock/snowflake icon; new/novel = distinct outline/callout.**
- **`main_title`/caption does argumentative work** (states the claim: what's frozen, what's avoided) — never "diagram of X".

## Content sourcing + traceability (the big guardrail)
- Component names / dims / latency ← `paper/METHOD_NOTES.md` (`source_path`); result numbers ← survey `claim_id`.
- **Every number in the brief is traceable** (`% src: <claim_id>` or a METHOD_NOTES id) **or marked `NUM-NEEDED`** — never invented or guessed. (The user's filled example is a fully-sourced paper; the rule is source-or-mark.)
- Box names 照 `TERMS.md`; do not invent components absent from METHOD_NOTES. Missing METHOD_NOTES → run method-dig first / ask the user.

## Style defaults
Okabe-Ito colorblind-safe palette; **assign colors to THIS paper's semantic roles** (don't reuse another paper's mapping); pair color with icon/label (**non-color-only**, grayscale-safe); geometric sans + monospace tensors + small-caps headers; rounded blocks + snowflake/padlock = frozen. (`{argument default=...}` overridable.)

## Two-part gate (FIGURE_LOCK — before generating)
1. **Layout**: propose skeleton + which panels + component positions + enrichment (highlight / zoom-in inset / before-after / frozen icons) → user edits/confirms.
2. **Content**: propose what fills each slot (stages + dims, insight, comparison gained/lost, which result numbers + their sources) → user confirms; call out every `NUM-NEEDED`.
3. Both confirmed → `FIGURE_LOCK: CONFIRMED` → **then** emit the JSON figure-brief.

## Anti-patterns
- Inventing dims/latency/results to fill the pretty template.
- Copying the example paper's stages / palette-role-semantics / panels.
- Box names not matching Method subsections; code-level detail in the figure.
- Emitting the brief before the two-part gate.

## Sources (venue-verified; structural paraphrase, no copied sentences)
SAM (ICCV'23), SAM2 (ICLR'25), ControlNet (ICCV'23), DPO (NeurIPS'23), Self-RAG (ICLR'24), vLLM (SOSP'23).
