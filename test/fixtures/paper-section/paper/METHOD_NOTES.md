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
