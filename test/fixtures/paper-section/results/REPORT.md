# Results
| id | claim | value | note |
|----|-------|-------|------|
| R1 | perplexity vs fp16 (lower better) | 6.42 ± 0.05 | 3-seed mean±std; fp16 baseline 6.30 |
| R2 | KV memory (lower better) | 3.1 GB | vs fp16 baseline 11.8 GB |
| R3 | throughput (higher better) | 1.9x | tokens/s vs fp16, A100 batch 32 |
| R4 | accuracy (higher better) | 85.2 ± 0.3 | 3-seed mean±std; fp16 baseline 80.1 |
