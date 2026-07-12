# method-writing RED baseline (no enhancement)

Isolated `/tmp/mw-red` (fixture incl. `code/slabquant.py`, no skill docs). Agent asked to "write the Method section with formulas".

## Failures surfaced (exactly the target behaviors)
1. **No gate, no innovation selection.** Drafted the whole section directly — no innovation-point list, no `INNOVATION_LOCK`, no scaffold step. Every mechanism became a subsection (slab partitioning, per-slab quant, lazy-dequant read path, algorithm summary, memory analysis) — including routine parts; violates "总方法(小)+每 subsection 一个创新点，不是每部分都要写".
2. **Inferred intent asserted as fact.** `CLIP_Q=0.999`'s purpose ("bounds influence of heavy-tailed outliers … a standard concern"), "S=64 is fixed a priori and not tuned per layer/head", "recent positions are revisited by attention most frequently" — all **inferences stated as established fact**, no needs-confirm, no user check.
3. **Invented math.** Derived its own compression-ratio formula chain (Eqs. ratio / ratio-asymptotic) and *flagged it itself* as "my own analysis … not extracted from a source" — plausible but exactly the "不发明数学" violation (unverified new derivations presented in submission voice).
4. **Experimental content in Method.** A whole "Memory and Throughput Analysis" subsection pulls **R2 (3.8×) and R3 (1.9×) into Method** and discusses measured-vs-asymptote gaps — direct 零实验 violation.
5. **Implementation-level remark in prose.** A "Remark (implementation vs. analysis)" paragraph discusses uint8 storage/bit-packing — code-level detail that belongs outside Method prose.
6. **No formula verification** of any kind.

## Done well (baseline credit)
- Avoided `\cite{}` (no refs.bib existed) instead of inventing bibkeys; no fabricated figures; notation table up front; formula prose density reasonable.

→ GREEN must show: dig → METHOD_NOTES (ideas + needs-confirm for CLIP_Q) → user-locked innovation list (not every mechanism) → scaffold → per-subsection writing with formula verification, zero experimental numbers, no implementation-level remarks, no invented derivations.
