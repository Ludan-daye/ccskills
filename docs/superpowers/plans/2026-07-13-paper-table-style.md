# Table Style (SP6) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax.

**Goal:** Add a shared `table-style.md` (evidence-based structural rules + enrichment toolkit + per-table enrichment gate + guardrails) and make experiments/related-work/method/paper-section follow it.

**Architecture:** New reference `skills/paper/references/table-style.md`; the three table-producing section deep-dives + `paper-section/SKILL.md` link to it; `storage-framework.md` records the LaTeX-package contract; fixture gains multi-seed+baseline data; RED→GREEN.

**Tech Stack:** Markdown SKILL docs, LaTeX/booktabs/xcolor conventions, subagent probes, git. Spec: `docs/superpowers/specs/2026-07-13-paper-table-style-design.md`.

**Branch:** `paper-table-style` → merge `main` when done (hold push). Repo root: `/root/ludandaye/program/Skills/paperSkill/ccskills`. Commit locally, don't push. `% src:`/`% PKG-NEEDED`/`% NUM-NEEDED` are intentional conventions.

---

## Task 1: `table-style.md` (the shared guide)

**Files:** Create `skills/paper/references/table-style.md`

- [ ] **Step 1: Write the file** — exact content:

````markdown
# Table style — shared guide (all paper tables follow this)

Evidence base: 6 venue-verified top-venue result tables (vLLM SOSP'23, QLoRA NeurIPS'23, Depth Anything CVPR'24, Self-RAG ICLR'24, DPO NeurIPS'23, Self-Instruct ACL'23), inspected at LaTeX-source level. Used by Experiments (main results), Related Work (comparison table), Method (notation table).

## Structural base (MUST — near-universal)
- **booktabs rules only:** `\toprule` / `\midrule` / `\bottomrule`. **Never `\hline`.**
- **No vertical lines** in result/comparison tables; clean column spec `@{}l...@{}`.
- **Headers horizontal.** No `\rotatebox`/`sidewaystable` — rotate only as a last resort for a leaderboard with too many narrow numeric columns.
- **Method/label column left-aligned; numeric columns right-aligned; decimals consistent within a column.** K/M suffixes + thousands separators for large counts.
- **Table notes, symbol keys (`*`, `–`), metric abbreviations → in the CAPTION** (no `threeparttable`).
- `Table~\ref{}` (non-breaking tilde); float `[t]`; wide tables → `table*` (two-column) or `\resizebox`/`\small` + reduced `\tabcolsep`.

## Caption position (venue-adaptive)
Not universal (top venues split ~4 below / 2 above). Read `paper/GUIDANCE.md` §6 / vendor template's convention and follow it (IEEE-family: caption above; many CVPR/ACL: below). Template unknown → default caption above, and note it.

## Uncertainty (±std when multi-seed)
- Survey has multi-seed results → write `value ± std` (each `% src: <claim_id> (path)`).
- No multi-seed → point estimates; a headline claim may carry `± CI`.
- Numbers ONLY from survey `claim_id` / a ref's verified content; missing → `% NUM-NEEDED` (never invented).

## Enrichment toolkit (choose per table — see gate below)
- **Color assist:** cell background (`\rowcolor`/`\cellcolor`) or a heatmap gradient down one metric column, to highlight ours/best.
- **Font color:** green = gain, red = regression, blue = ours (`\textcolor`).
- **Arrows:** `$\uparrow$`/`$\downarrow$` for metric direction (when higher/lower-better are mixed); `▲`/`▼` for gain/loss vs baseline.
- **Small-font delta:** improvement over baseline beside the value, e.g. `85.2\,{\footnotesize\textcolor{OliveGreen}{($\uparrow$5.1)}}`.
- **Tiers:** `\textbf` = best (always), `\underline` = 2nd, `\textit` = 3rd.
- **Number decorations:** K/M suffix, thousands separators.

## Per-table enrichment gate (TABLE_ENRICH_LOCK — do NOT enrich every table uniformly)
For EACH table:
1. Judge which enrichment fits THIS table by its kind/content: comparison-with-baseline → ours-color + direction arrows + small-delta + bold-best; notation table → none (structural base only); dense metric grid → optional heatmap.
2. **Propose** to the user: `本表建议富化: [...]（各一句理由）`.
3. User adds/removes/confirms → **then** apply. `TABLE_ENRICH_LOCK: CONFIRMED`.
4. User says none → clean booktabs table, structural base only.

## Guardrails (rich but reviewer-safe)
- **Never color-only / arrow-only** — color/arrow must accompany a number or symbol; the table must be readable in **grayscale** and **colorblind-safe** (prefer light blue shades + green/red paired with `$\uparrow$`/`$\downarrow$`; avoid red-green as the sole distinction).
- Any color/arrow/tier/delta used → **caption must carry a legend** (e.g. "Bold = best; \underline{2nd}; green (↑x) = gain over baseline; ↑/↓ = higher/lower better").
- **Deltas/±std must be really computed** from traceable numbers (ours `% src: <claim_id>`; baseline from the ref's verified content) — never fabricated or exaggerated. **Direction semantics:** for lower-is-better metrics (PPL, latency), a *decrease* is an improvement → green / gain arrow (see below).
- **LaTeX packages** used (`booktabs, xcolor, colortbl, multirow, amssymb`, `\rowcolor`/`\cellcolor`/`\textcolor`) must be declared in `main.tex`/GUIDANCE; if not present, mark `% PKG-NEEDED: <pkg>` — don't silently assume the preamble.
- **Moderation:** a single clean-enrichment set (bold best + ours color + direction arrows + delta) is usually enough; don't pile on.

## Delta direction semantics
For each metric state whether higher or lower is better. Improvement = movement in the better direction. Color/arrow encode *improvement*, not raw sign: e.g. latency 12.0→6.3 is a **gain** → green `($\downarrow$5.7)`, NOT red. Accuracy 80.1→85.2 → green `($\uparrow$5.1)`.

## Micro-example (structure only — rich but safe)
```latex
% requires booktabs, xcolor, colortbl, amssymb  % PKG-NEEDED: <any absent from main.tex>
\begin{table}[t]
\centering
\caption{Main results. Bold = best; \underline{underline} = 2nd;
  {\footnotesize\textcolor{OliveGreen}{(↑x)}} = gain over baseline; $\uparrow$/$\downarrow$ = higher/lower better.}
\label{tab:main}
\begin{tabular}{@{}lcc@{}}
\toprule
Method & Acc.\ $\uparrow$ & Latency (ms) $\downarrow$ \\
\midrule
Baseline~\cite{TODO:AuthorYear-baseline} & 80.1 & 12.0 \\
\rowcolor{blue!8}\textbf{Ours} % ours: color assist paired with bold (not color-only)
  & \textbf{85.2}\,{\footnotesize\textcolor{OliveGreen}{($\uparrow$5.1)}} % src: R? (path)
  & \textbf{6.3}\,{\footnotesize\textcolor{OliveGreen}{($\downarrow$5.7)}} % src: R? (path); lower better -> gain -> green
\\
\bottomrule
\end{tabular}
\end{table}
```

## Sources (venue-verified; structural paraphrase, no copied sentences)
vLLM (SOSP'23), QLoRA (NeurIPS'23), Depth Anything (CVPR'24), Self-RAG (ICLR'24), DPO (NeurIPS'23), Self-Instruct (ACL'23).
````

- [ ] **Step 2: Verify.** Run: `grep -c "^## " skills/paper/references/table-style.md` → Expected ≥ 8. And `grep -c "TABLE_ENRICH_LOCK\|color-only\|PKG-NEEDED\|Delta direction\|booktabs" skills/paper/references/table-style.md` → Expected ≥ 5.
- [ ] **Step 3: Commit.** `git add skills/paper/references/table-style.md && git commit -m "Add table-style.md (structural rules + enrichment toolkit + per-table gate + guardrails)"`

---

## Task 2: Wire consumers

**Files:** Modify `skills/paper/references/sections/experiments.md`, `related-work.md`, `method.md`, `skills/paper/section/SKILL.md`, `skills/paper/references/storage-framework.md`

- [ ] **Step 1: experiments.md** — under its `## Must include`, add a bullet:
```markdown
- 所有表遵循 `../table-style.md`（结构基座 MUST + 每表富化门禁 `TABLE_ENRICH_LOCK`）；数字追 survey `claim_id`（`% src:`），多 seed 给 `±std`
```
- [ ] **Step 2: related-work.md** — in the `## Optional comparison table (ASK the user first)` section, append a bullet:
```markdown
- 排版遵循 `../table-style.md`（booktabs 横排无竖线；富化走每表门禁 `TABLE_ENRICH_LOCK`；非 color-only、caption 给图例）。
```
- [ ] **Step 3: method.md** — in the `## Formula discipline (公式纪律)` section (notation lives here), append a bullet:
```markdown
- notation / 任何表遵循 `../table-style.md` 结构基座（booktabs 横排、无竖线）；notation 表通常不富化。
```
- [ ] **Step 4: paper-section/SKILL.md** — insert a short block after `## Method special case` (before `## Hard rules`):
```markdown
## Any table (all sections)
When emitting ANY LaTeX table, follow `../references/table-style.md`: booktabs (no vertical lines), horizontal headers, notes in caption; caption position per venue; `±std` when multi-seed. **Enrichment is per-table:** judge which of color/font-color/arrows/small-delta/tiers fit THIS table, propose them to the user (`TABLE_ENRICH_LOCK`), apply only what's confirmed — never color-only, always caption-legended, deltas computed from traceable numbers, required LaTeX packages declared or `% PKG-NEEDED`.
```
- [ ] **Step 5: storage-framework.md** — under `## 5. 反造假占位约定` (or the placeholder-conventions table), add a row/line:
```markdown
| 表格宏包 | table 富化用到的宏包（`booktabs/xcolor/colortbl/multirow/amssymb` 等）须在 main.tex/GUIDANCE 声明；缺 → `% PKG-NEEDED: <pkg>` | 不静默假设 preamble |
```
(If §5 is a table, add as a row matching its columns; else add as a bullet under it.)
- [ ] **Step 6: Verify + commit.** Run: `grep -l "table-style" skills/paper/references/sections/experiments.md skills/paper/references/sections/related-work.md skills/paper/references/sections/method.md skills/paper/section/SKILL.md | wc -l` → Expected 4; `grep -c "PKG-NEEDED\|table-style\|TABLE_ENRICH" skills/paper/section/SKILL.md skills/paper/references/storage-framework.md | ... ` (just confirm both touched).
```bash
git add skills/paper/references/sections/experiments.md skills/paper/references/sections/related-work.md skills/paper/references/sections/method.md skills/paper/section/SKILL.md skills/paper/references/storage-framework.md
git commit -m "Wire experiments/related-work/method/paper-section/storage-framework to table-style"
```

---

## Task 3: Extend fixture (multi-seed + baseline for real deltas/±std)

**Files:** Modify `test/fixtures/paper-section/results/REPORT.md`

- [ ] **Step 1: Overwrite** `test/fixtures/paper-section/results/REPORT.md` with:
```markdown
# Results
| id | claim | value | note |
|----|-------|-------|------|
| R1 | perplexity vs fp16 (lower better) | 6.42 ± 0.05 | 3-seed mean±std; fp16 baseline 6.30 |
| R2 | KV memory (lower better) | 3.1 GB | vs fp16 baseline 11.8 GB |
| R3 | throughput (higher better) | 1.9x | tokens/s vs fp16, A100 batch 32 |
| R4 | accuracy (higher better) | 85.2 ± 0.3 | 3-seed mean±std; fp16 baseline 80.1 |
```
- [ ] **Step 2: Verify + commit.** Run: `grep -c "±\|baseline" test/fixtures/paper-section/results/REPORT.md` → Expected ≥ 3.
```bash
git add test/fixtures/paper-section/results/REPORT.md && git commit -m "fixture: multi-seed (±std) + baseline values for table deltas"
```

---

## Task 4: RED baseline (isolated, no guide)

- [ ] **Step 1: Run.** Copy fixture to `/tmp/tbl-red` (fixture only, NO skill docs). Dispatch a subagent: `Here is a paper repo at /tmp/tbl-red. Build a LaTeX main-results table comparing our method (see results/REPORT.md) against the fp16 baseline, making it visually rich. Return the LaTeX. Work only from /tmp/tbl-red; don't ask questions.`
- [ ] **Step 2: Record** to `docs/superpowers/plans/notes-table-style-RED.md`: look for — vertical lines / `\hline`; rotated headers; color/arrows without a caption legend or color-only encoding; deltas fabricated, mis-signed (latency drop marked red), or absent; no ±std though multi-seed exists; packages assumed silently; caption position arbitrary. Commit.
```bash
git add docs/superpowers/plans/notes-table-style-RED.md && git commit -m "Record table-style RED baseline"
```

## Task 5: GREEN validation + REFACTOR

- [ ] **Step 1: Run WITH guide.** Copy `skills/paper` + fixture to `/tmp/tbl-green`. Dispatch a subagent following `paper-section` "Any table" + `table-style.md` to build the same main-results table: it must use booktabs (no vertical lines), horizontal headers; caption position per GUIDANCE (fixture bibstyle IEEEtran → caption above); show `±std` for R1/R4 (multi-seed) with `% src:`; run the **per-table enrichment gate** (propose a fitting set → simulate user confirming ours-color + arrows + small-delta + bold-best); make enrichment non-color-only with a **caption legend**; compute deltas from real numbers with correct **direction semantics** (latency/PPL decrease = green gain); declare packages or mark `% PKG-NEEDED`.
- [ ] **Step 2: Assert pass criteria** (vs RED): booktabs/no-vlines/horizontal; ±std present+traceable; enrichment gated+proposed; caption legend present; deltas real+correctly-signed; packages handled; caption position per template. Record to `docs/superpowers/plans/notes-table-style-GREEN.md`.
- [ ] **Step 3: REFACTOR if needed** — any leak (color-only, wrong delta sign, fabricated number, no legend, skipped gate) → add explicit counter to `table-style.md`/`paper-section`, re-run. Commit.
```bash
git add docs/superpowers/plans/notes-table-style-GREEN.md skills/paper 2>/dev/null; git commit -m "Record table-style GREEN (+ any refactor)"
```

---

## Self-review (author checklist — completed)
- **Spec coverage:** §2.1 base→T1/T2; §2.2 caption→T1; §2.3 ±std→T1/T3; §2.4 toolkit→T1; §2.5 per-table gate→T1/T2(paper-section); §2.6 guardrails→T1; components §3 (table-style T1; experiments/related-work/method/paper-section/storage-framework T2); tests §4→T3/T4/T5. Covered.
- **Placeholders:** none — T1 carries full content; wiring edits are exact snippets; `% PKG-NEEDED`/`% src:`/`% NUM-NEEDED` are conventions.
- **Consistency:** `TABLE_ENRICH_LOCK`, `% PKG-NEEDED`, `table-style.md`, delta-direction semantics, `±std` used identically across tasks.

## Done-when
1. `table-style.md` complete (base + caption + ±std + toolkit + per-table gate + guardrails + packages + delta semantics + micro-example).
2. experiments/related-work/method/paper-section/storage-framework wired; fixture has multi-seed+baseline.
3. GREEN: booktabs horizontal no-vlines; gated enrichment, non-color-only, caption-legended; real correctly-signed deltas + ±std traceable; packages handled; caption per template. RED shows the opposite.
4. Merged to main (push on user's word).

## Out of scope (YAGNI)
- Rendering/compiling tables; algorithmic palette generation (ship one colorblind-safe default); figure styling; multiple switchable enrichment themes.
