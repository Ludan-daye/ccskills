# Figure Style (SP7) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax.

**Goal:** Add `figure-style.md` + a generalized `figure-brief-template.json` so the skill produces a structured, traceable, user-gated **figure-brief** (for a downstream image generator) for a paper's architecture/overview figure.

**Architecture:** New `figure-style.md` (guide) + `figure-brief-template.json` (format/schema only, style-arg defaults = research conventions); Method's overview figure + `paper-section` emit a figure-brief via a two-part (layout+content) gate; `storage-framework.md` records the artifact; fixture gains a `METHOD_NOTES.md` so figure content has a traceable source; RED→GREEN.

**Tech Stack:** Markdown SKILL docs, JSON template, subagent probes, git. Spec: `docs/superpowers/specs/2026-07-13-paper-figure-style-design.md`.

**Branch:** `paper-figure-style` → merge `main` when done (hold push). Repo root: `/root/ludandaye/program/Skills/paperSkill/ccskills`. Commit locally, don't push. `% src:`/`NUM-NEEDED`/`{argument …}` are intentional.

---

## Task 1: `figure-brief-template.json` (FORMAT/schema only)

**Files:** Create `skills/paper/references/figure-brief-template.json`

- [ ] **Step 1: Write the file** — exact content (generalized: style args carry research-convention defaults; layout slots are placeholders — NOT any example paper's content):

```json
{
  "_note": "FORMAT / field-schema ONLY. Layout & content are filled per paper from the research examples (skeleton, panels) + METHOD_NOTES/survey (components, dims, numbers). The style args carry research-convention defaults (overridable). Do NOT copy any example paper's specific stages, numbers, or color-role semantics.",
  "type": "<figure type, e.g. Method-overview figure (a paper's Figure 1)>",
  "instruction": "{argument name=\"instruction\" default=\"Design ONE clean, publication-quality framework figure explaining the method. Modular data-flow backbone (labeled component blocks joined by directed arrows), plus the panels chosen at the layout gate. Schematic and rigorous, not decorative: every block, arrow, and glyph carries information; annotate tensor dimensions and latency only where they are sourced. Favor clarity, alignment, and generous whitespace over ornamentation.\"}",
  "style": {
    "render": "{argument name=\"render style\" default=\"clean modern scientific schematic; flat vector with light isometric depth and soft ambient shadows; crisp thin strokes; generous whitespace\"}",
    "palette": "{argument name=\"palette\" default=\"muted, colorblind-safe (Okabe-Ito); assign colors to THIS paper's own semantic roles (do NOT reuse another paper's mapping); every color paired with an icon or label (never color-only); neutral grays for ordinary modules\"}",
    "typography": "{argument name=\"typography\" default=\"clean geometric sans-serif; monospace for tensors/dimensions; small-caps section headers\"}",
    "modules": "{argument name=\"module style\" default=\"rounded rectangular blocks with subtle depth and hairline borders; a snowflake/padlock icon marks frozen (non-trainable) components\"}"
  },
  "layout": {
    "main_title": "<argumentative title stating THIS paper's claim (not 'diagram of X')>",
    "centerpiece": {
      "position": "<primary data-flow position/direction set by the chosen skeleton>",
      "description": "<end-to-end pipeline; annotate dims/latency ONLY where traceable to METHOD_NOTES/survey (% src:), else NUM-NEEDED>",
      "count": "<number of stages>",
      "stages": ["<NN stage-name — component (dims) [% src: <id> | NUM-NEEDED]>"]
    },
    "sections": [
      {"position": "<e.g. left panel>", "title": "<insight: why it works>", "description": "<mechanism/geometry, block-level>", "count": "<n>", "labels": ["<label>"]},
      {"position": "<e.g. top-right>", "title": "<comparison: gained vs lost>", "items": ["<+ what the design gains>", "<- what the alternative loses>"]},
      {"position": "<e.g. bottom band>", "title": "<evaluation & headline results>", "count": "<n>", "blocks": ["<result block; every number % src: <claim_id> or NUM-NEEDED>"]}
    ]
  }
}
```

- [ ] **Step 2: Verify.** Run: `python3 -c "import json;d=json.load(open('skills/paper/references/figure-brief-template.json'));print('valid json; keys:', list(d))"` → Expected: `valid json; keys: ['_note', 'type', 'instruction', 'style', 'layout']`. And `grep -c "argument name\|NUM-NEEDED\|colorblind-safe" skills/paper/references/figure-brief-template.json` → ≥ 3.
- [ ] **Step 3: Commit.** `git add skills/paper/references/figure-brief-template.json && git commit -m "Add figure-brief-template.json (format/schema, research-convention style defaults)"`

---

## Task 2: `figure-style.md` (the guide)

**Files:** Create `skills/paper/references/figure-style.md`

- [ ] **Step 1: Write the file** — exact content:

````markdown
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
````

- [ ] **Step 2: Verify.** Run: `grep -c "^## " skills/paper/references/figure-style.md` → ≥ 7. And `grep -c "FIGURE_LOCK\|Box name = Method\|NUM-NEEDED\|figure-brief-template\|colorblind" skills/paper/references/figure-style.md` → ≥ 5.
- [ ] **Step 3: Commit.** `git add skills/paper/references/figure-style.md && git commit -m "Add figure-style.md (skeleton by contribution + traceable content + two-part gate + guardrails)"`

---

## Task 3: Wire consumers

**Files:** Modify `skills/paper/references/sections/method.md`, `skills/paper/section/SKILL.md`, `skills/paper/references/storage-framework.md`

- [ ] **Step 1: method.md** — in the `## Formula discipline (公式纪律)` section's figure line area, OR under `## Move order` where overview/`fig:TODO-overview` is mentioned, add a bullet:
```markdown
- overview 架构图 → 产一份 **figure-brief**（走 `../figure-style.md`：按贡献选骨架、box 名=小节名、内容溯源 `% src:`/`NUM-NEEDED`、两段门禁），而非仅一句 `% FIG-NEEDED`。
```
- [ ] **Step 2: paper-section/SKILL.md** — insert after the `## Any table (all sections)` block (before `## Hard rules`):
```markdown
## Any figure (architecture/overview)
When a section needs an architecture/overview figure, follow `../references/figure-style.md`: choose the skeleton by contribution type; box names = Method subsection headings; components/dims/latency from `paper/METHOD_NOTES.md`, result numbers from survey `claim_id` — every number `% src:` or `NUM-NEEDED`, **never invented**. Run the **two-part gate** (propose layout, then content → user confirms → `FIGURE_LOCK`), then emit a structured figure-brief to `paper/FIGURE_BRIEF_<name>.json` (schema `../references/figure-brief-template.json`). Colorblind-safe, non-color-only; `main_title`/caption states the claim. This produces a brief for a downstream generator — not a rendered image.
```
- [ ] **Step 3: storage-framework.md** — add a row in the `## 1. 用户仓库侧` table, after the `METHOD_NOTES.md` row:
```markdown
| `FIGURE_BRIEF_<name>.json` | paper-section (figure) | 下游图像/画图生成器 | 架构图 brief（figure-style schema）；数字溯源 `% src:`/`NUM-NEEDED`；两段门禁 `FIGURE_LOCK` 后生成；只产 brief 不渲染 |
```
- [ ] **Step 4: Verify + commit.** Run: `grep -c "figure-style\|figure-brief\|FIGURE_LOCK" skills/paper/references/sections/method.md skills/paper/section/SKILL.md skills/paper/references/storage-framework.md | ...` (confirm all three touched); `grep -l "figure-style\|figure-brief" skills/paper/references/sections/method.md skills/paper/section/SKILL.md skills/paper/references/storage-framework.md | wc -l` → 3.
```bash
git add skills/paper/references/sections/method.md skills/paper/section/SKILL.md skills/paper/references/storage-framework.md
git commit -m "Wire method/paper-section/storage-framework to figure-style (figure-brief + two-part gate)"
```

---

## Task 4: Fixture `METHOD_NOTES.md` (traceable source for figure content)

**Files:** Create `test/fixtures/paper-section/paper/METHOD_NOTES.md`

- [ ] **Step 1: Write the file** (dims from-repo; latency NUM-NEEDED — so GREEN must mark it):
```markdown
# METHOD_NOTES
- dug_at: 2026-07-13 / scanner: fixture-seed
## Mechanisms
| id | 思路/机制描述 (principle) | dims/notation | source_path | status |
|----|--------------------------|---------------|-------------|--------|
| M1 | slab partitioning: buffer fp16 K/V until S tokens, then seal one slab | S=64 tokens/slab; head dim d | code/slabquant.py | from-repo(code/slabquant.py) |
| M2 | per-slab affine 4-bit quantization from the slab's own clipped range | b=4 bit; codes + (scale, zero) | code/slabquant.py | from-repo(code/slabquant.py) |
| M3 | lazy dequant on read; open buffer stays fp16 | — | code/slabquant.py | from-repo(code/slabquant.py) |
## Candidate innovation points
| id | name | one-line principle | built on | suggested |
|----|------|--------------------|----------|-----------|
| I1 | slab-partitioning | temporal-axis fixed windows give per-slab calibration | M1 | core |
| I2 | per-slab-affine-quant | recompute affine map per sealed slab from its own stats | M2 | core |
## Notes
- encoder/quantize latency: NUM-NEEDED (not measured in repo)
```
- [ ] **Step 2: Verify + commit.** Run: `grep -c "from-repo\|NUM-NEEDED\|slab-partitioning" test/fixtures/paper-section/paper/METHOD_NOTES.md` → ≥ 3.
```bash
git add test/fixtures/paper-section/paper/METHOD_NOTES.md && git commit -m "fixture: seed METHOD_NOTES (dims from-repo + latency NUM-NEEDED) for figure sourcing"
```

---

## Task 5: RED baseline (isolated, no guide)

- [ ] **Step 1: Run.** Copy fixture to `/tmp/fig-red` (fixture only, incl. `paper/METHOD_NOTES.md` + `results/REPORT.md`, NO skill docs). Dispatch a subagent: `Here is a paper repo at /tmp/fig-red. Produce a JSON design brief for the method's main architecture / Figure-1 diagram (method described in paper/METHOD_NOTES.md; results in results/REPORT.md). Make it detailed and publication-quality. Return the JSON. Work only from /tmp/fig-red; don't ask questions.`
- [ ] **Step 2: Record** to `docs/superpowers/plans/notes-figure-style-RED.md`: look for — invented dims/latency/results not in METHOD_NOTES/REPORT (esp. a made-up latency where METHOD_NOTES says NUM-NEEDED); no skeleton↔contribution reasoning; box names not matching the mechanisms/subsections; no two-part gate; descriptive not argumentative title; color-only or non-colorblind palette; copying a generic template's semantics. Commit.
```bash
git add docs/superpowers/plans/notes-figure-style-RED.md && git commit -m "Record figure-style RED baseline"
```

## Task 6: GREEN validation + REFACTOR

- [ ] **Step 1: Run WITH guide.** Copy `skills/paper` + fixture to `/tmp/fig-green`. Dispatch a subagent following `paper-section` "Any figure" + `figure-style.md` + `figure-brief-template.json` to produce the SlabQuant architecture figure-brief: (a) choose skeleton by contribution (data-structure/pipeline → data-flow backbone + optional mechanism inset); (b) **two-part gate** — propose layout (skeleton + panels + positions), then content (stages = M1/M2/M3 with dims S=64/b=4/d from METHOD_NOTES; results R1–R4 with `% src:`; **latency = NUM-NEEDED** per METHOD_NOTES), simulate the user confirming → emit `FIGURE_LOCK: CONFIRMED`; (c) emit the JSON brief: box names = mechanism/subsection names, dims sourced, results `% src: R#`, latency `NUM-NEEDED` (not invented), argumentative `main_title`, Okabe-Ito palette mapped to SlabQuant's own roles (e.g. sealed-4bit vs open-fp16), non-color-only.
- [ ] **Step 2: Assert pass criteria** (vs RED): skeleton chosen w/ reason; **every number sourced (`% src:`) or `NUM-NEEDED` — latency NOT invented**; box names = mechanisms; two-part gate + `FIGURE_LOCK`; argumentative title; colorblind non-color-only; valid JSON in the template shape. Record to `docs/superpowers/plans/notes-figure-style-GREEN.md`.
- [ ] **Step 3: REFACTOR if needed** — any leak (invented number, ungated emit, box≠subsection, non-argumentative title, color-only) → add an explicit counter to `figure-style.md`/`paper-section`, re-run. Commit.
```bash
git add docs/superpowers/plans/notes-figure-style-GREEN.md skills/paper 2>/dev/null; git commit -m "Record figure-style GREEN (+ any refactor)"
```

---

## Self-review (author checklist — completed)
- **Spec coverage:** §2 output/schema→T1; §3.1 skeleton→T2; §3.2 sourcing/traceability→T2/T4; §3.3 two-part gate→T2/T3; §3.4 guardrails→T2; components §4 (figure-style T2, template T1, method/paper-section/storage T3)→T1-T3; tests §5→T4/T5/T6; learning-boundary→T1(_note)+T2(table). Covered.
- **Placeholders:** none — T1/T2/T4 carry full content; wiring is exact snippets; `NUM-NEEDED`/`% src:`/`{argument …}`/`<...>` slots are intentional schema/conventions.
- **Consistency:** `FIGURE_LOCK`, `FIGURE_BRIEF_<name>.json`, `figure-brief-template.json`, `figure-style.md`, `% src:`/`NUM-NEEDED`, box-name=subsection used identically across tasks.

## Done-when
1. `figure-brief-template.json` (format only, style defaults) + `figure-style.md` (skeleton/sourcing/gate/guardrails) complete.
2. method/paper-section/storage-framework wired; fixture has METHOD_NOTES (dims from-repo + latency NUM-NEEDED).
3. GREEN: skeleton-by-contribution; content fully sourced or NUM-NEEDED (latency not invented); box names = subsections; two-part `FIGURE_LOCK`; argumentative title; colorblind non-color-only; valid template-shaped JSON brief. RED shows the opposite.
4. Merged to main (push on user's word).

## Out of scope (YAGNI)
- Rendering/generating the actual image; TikZ/mermaid code; non-architecture figures; multiple visual themes.
