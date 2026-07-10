# PAPER_REPO_SURVEY template

Subagent fills this file at `ROOT/paper/PAPER_REPO_SURVEY.md`.

```markdown
# PAPER_REPO_SURVEY

- root: <ROOT>
- scanned_at: <ISO timestamp>
- scanner: subagent-explore | subagent-general | parent-fallback
- authoritative_result_doc: <path or TBD>
- obsolete_docs_flagged: <paths>

## 1. Research direction
- area:
- problem:
- research_question:
- method_name:
- method_one_liner:
- paper_type: method | system | theory | empirical | efficiency | diagnosis | mixed
Sources: (paths)

## 2. Story / narrative
- status_quo:
- failure_mode_or_gap:
- key_insight_or_diagnosis:
- proposed_fix:
Sources: (paths)

## 3. Data & evaluation protocol
- train_data:
- eval_data:
- splits_seeds:
- metrics:
- protocol_notes:
Sources: (paths)

## 4. Main results (with paths)
| claim_id | claim (short) | number/value | source_path | note |
|----------|---------------|--------------|------------|------|
| R1 | | | | |

## 5. Ablations / diagnostics (with paths)
| claim_id | claim | number/value | source_path | note |
|----------|-------|--------------|------------|------|

## 6. Baselines / comparisons (with paths)
| claim_id | ours vs whom | number/value | source_path | note |
|----------|--------------|--------------|------------|------|

## 7. Efficiency / deploy (optional)
| claim_id | claim | number/value | source_path | note |
|----------|-------|--------------|------------|------|

## 8. Limitations / honesty
- ...
Sources: (paths)

## 9. Keywords / searchable phrases
- ...

## 10. File index (paths only)
### Narrative / paper
- path — why
### Results
- path — why
### Code / config
- path — why

## 11. Conflicts
- A (path) vs B (path) → recommendation

## 12. Suggested section menu seeds
### For abstract (IDs A/B/C/D/E/F)
- Recommended: …
- Optional: …
### For other sections (later)
- intro: …
- method: …
```
