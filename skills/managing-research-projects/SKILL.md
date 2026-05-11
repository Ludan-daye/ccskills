---
name: managing-research-projects
description: Use when managing a research project, paper, experiment repo, or academic workflow with TODO.md, ROADMAP.md, CHANGELOG.md, README.md, task tables, status flags, related files, completion criteria, verification results, or Chinese 科研项目/TODO List 项目管理.
---

# Managing Research Projects

Use TODO List driven research project management: do not only record tasks; push tasks toward completion with status, related files, completion criteria, and verification results.

## Core Files

Maintain these project entry points:

| File | Purpose |
|---|---|
| `README.md` | Project structure, management rules, execution principles |
| `TODO.md` | Main task table and task details; start here |
| `ROADMAP.md` | Phases, milestones, timeline |
| `CHANGELOG.md` | Important changes, experiments, results, verification updates |

## Default Structure

When initializing a research project, create or preserve this shape unless the repo already has a clearer structure:

```text
Research_Project/
├── README.md
├── TODO.md
├── ROADMAP.md
├── CHANGELOG.md
├── background/
│   ├── papers/
│   ├── notes/
│   ├── related_work.md
│   └── survey.md
├── ideas/
│   ├── problem_definition.md
│   ├── method_ideas.md
│   └── experiment_plan.md
├── experiments/
│   ├── exp_001_baseline/
│   │   ├── config.yaml
│   │   ├── run_log.md
│   │   ├── result.md
│   │   └── todo.md
│   └── exp_002_ablation/
├── code/
│   ├── src/
│   ├── scripts/
│   ├── configs/
│   └── requirements.txt
├── data/
│   ├── raw/
│   ├── processed/
│   └── README.md
├── results/
│   ├── tables/
│   ├── figures/
│   ├── checkpoints/
│   └── result_summary.md
├── paper/
│   ├── outline.md
│   ├── introduction.md
│   ├── method.md
│   ├── experiments.md
│   └── conclusion.md
└── meetings/
    ├── meeting_YYYY_MM_DD.md
    └── advisor_feedback.md
```

Do not overwrite important existing files without confirmation. Add missing files/directories directly when safe.

## TODO Contract

Every task in `TODO.md` must include:

| Field | Requirement |
|---|---|
| ID | Stable tracking ID such as `T001` |
| Status | One of `[ ]`, `[~]`, `[x]`, `[!]` |
| Goal | What this task must accomplish |
| Priority | High/medium/low or project-specific equivalent |
| Related files | Links to code, data, notes, experiments, paper sections |
| Completion criteria | Concrete definition of done |
| Verification result | Actual check, run, review, or reason not verified |
| Updated at | Last change date |

Status meanings:

| Mark | Meaning |
|---|---|
| `[ ]` | Not started |
| `[~]` | In progress |
| `[x]` | Done |
| `[!]` | Blocked or problematic |

Use this compact table for new TODO files:

```markdown
| ID | 状态 | 任务 | 优先级 | 相关文件 | 完成标准 | 验证结果 | 更新时间 |
|---|---|---|---|---|---|---|---|
| T001 | `[~]` | 明确研究问题 | 高 | [问题定义](ideas/problem_definition.md) | 写清对象、问题、动机和创新点 | 待验证 | YYYY-MM-DD |
```

For high-priority tasks, also keep a short task-detail section with this fixed shape:

```markdown
### T001: 明确研究问题

| 项目 | 内容 |
|---|---|
| 状态 | `[~]` 进行中 |
| 目标 | 明确本项目要解决的核心科研问题 |
| 相关文件 | [问题定义](ideas/problem_definition.md)、[领域调研](background/survey.md) |
| 完成标准 | 写清研究对象、已有方法不足、本文切入点和可能创新点 |
| 当前进展 | 已确定大方向，仍需进一步收敛问题 |
| 验证方式 | 检查是否能用一段话讲清楚研究问题 |
| 验证结果 | 待验证 |
```

## Execution Workflow

1. Read `TODO.md` first. If the user names a task, use it; otherwise choose the highest-priority in-progress or unstarted unblocked task.
2. Before editing, confirm the completion criteria, files/logs/configs/tests/pages to inspect, available tools, and whether the action is high risk.
3. Execute ordinary work directly: read files, search, inspect logs, run normal tests, adjust ordinary config, fix ordinary errors, and check outputs.
4. If an error or abnormal result appears, continue through: find issue, analyze cause, attempt fix, verify result, then discuss only if still blocked.
5. Before marking `[x]`, verify as far as practical. Never mark done with `未验证` unless the user explicitly accepts the limitation.
6. Update `TODO.md` status, related files, completion criteria if refined, verification result, and date.
7. Add a concise `CHANGELOG.md` entry for important edits, experiments, results, failures, and verification outcomes.

Ask before deleting data, overwriting important files, committing code, installing high-risk dependencies, using credentials/tokens, spending money, or accessing unauthorized resources.

## Verification

Use the strongest practical check:

| Task type | Verification |
|---|---|
| Script | Run with representative input |
| Code | Run tests or a minimal end-to-end flow |
| Experiment | Inspect logs, saved outputs, and result files |
| Page | Open and visually check display/interaction |
| Document | Check structure, links, and completeness |

If verification cannot be completed, record the reason and the next concrete step in both `TODO.md` and the final report.

## Final Report

Report in simple Chinese unless the user used another language. Include: what changed, result, verification performed, and any unresolved issue with the next step. Keep it short and actionable.
