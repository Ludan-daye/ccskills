# Related-Work Writing (SP4) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax.

**Goal:** Enhance `paper-section`'s related-work path so it writes the Related Work section in two parts mapped to `paper-refs` angles, using only the user's selected refs, emitting real `\cite{key}` + a `refs.bib` (venue-style), gated by menu→lock, and following a style summarized from real top-venue examples.

**Architecture:** Not a new skill. Enrich `sections/related-work.md`, add a research-built `sections/related-work-examples.md`, add a related-work special-case to `paper-section/SKILL.md`, and a `refs.bib` contract to `storage-framework.md`. Then RED→GREEN on an extended fixture.

**Tech Stack:** Markdown SKILL docs, LaTeX/BibTeX conventions, `WebSearch`/`WebFetch` (for the examples research), subagent probes, git. Spec: `docs/superpowers/specs/2026-07-10-paper-relwork-write-design.md`.

**Branch:** `paper-relwork-write` → merge `main` when done (hold push for user). Repo root: `/root/ludandaye/program/Skills/paperSkill/ccskills`. Commit locally, don't push.

---

## PHASE A — Research examples + author guidance

### Task 1: Build `related-work-examples.md` from real top-venue sections (research)

**Files:** Create `skills/paper/references/sections/related-work-examples.md`

This is a **research-driven** doc — content is discovered, not pre-written. Dispatch a research subagent (web-enabled).

- [ ] **Step 1: Research + author.** Subagent instruction: find **6–8 recent, top-venue** CS papers (NeurIPS/ICML/ICLR/CVPR/ACL/OSDI/SOSP/…; prefer ones with a clear Related Work section) via `WebSearch`/`WebFetch`. For each, produce a **structural analysis (NO copied sentences)**: `paper + venue/year + link | how it structures RW (clusters / two-part lineage-vs-competing?) | how it does same/different-axis positioning | citation density | notable transition/positioning phrasing described in the abstract, not quoted`. Then write a final **`## Style — constraint words/写法 (summarized, flexible)`** section that **generalizes the observed style** (the recurring same/different connectives, transition habits, positioning moves) — as flexible guidance, explicitly "参照不照搬，不死板", derived from the set (not a preset list). Header must state: structure-teaching only, do not copy sentences.

- [ ] **Step 2: Verify.** Run: `grep -c "^## " skills/paper/references/sections/related-work-examples.md` → Expected: ≥ 3 (examples + a Style section). And `grep -ci "constraint\|约束词\|参照" skills/paper/references/sections/related-work-examples.md` → Expected: ≥ 1. Manually confirm no verbatim sentences copied from sources (structural descriptions only).

- [ ] **Step 3: Commit.** `git add skills/paper/references/sections/related-work-examples.md && git commit -m "Add related-work-examples.md (top-venue RW structures + summarized style)"`

---

### Task 2: Enhance `sections/related-work.md`

**Files:** Modify `skills/paper/references/sections/related-work.md`

Locate blocks by their `##` headings (from SP2's `_TEMPLATE` shape). Apply these edits, preserving other headings:

- [ ] **Step 1: Two-part Move order.** Replace the `## Move order` content with:
```markdown
## Move order
Structure = **one part per collected angle** (from `paper/REFS_SHORTLIST.md`):
- **成果/方法型:** Part 1 背景与来源 (angle `lineage`) → Part 2 相关能力与对比 (angle `competing`).
- **理论型:** Part 1 (`foundation`) → Part 2 (`prior-result`).
- **说明/解释型:** single part (`existing-explanation`).
Within each part: topic clusters → name representative works with `\cite{key}` → same/different-axis positioning (参照 `related-work-examples.md` 的归纳风格，灵活不死板). lineage/foundation first, competing/prior-result after.
```

- [ ] **Step 2: Add refs+cite+bib subsection** (insert after `## Claim → evidence mapping`):
```markdown
## Refs, citations & bib (related-work is the real-cite section)
- Input: `paper/REFS_SHORTLIST.md` `USER_SELECTION` (`Status: CONFIRMED`); missing/unconfirmed → run `paper-refs` first, don't self-select.
- Cite ONLY selected refs; emit **real** `\cite{key}` (not `\cite{TODO:}`).
- For every cited ref, append ONE BibTeX entry to `paper/refs.bib` using verified metadata from `paper-refs` — do not invent fields; a missing field → `% BIB-INCOMPLETE: <field>`.
- **bib key** = `<firstauthorlastname><year><firstsignificantword>` lowercased, symbols stripped (e.g. `vaswani2017attention`); on collision add `a`/`b`.
- **bibstyle follows the venue template**: read `paper/GUIDANCE.md` §6 / vendor `\bibliographystyle`; ensure entries carry that style's required fields; do not change the template's bibstyle.
- Self-check: every `\cite{key}` has a `refs.bib` entry and is in `USER_SELECTION`.
```

- [ ] **Step 3: Add style note** (append to `## Must include`): a bullet `- 风格参照 `related-work-examples.md` 归纳的约束词/写法（same/different 定位、过渡）——灵活，不逐词照搬。`

- [ ] **Step 4: Add optional-table subsection** (insert before `## Done-when checklist`):
```markdown
## Optional comparison table (ASK the user first)
Default off. At the lock step, ask "要不要 prior-work 对比表?". If yes:
- A LaTeX `table`; **column 1 = work name + `\cite{key}`** (no extra annotation sentence); other columns = comparison dimensions (method type / bit-width / dataset / key metric); **our method is one row**.
- Cited works' numbers only from that ref's verified content; unavailable → blank or `% NUM-NEEDED` (never invented). **Our own numbers carry `% src: <claim_id>`** (the comparison table is the ONLY place our numbers may appear in related work).
- `\label{tab:related-comparison}` + `% TAB`. If the user says no → skip; prose only.
```

- [ ] **Step 5: Update Done-when checklist** — add bullets: `- [ ] 结构=每角度一部分；只引 USER_SELECTION；每个 \cite 有 refs.bib 条目`, `- [ ] bibstyle 随模板；bib key 按规则；缺字段标 % BIB-INCOMPLETE`, `- [ ] 风格参照 examples 归纳（灵活）；对比表已问过用户`.

- [ ] **Step 6: Verify + commit.** Run: `grep -c "USER_SELECTION\|refs.bib\|tab:related-comparison\|bib key\|related-work-examples" skills/paper/references/sections/related-work.md` → Expected: ≥ 5.
```bash
git add skills/paper/references/sections/related-work.md && git commit -m "Enhance related-work.md: two-part by angle, real cite+bib, style, optional table"
```

---

### Task 3: Related-work special-case in `paper-section/SKILL.md`

**Files:** Modify `skills/paper/section/SKILL.md`

- [ ] **Step 1: Add a special-case block.** After the `## Phase 5 — Self-check + report` section (before `## Hard rules`), insert:
```markdown
## Related-work special case
When the picked section is **related-work**, additionally (see `../references/sections/related-work.md`):
- Read `paper/REFS_SHORTLIST.md` `USER_SELECTION` (missing/not `CONFIRMED` → run `paper-refs` first). Structure = one part per collected angle (lineage/competing, …).
- Emit **real `\cite{key}`** (not `\cite{TODO:}`) for selected refs; append a matching BibTeX entry to `paper/refs.bib` (bib key rule + venue bibstyle — see `../references/storage-framework.md`).
- At the CONTENT_LOCK step, **ask the user whether to include the optional comparison table**.
- Only `USER_SELECTION` refs; every `\cite{key}` must have a `refs.bib` entry.

Other sections keep `\cite{TODO:...}` + `% CITE-NEEDED` (no bib).
```

- [ ] **Step 2: Verify + commit.** Run: `grep -c "Related-work special case\|REFS_SHORTLIST\|refs.bib" skills/paper/section/SKILL.md` → Expected: ≥ 3. And confirm word count still reasonable: `wc -w skills/paper/section/SKILL.md` (report; < ~700 ok).
```bash
git add skills/paper/section/SKILL.md && git commit -m "paper-section: related-work special case (real cite+bib, optional table, user gate)"
```

---

### Task 4: `refs.bib` contract in `storage-framework.md`

**Files:** Modify `skills/paper/references/storage-framework.md`

- [ ] **Step 1: Add refs.bib row.** In the `## 1. 用户仓库侧` table, replace the existing `refs.bib` row (`| `refs.bib` | 无人伪造 | SP3 引文 skill | section 只写 \cite{TODO:...} 占位 |`) with:
```markdown
| `refs.bib` | paper-section (related-work) | LaTeX 编译 | related-work 写作时为被引选定 refs 追加 BibTeX 条目；key=`<author><year><word>`；bibstyle 随 venue 模板；缺字段标 `% BIB-INCOMPLETE`；每个 `\cite{key}` ↔ 一条 |
```

- [ ] **Step 2: Verify + commit.** Run: `grep -c "refs.bib.*paper-section\|BIB-INCOMPLETE\|bibstyle 随" skills/paper/references/storage-framework.md` → Expected: ≥ 1.
```bash
git add skills/paper/references/storage-framework.md && git commit -m "storage-framework: refs.bib now owned by related-work writing (key rule + venue bibstyle)"
```

---

## PHASE B — Fixture + test

### Task 5: Extend the fixture

**Files:** Create `test/fixtures/paper-section/paper/REFS_SHORTLIST.md`, `test/fixtures/paper-section/paper/sections/related-work.tex`; Modify `test/fixtures/paper-section/paper/GUIDANCE.md`

- [ ] **Step 1: REFS_SHORTLIST.md** (real metadata, 2 lineage + 2 competing, CONFIRMED):
```markdown
# REFS_SHORTLIST (propose → user decides)
- from: paper/REFS_POOL.md (verified)

| id | title | venue/year | angle | link |
|----|-------|-----------|-------|------|
| P01 | GPTQ: Accurate Post-Training Quantization for Generative Pre-trained Transformers | ICLR'23 | lineage | https://arxiv.org/abs/2210.17323 |
| P05 | Efficient Memory Management for LLM Serving with PagedAttention | SOSP'23 | lineage | https://arxiv.org/abs/2309.06180 |
| P08 | KIVI: A Tuning-Free Asymmetric 2bit Quantization for KV Cache | ICML'24 | competing | https://arxiv.org/abs/2402.02750 |
| P09 | KVQuant: Towards 10 Million Context Length LLM Inference with KV Cache Quantization | NeurIPS'24 | competing | https://arxiv.org/abs/2401.18079 |

## USER_SELECTION
- Included: P01 P05 P08 P09
- Excluded:
- Status: CONFIRMED
```

- [ ] **Step 2: related-work.tex skeleton:**
```latex
% Status: [ ] not drafted
\section{Related Work}\label{sec:related}
```

- [ ] **Step 3: GUIDANCE.md bibstyle.** Append to the fixture's `paper/GUIDANCE.md`:
```markdown
## 6. Template & bib
| 项 | 内容 |
|----|------|
| bibliographystyle | IEEEtran |
```

- [ ] **Step 4: Verify + commit.** Run: `grep -c "USER_SELECTION\|Status: CONFIRMED" test/fixtures/paper-section/paper/REFS_SHORTLIST.md` → Expected: ≥ 2; `grep -c IEEEtran test/fixtures/paper-section/paper/GUIDANCE.md` → Expected: 1.
```bash
git add test/fixtures/paper-section/paper && git commit -m "fixture: add REFS_SHORTLIST (lineage+competing), related-work.tex, bibstyle"
```

---

### Task 6: RED baseline (isolated, no enhancement)

- [ ] **Step 1: Run.** Copy fixture to `/tmp/rw-red` (fixture only, NO skill docs). Dispatch a subagent: `Here is a paper repo at /tmp/rw-red. Draft the Related Work section into paper/sections/related-work.tex using paper/REFS_SHORTLIST.md. Return the LaTeX (+ any bib). Work only from /tmp/rw-red.`
- [ ] **Step 2: Record** to `docs/superpowers/plans/notes-relwork-RED.md`. Look for: no two-part-by-angle structure; not restricted to USER_SELECTION; `\cite` keys without a matching refs.bib entry OR fabricated bib fields; bibstyle ignored; no user gate / no table question. Commit.
```bash
git add docs/superpowers/plans/notes-relwork-RED.md && git commit -m "Record related-work-writing RED baseline"
```

### Task 7: GREEN validation (with enhancement) + REFACTOR

- [ ] **Step 1: Run WITH skill.** Copy `skills/paper` + fixture to `/tmp/rw-green` (as SP2/SP3 GREEN). Dispatch a subagent that follows `paper-section` (related-work special case) + `related-work.md` + `related-work-examples.md` to draft related-work for the fixture. It must: structure two parts by angle (P01/P05 lineage, P08/P09 competing); cite ONLY USER_SELECTION with real `\cite{key}` (rule-named); append a matching `refs.bib` entry per key with IEEEtran-required fields (missing → `% BIB-INCOMPLETE`); **ask about the comparison table** (simulate user "不要" for the smoke, and separately show the table shape if "要"); follow the examples' summarized style; stop at CONTENT_LOCK before prose.
- [ ] **Step 2: Assert pass criteria** (vs RED): two-part-by-angle; every `\cite{key}` ∈ USER_SELECTION and has a `refs.bib` entry; bib keys follow the rule; bibstyle=IEEEtran respected; table was **asked** not auto-added; no invented bib fields (missing → marked); menu→lock gate present. Record to `docs/superpowers/plans/notes-relwork-GREEN.md`.
- [ ] **Step 3: REFACTOR if needed** — if it fabricated a bib field, cited a non-selected ref, skipped the table question, or skipped the gate, add an explicit counter to `related-work.md`/`paper-section` and re-run. Commit.
```bash
git add docs/superpowers/plans/notes-relwork-GREEN.md skills/paper 2>/dev/null; git commit -m "Record related-work-writing GREEN (+ any refactor)"
```

---

## Self-review (author checklist — completed)
- **Spec coverage:** §2.1 two-part→T2/T3; §2.2 examples+constraint-words→T1; §4.1 input→T2/T3; §4.2 cite+bib+key+bibstyle→T2/T3/T4; §4.3 two-part write→T2; §4.4 gate→T3; §4.5 optional table→T2/T3; §5 test→T5-7; components §3 → T1-T4. All covered.
- **Placeholders:** none — guidance/edit tasks have full content; Task 1 is a research deliverable specified by procedure + output structure + acceptance (content is discovered), which is the correct treatment; `\cite{TODO}`/`% BIB-INCOMPLETE` are conventions.
- **Consistency:** `USER_SELECTION`, `refs.bib`, bib-key rule (`<author><year><word>`), `tab:related-comparison`, angle labels (`lineage`/`competing`), `% BIB-INCOMPLETE` used identically across tasks.

## Done-when
1. `related-work-examples.md` researched (6–8 top-venue) + summarized flexible style.
2. related-work.md/paper-section/storage-framework enhanced; fixture extended.
3. GREEN: two-part-by-angle, only USER_SELECTION, real `\cite`+matching `refs.bib` (rule keys, IEEEtran style, no invented fields), table asked, gate respected. RED shows the opposite.
4. Merged to main (push on user's word).

## Out of scope (YAGNI)
- Real `\cite` for other sections (stay `\cite{TODO:}`); bib for non-cited refs; running latexmk/bibtex; runtime example search.
