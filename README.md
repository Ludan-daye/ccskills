# ccskills

A collection of custom skills for Claude Code.

## Skills

### managing-research-projects

TODO-led research project management — use `TODO.md` as the main execution entry point and keep each research task tied to status, related files, completion criteria, verification results, and changelog updates.

**Features:**
- Research project structure for background, ideas, experiments, code, data, results, paper, and meetings
- Task tracking contract with ID, status, priority, related files, completion criteria, verification result, and update date
- Execution workflow that starts from `TODO.md`, verifies work before completion, and records important changes in `CHANGELOG.md`
- Chinese-friendly task tables and reporting for 科研项目管理

**Usage:** Tell Claude Code something like:
- "Use the research project manager skill to initialize my paper project"
- "用 TODO List 方式管理这个科研项目"
- "Update TODO.md after running the baseline experiment"

### scheduled-patrol

Scheduled patrol reporting — automatically wakes Claude Code at user-specified intervals to deeply inspect all running tasks and processes, verify they are healthy and doing what the user asked, and report in a structured table format.

**Features:**
- Four-layer deep inspection: task status → process verification → output content validation → progress comparison
- Cross-patrol state tracking via `.patrol_state.json` (patrol count, unchanged streak)
- Health ratings: OK / SLOW / STUCK / WRONG / FAILED / DONE
- Immediate first patrol on setup
- "User Asked For" column for requirement traceability

**Usage:** Tell Claude Code something like:
- "Report every 10 minutes"
- "Keep an eye on my background tasks"
- "每5分钟汇报一次运行情况"

## Installation

Copy the skill folder into your Claude Code skills directory, or install the `.skill` package file.
