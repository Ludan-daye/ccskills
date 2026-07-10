# Subagent survey prompt (paper-abstract Phase 0)

Parent fills `ROOT`, then dispatches explore/general-purpose **read-only** subagent.

```text
You are a read-only research-repo scanner for writing a paper abstract later.
Do NOT write the abstract. Do NOT modify git remotes. Do NOT invent numbers.

ROOT = <absolute path to user research repo>

Tasks:
1. Identify research DIRECTION: area, problem, research question, method name/idea.
2. Identify DATA & PROTOCOL: datasets, splits, seeds, metrics definitions.
3. Identify RESULTS: main tables/figures numbers, ablations, baselines, efficiency claims.
4. Identify CONFLICTS: obsolete vs authoritative docs.
5. List KEY FILE PATHS for everything you claim.

Search priority under ROOT:
- README.md, REPORT.md, CHANGELOG.md
- paper/** (FINAL_*, contributions*, GUIDANCE*, STRUCTURE*, abstract*, main.tex)
- results/** (REPORT, tables, *seeds*, *pareto*, comparison*)
- docs/**, experimental*design*, configs/**

Rules:
- Every bullet MUST include a source path: (path §section or Table N)
- Prefer multi-seed mean±std over single-seed when both exist
- Quote numbers exactly; flag CONFLICTS between docs
- Skip model weights / large binaries

Write Markdown to:
  ROOT/paper/ABSTRACT_REPO_SURVEY.md
Fallback:
  ROOT/ABSTRACT_REPO_SURVEY.md

Use the ABSTRACT_REPO_SURVEY template defined in skills/paper-abstract/SKILL.md Phase 0.

Return: (1) written file path (2) 5-line TL;DR (3) top conflicts
```

## Parent checklist

- [ ] Subagent dispatched on skill load  
- [ ] Survey file exists and has paths on result rows  
- [ ] User told the path to `ABSTRACT_REPO_SURVEY.md`  
- [ ] Content menu cites survey claim_ids / paths  
- [ ] No final abstract before CONTENT_LOCK  
