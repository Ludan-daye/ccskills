# PAPER_REPO_SURVEY
- root: <fixture>
- scanned_at: 2026-07-10
## 1. Research direction
- method_name: SlabQuant
Sources: README.md
## 1t. Terminology
| term_id | canonical | expansion | source_path | status |
|---------|-----------|-----------|-------------|--------|
| T1 | SlabQuant | slab-wise 4-bit KV quantizer | README.md | from-repo(README.md) |
| T2 | WikiText-103 | eval corpus | results/REPORT.md | from-repo(results/REPORT.md) |
| T3 | (baseline name) | fp16 KV cache | results/REPORT.md | needs-user |
## 4. Main results
| claim_id | claim | number/value | source_path |
|----------|-------|--------------|-------------|
| R1 | PPL vs fp16 | +0.12 PPL | results/REPORT.md |
| R2 | KV mem | 3.8x | results/REPORT.md |
| R3 | throughput | 1.9x | results/REPORT.md |
