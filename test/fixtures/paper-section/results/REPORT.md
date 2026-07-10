# Results
| id | claim | value | note |
|----|-------|-------|------|
| R1 | perplexity vs fp16 baseline | +0.12 PPL @ WikiText-103 | 3-seed mean |
| R2 | KV memory reduction | 3.8x | vs fp16 |
| R3 | throughput | 1.9x tokens/s | A100, batch 32 |
