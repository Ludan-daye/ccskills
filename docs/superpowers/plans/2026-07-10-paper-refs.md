# paper-refs (SP3 collection) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax.

**Goal:** Build `paper-refs` — a skill that gathers, strictly verifies, classifies, and shortlists related-work references around the repo's research direction, with the cited set gated on the user's decision.

**Architecture:** New child under `skills/paper/refs/`. `SKILL.md` describes an 8-step pipeline (seed → strategy → fan-out search → dedup → verify → classify → pool → user gate); the heavy content (type strategies, search/verify subagent prompts, artifact schemas) lives in `references/`. It seeds from the parent `paper` survey and follows the family's discipline (every item sourced, user decides, no fabrication). Collection only — no prose, no `refs.bib`.

**Tech Stack:** Markdown SKILL.md, `WebSearch`/`WebFetch` via subagents, git. Reference spec: `docs/superpowers/specs/2026-07-10-paper-refs-design.md`.

**Branch:** `paper-refs` → merge `main` when done. Commit locally; do NOT push until the user asks.

**Convention:** Repo root = `/root/ludandaye/program/Skills/paperSkill/ccskills`. `\cite{TODO:...}` etc. inside content are intentional conventions.

---

## PHASE A — Author the skill + reference docs

### Task 1: `references/type-strategies.md`

**Files:** Create `skills/paper/refs/references/type-strategies.md`

- [ ] **Step 1: Write the file** — exact content:

```markdown
# Paper type → related-work collection strategy

Read `paper_type` from `paper/PAPER_REPO_SURVEY.md` (§1). **Confirm the type with the user**, then collect by the mapped angles. `mixed`/unclear → ask, don't guess.

## 成果 / 方法型  (paper_type: method | system | empirical | efficiency)
- **A. Lineage（方向与来源）** — prior papers/ideas the method or direction builds on: origins, precursors, the technique's ancestry. Classic/foundational works allowed here even if older.
- **B. Competing capabilities（相关能力 + 优缺点）** — existing works solving the same problem / offering comparable capability, with explicit pros/cons (the comparison & baseline landscape). Prefer recent + top-venue.

## 说明 / 解释型  (paper_type: explanatory | diagnosis | survey)
- **Existing explanations（现有解释的缺陷与特点）** — how the phenomenon is currently explained/accounted for; each account's defects and distinguishing features.

## 理论型  (paper_type: theory)
- **A. Foundations（基础信息）** — foundational results/tools the new theory rests on (classics allowed).
- **B. Prior results（以前的成果）** — existing results in the same theoretical area (prefer recent for the frontier).

## Angle labels (used in REFS_POOL / shortlist `angle` column)
- 成果型: `lineage`, `competing`
- 说明型: `existing-explanation`
- 理论型: `foundation`, `prior-result`
```

- [ ] **Step 2: Verify** — Run: `grep -c "paper_type:" skills/paper/refs/references/type-strategies.md` → Expected: 3.
- [ ] **Step 3: Commit** — `git add skills/paper/refs/references/type-strategies.md && git commit -m "paper-refs: add type-strategies.md"`

---

### Task 2: `references/search-agent-prompt.md`

**Files:** Create `skills/paper/refs/references/search-agent-prompt.md`

- [ ] **Step 1: Write the file** — exact content:

````markdown
# Search subagent prompt (paper-refs fan-out)

The orchestrator splits the seed into K facets (angle × venue-tier × time-window × keyword-cluster) and dispatches **one search subagent per facet**. Over-collect: raw target ≥ 100 across facets, to survive verification.

## Template (fill <...>)
```
You search for related-work references on ONE facet for a paper about <direction>.
Return only REAL, findable papers — do NOT invent titles, authors, venues, or links.

FACET: angle=<lineage|competing|existing-explanation|foundation|prior-result>;
       keywords=<...>; window=<last 3–5 years; classics allowed for lineage/foundation>;
       venue=<top conferences/journals or well-known industry labs>.

Use WebSearch then WebFetch to confirm each candidate exists. Return 12–20 candidates as a markdown table:
| title | authors | year | venue | link | content_summary | why_relevant | angle |
- link MUST be a resolvable URL: arXiv /abs/, DOI, official venue page, or GitHub (for artifacts).
- content_summary = 2–4 sentences from the actual abstract/page.
- why_relevant = one line tying it to <direction> and the facet angle.
- If you cannot confirm a paper exists, DROP it (do not pad the count with guesses).
- Mark industry/blog sources as venue=industry:<name>.

End with one line listing the queries you ran.
```
````

- [ ] **Step 2: Verify** — Run: `grep -c "content_summary\|why_relevant\|do NOT invent" skills/paper/refs/references/search-agent-prompt.md` → Expected: ≥ 3.
- [ ] **Step 3: Commit** — `git add skills/paper/refs/references/search-agent-prompt.md && git commit -m "paper-refs: add search-agent-prompt.md"`

---

### Task 3: `references/verify-agent-prompt.md`

**Files:** Create `skills/paper/refs/references/verify-agent-prompt.md`

- [ ] **Step 1: Write the file** — exact content:

````markdown
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
````

- [ ] **Step 2: Verify** — Run: `grep -c "WebFetch\|dropped:\|Never keep an item you could not fetch" skills/paper/refs/references/verify-agent-prompt.md` → Expected: ≥ 3.
- [ ] **Step 3: Commit** — `git add skills/paper/refs/references/verify-agent-prompt.md && git commit -m "paper-refs: add verify-agent-prompt.md"`

---

### Task 4: `references/pool-and-shortlist-schema.md`

**Files:** Create `skills/paper/refs/references/pool-and-shortlist-schema.md`

- [ ] **Step 1: Write the file** — exact content:

````markdown
# REFS_POOL.md & REFS_SHORTLIST.md schemas

Both live in the user repo under `<ROOT>/paper/`.

## `paper/REFS_POOL.md` — verified pool (≥80)
```markdown
# REFS_POOL — <direction>
- seeded_from: paper/PAPER_REPO_SURVEY.md ; paper_type: <type>
- counts: collected <raw> → verified <M≥80> → dropped <K>

## Angle: <lineage | competing | existing-explanation | foundation | prior-result>
| id | title | authors | year | venue | tier | link | content_summary | why_relevant | verify |
|----|-------|---------|------|-------|------|------|-----------------|--------------|--------|
| P01 | … | … | 2025 | NeurIPS | top | https://… | … | … | verified(fetched) |

## Dropped / quarantine
| claimed_title | link | reason |
|---------------|------|--------|
```

## `paper/REFS_SHORTLIST.md` — ~20–25 proposed → user decides
```markdown
# REFS_SHORTLIST (propose → user decides)
- from: paper/REFS_POOL.md (verified M)

| id | title | venue/year | angle | why_cite | link | 建议 | 用户决定 |
|----|-------|-----------|-------|----------|------|------|----------|
| P01 | … | NeurIPS'25 | lineage | 直接前驱 | https://… | 推荐 |  |

## USER_SELECTION   (locked ONLY after the user confirms)
- Included: <ids>
- Excluded: <ids>
- Status: CONFIRMED
```

**Selection principle:** cover every active angle, prefer recent + top-tier + highest relevance; the shortlist is a *proposal* — the user's `USER_SELECTION: CONFIRMED` is the gate. The confirmed set is the input to later writing / `refs.bib` (not produced here).
````

- [ ] **Step 2: Verify** — Run: `grep -c "REFS_POOL\|REFS_SHORTLIST\|USER_SELECTION\|counts: collected" skills/paper/refs/references/pool-and-shortlist-schema.md` → Expected: ≥ 4.
- [ ] **Step 3: Commit** — `git add skills/paper/refs/references/pool-and-shortlist-schema.md && git commit -m "paper-refs: add pool-and-shortlist-schema.md"`

---

### Task 5: `skills/paper/refs/SKILL.md` (the engine)

**Files:** Create `skills/paper/refs/SKILL.md`

- [ ] **Step 1: Write the file** — exact content:

````markdown
---
name: paper-refs
description: >
  Use when gathering related-work / citations for a CS paper — 找相关工作, 搜集引文,
  related work 检索, 参考文献采集. Collects and verifies references; does not write
  the related-work prose or a bib.
---

# Paper Refs (child of `paper`)

**Parent:** `paper` — owns repo scan → `PAPER_REPO_SURVEY.md` + `TERMS.md`.
Gather a **verified** related-work pool around the repo's research direction, then let the user pick which to cite. **Collection only — no prose, no `refs.bib`.**

**REQUIRED BACKGROUND:** `../references/storage-framework.md` (产物契约 / 用户门禁).

## Flow
```text
1 Seed      read paper/PAPER_REPO_SURVEY.md (direction/method/results) + paper/TERMS.md + paper_type
            (survey missing/stale → run parent `paper` Phase S first)
2 Strategy  map paper_type → angles (references/type-strategies.md); CONFIRM type with user
3 Fan-out   split into facets; dispatch search subagents (references/search-agent-prompt.md); over-collect raw ≥100
4 Dedup     merge same paper across links; normalize title/authors/year/venue
5 Verify    batch to verify subagents (references/verify-agent-prompt.md); FETCH each; drop unverifiable + log reason
6 Classify  tag each kept item with its angle
7 Pool      write paper/REFS_POOL.md (≥80 verified; counts collected→verified→dropped) — schema in references/pool-and-shortlist-schema.md
8 Shortlist propose ~20–25 → paper/REFS_SHORTLIST.md table → USER decides → USER_SELECTION lock   ← HARD GATE
```

## Hard rules
1. **No fabricated references.** Every kept item was FETCHED and cross-checked (title/authors/year/venue + claim). Could not fetch → drop.
2. **Seed from the repo direction**, not arbitrary topics.
3. **≥80 verified** in the pool; if short, search more — never silently truncate; always log collected→verified→dropped.
4. **User decides citations.** No item is "selected" before `USER_SELECTION: CONFIRMED`.
5. No unsolicited git push. Chinese discussion.

## Anti-patterns
- Inventing/half-inventing citations or links; keeping an item you couldn't fetch.
- Skipping the type→strategy step; collecting off-direction.
- Writing related-work prose or a `refs.bib` here (later step).
- Auto-picking the cited set without the user gate.

## References
- `references/type-strategies.md`, `references/search-agent-prompt.md`, `references/verify-agent-prompt.md`, `references/pool-and-shortlist-schema.md`
- Parent: `../SKILL.md`; `../references/storage-framework.md`
````

- [ ] **Step 2: Verify** — Run: `sed -n '1,8p' skills/paper/refs/SKILL.md | grep -c "Use when"` → Expected: 1. And `grep -c "^## " skills/paper/refs/SKILL.md` → Expected: 4 (Flow, Hard rules, Anti-patterns, References). And `wc -w skills/paper/refs/SKILL.md` → report (< 450 target).
- [ ] **Step 3: Commit** — `git add skills/paper/refs/SKILL.md && git commit -m "paper-refs: add SKILL.md engine (seed->search->verify->pool->user gate)"`

---

## PHASE B — Integration

### Task 6: Wire storage-framework + parent paper skill

**Files:** Modify `skills/paper/references/storage-framework.md`; Modify `skills/paper/SKILL.md`

- [ ] **Step 1: storage-framework — add two artifacts.** In `skills/paper/references/storage-framework.md`, in the `## 1. 用户仓库侧` table, add these rows (after the `TERMS.md` row):

```markdown
| `REFS_POOL.md` | paper-refs | 写作/引文 | Phase 7：≥80 条已核实相关工作池（含 dropped 计数） |
| `REFS_SHORTLIST.md` | paper-refs | 写作/引文 | Phase 8：~20+ 候选 + `USER_SELECTION`（用户确认的引用集合，后续 refs.bib 的真源） |
```

- [ ] **Step 2: parent paper — Hierarchy + routing.** In `skills/paper/SKILL.md`:
  - In the `## Hierarchy` code block, add under the tree: `├── refs/                      ← paper-refs (related-work collection)`.
  - In the children table, add: `| **`paper-refs`** (`paper/refs/`) | Seed from direction → search → verify → pool → user-gated shortlist |`.
  - In the S.3 routing table add a row: `| 找相关工作 / 引文 / related work 检索 | Invoke **`paper-refs`** |`.

- [ ] **Step 3: Verify** — Run: `grep -c "REFS_POOL\|REFS_SHORTLIST" skills/paper/references/storage-framework.md` → Expected: ≥ 2. And `grep -c "paper-refs" skills/paper/SKILL.md` → Expected: ≥ 2.
- [ ] **Step 4: Commit** — `git add skills/paper/references/storage-framework.md skills/paper/SKILL.md && git commit -m "Wire paper-refs into storage-framework + parent routing"`

---

### Task 7: Docs sync — README + SOURCES

**Files:** Modify `README.md`; Modify `SOURCES.md`

- [ ] **Step 1: README** —
  - Add a row to the 一览 table (论文 group): `| [`paper-refs`](skills/paper/refs/) | 论文 | 自动 | **paper 子 skill**：按方向多 agent 搜集 → 逐条核实 → 池 → 用户勾选引用 |`.
  - Update the count line to the actual number: run `find skills -name SKILL.md | wc -l` and set "共 **N** 个 skill" (expected 12).
  - In the paper-family description paragraph, mention `paper-refs` alongside structure/section/abstract.
- [ ] **Step 2: SOURCES.md** — add `paper-refs` to the self-authored list (same license note as other 自研).
- [ ] **Step 3: Verify** — Run: `n=$(find skills -name SKILL.md | wc -l); echo "n=$n"; grep -c "共 \*\*$n\*\* 个 skill" README.md` → Expected: n=12 and match count 1. And `grep -c "paper-refs" README.md SOURCES.md` → Expected: ≥ 2.
- [ ] **Step 4: Commit** — `git add README.md SOURCES.md && git commit -m "Docs: add paper-refs (12 skills)"`

---

## PHASE C — Test (RED → GREEN)

### Task 8: RED baseline (isolated, no skill)

- [ ] **Step 1: Run baseline.** Dispatch a subagent WITHOUT the skill, prompt:
`You are helping write a CS paper on "KV-cache quantization for LLM inference". Collect a related-work list (~15 references) with citations you would put in the paper. Return a table: title | authors | year | venue | (link if any) | why relevant.`
- [ ] **Step 2: Record failure signals** to `docs/superpowers/plans/notes-paper-refs-RED.md` (create + commit). Look for: fabricated or unverifiable entries (no link / guessed venue/year), no paper-type-driven angles, no fetch/verification, no user-decision gate, arbitrary count. These are what the skill must fix.
```bash
git add docs/superpowers/plans/notes-paper-refs-RED.md && git commit -m "Record paper-refs RED baseline"
```

### Task 9: GREEN validation (with skill, smoke-scale)

- [ ] **Step 1: Run WITH the skill (reduced count for smoke).** Copy the skill to `/tmp/refs-green/paper` and a minimal seed survey (direction=KV-cache quantization, paper_type=method, a couple of TERMS) to `/tmp/refs-green/fixture/paper/`. Dispatch a subagent that follows `paper-refs`, but cap collection at raw ~15 / pool ~8 for the smoke run (state the cap). It must still: confirm type→angles, fan-out search, **WebFetch-verify each and drop unverifiable with reasons**, classify by angle, write a `REFS_POOL.md`-shaped result with `collected→verified→dropped` counts, and produce a `REFS_SHORTLIST.md` table that STOPS at the user gate (no `USER_SELECTION: CONFIRMED` without user input).
- [ ] **Step 2: Assert pass criteria** (vs RED): every kept item has a resolvable link that was fetched; unverifiable candidates are dropped with reasons (not padded); items are angle-classified per paper_type; a shortlist table is presented and the cited set is NOT self-selected (gate respected); zero fabricated entries. Record to `docs/superpowers/plans/notes-paper-refs-GREEN.md`.
- [ ] **Step 3: REFACTOR if needed** — if the skill let any unverified/fabricated item through or skipped the gate, add an explicit counter to `refs/SKILL.md` Hard rules/Anti-patterns and re-run. Commit.
```bash
git add docs/superpowers/plans/notes-paper-refs-GREEN.md skills/paper/refs/SKILL.md 2>/dev/null; git commit -m "Record paper-refs GREEN (+ any refactor)"
```

---

## Self-review (author checklist — completed)
- **Spec coverage:** §3 components → Tasks 1–7 (type-strategies T1, search-prompt T2, verify-prompt T3, schemas T4, SKILL.md T5, storage-framework+parent T6, README+SOURCES T7). §4 mechanisms embedded in those files. §5 testing → Tasks 8–9. All covered.
- **Placeholders:** none — every file step has full content; `<...>` are schema fill-ins and `\cite{TODO:}` are conventions.
- **Consistency:** artifact names (`REFS_POOL.md`, `REFS_SHORTLIST.md`, `USER_SELECTION`), angle labels (`lineage`/`competing`/`existing-explanation`/`foundation`/`prior-result`), and file paths match across type-strategies, schemas, SKILL.md, and storage-framework tasks.

## Done-when
1. `skills/paper/refs/` has SKILL.md + 4 reference files; parent + storage-framework + README(12) + SOURCES wired.
2. RED shows fabrication/no-verify/no-gate; GREEN (smoke) shows type-driven + per-item fetch-verify + drop-with-reason + user-gated shortlist + zero fabrication.
3. Merged to main.

## Out of scope (YAGNI)
- Related-work prose; `refs.bib` / real `\cite` keys; citation-graph viz; full-PDF reading beyond verify.
