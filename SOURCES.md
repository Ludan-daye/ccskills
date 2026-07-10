# Third-party sources

Vendored skills below are copied for convenience. Upstream remains authoritative; update from source when needed.

| Skill | Upstream | License | Notes |
|-------|----------|---------|--------|
| `karpathy-guidelines` | [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) (`skills/karpathy-guidelines`) | MIT | Karpathy-inspired behavioral rules |
| `frontend-design` | [anthropics/skills](https://github.com/anthropics/skills) (`skills/frontend-design`) | Apache-2.0 | See `skills/frontend-design/LICENSE.txt` |
| `grill-me` | [mattpocock/skills](https://github.com/mattpocock/skills) (`skills/productivity/grill-me`) | See upstream | Thin entry → `grilling` |
| `grilling` | [mattpocock/skills](https://github.com/mattpocock/skills) (`skills/productivity/grilling`) | See upstream | Actual interview workflow |
| `handoff` | [mattpocock/skills](https://github.com/mattpocock/skills) (`skills/productivity/handoff`) | See upstream | Session handoff document |

## First-party

| Skill | Author |
|-------|--------|
| `managing-research-projects` | Ludan-daye / ccskills |
| `paper-structure` | Ludan-daye / ccskills (child of paper; was paper-structure) |
| `paper` | Ludan-daye / ccskills |
| `paper-abstract` | Ludan-daye / ccskills (child of paper) |
| `scheduled-patrol` | Ludan-daye / ccskills |

`paper-structure` section themes draw on standard scientific IMRaD practice and CS paper guidance (e.g. Penn State technical writing guides, MIT EECS Communication Lab Methods guidance); not affiliated with those institutions.

## How these landed here

Packaged into this repo after local install under Grok (`~/.grok/skills/`) for personal skill management and multi-agent reuse (Claude Code / Grok / Cursor).

`paper-abstract` examples quote public arXiv abstracts for pedagogy; structure notes draw on MIT EECS CommLab and Koopman (CMU) abstract guidance.

`paper` skill owns subagent repo survey (`PAPER_REPO_SURVEY.md`); `paper-abstract` is a section child under `skills/paper/abstract/`.
