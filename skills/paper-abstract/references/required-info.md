# Abstract required information (quick card)

Use with `SKILL.md` Step 1–3. **Extract → fact sheet → format.**

## Must-have slots

| ID | Content | Goes to move |
|----|---------|--------------|
| A1–A3 | Domain, task, why it matters | 1 Context |
| B1–B2 | Status quo + failure | 2 Gap |
| C1–C3 | Name, idea, mechanism | 3–4 Pivot/Approach |
| D* | ≥1 real metric/protocol/baseline/ablation | 5 Evidence |
| F1 | Search keywords | sprinkled in 1–5 |

## Nice-to-have

| ID | Content | Move |
|----|---------|------|
| C4 | What you don’t need (no LLM, frozen enc…) | 4 |
| C5 | ≤3 contributions | 4 or 6 |
| D5 | Latency / size / compression | 5 |
| E* | Generality, honesty limit, code release | 6 |

## Repo extraction cheat sheet

```text
paper/GUIDANCE.md, STRUCTURE.md, FINAL_SYSTEM.md, contributions*
README.md (TL;DR + tables)
paper/abstract.md, main.tex
results/**/REPORT*, *table*, *pareto*, *seeds*.json
REPORT.md, experimental design docs
```

## Format after extract

```text
Context  ← A
Gap      ← B
Pivot    ← C1–C2 (+ diagnostic D4)
Approach ← C3–C4
Evidence ← D
Scope    ← E
```

No new claims beyond the fact sheet.
