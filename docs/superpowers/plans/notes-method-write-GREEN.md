# method-writing GREEN (with enhancement)

Isolated `/tmp/mw-green` (enhanced skill + fixture incl. `code/slabquant.py`). Agent followed the Method special case end-to-end (5 stages). **PASS.**

## RED failure → GREEN outcome
| RED | GREEN |
|-----|-------|
| No gate; every mechanism became a subsection | Innovation list (I1–I4 + routine bucket) → **INNOVATION_LOCK**; only 2 user-confirmed core points became subsections; lazy-dequant folded into overview as one sentence |
| CLIP_Q inferred intent asserted as fact | M3 marked **needs-confirm** in METHOD_NOTES; asserted as rationale only after simulated user confirmation, resolution recorded in the lock |
| Invented math (own compression-ratio derivation) | 6 formulas all trace to METHOD_NOTES M2/M3 (the mechanism as implemented); no new derivations |
| Experimental numbers in Method (3.8×/1.9×) | grep-verified **zero** experimental content (no 3.8x/1.9x/+0.12/PPL/WikiText/A100 anywhere) |
| Implementation-level remark (uint8/bit-packing) | grep-verified **zero** code identifiers in prose (`SLAB_SIZE`/`_quantize`/`uint8`/… absent); identifiers only in METHOD_NOTES' source_path evidence column |
| No formula verification | **6/6 formulas verified** (symbol provenance, shape/broadcast consistency, mechanism match vs NOTES); 0 issues; `% FORMULA-CHECK` mechanism demonstrated |

## Process discipline confirmed
- Dig produced METHOD_NOTES in **idea language** (M1–M4 + candidate innovations + routine bucket), paths as evidence only.
- Scaffold written **before** prose: setup skeleton + small overview (`\ref{fig:TODO-overview}` + rich `% FIG-NEEDED:`) + per-innovation skeletons with `% Theme / % 原理要点 / % 公式清单`.
- **One subsection per run**: `per-slab-affine-quant` → `[x] drafted`; `slab-partitioning` left `[ ] not drafted` skeleton.
- Every formula wrapped in substantial prose (motivation → each symbol → why this shape); notation defined in setup before use.

## REFACTOR: none needed — complied on the first pass. No skill/guidance edits required.

**Conclusion:** without the enhancement, an agent writes everything as subsections, asserts inferred intent, invents derivations, and pulls experiment numbers into Method; with it, the agent digs ideas (not code), gates the innovation list with the user, scaffolds first, writes one gated subsection with fully verified, prose-wrapped formulas, and keeps Method purely mechanistic.
