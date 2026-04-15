# ccskills

A collection of custom skills for Claude Code.

## Skills

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
