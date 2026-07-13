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
