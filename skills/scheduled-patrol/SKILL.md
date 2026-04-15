---
name: scheduled-patrol
description: >
  Scheduled patrol reporting: automatically wake Claude Code at user-specified intervals to deeply inspect
  all running tasks and processes, verify they are healthy and doing what the user asked, and report
  in a table + one-line summary format. Use this skill when the user says things like "report every X minutes",
  "keep an eye on things", "set up monitoring", "check what's running", "status report", "帮我盯着",
  "每X分钟汇报一次", "定时检查运行情况", or any similar intent to set up periodic task monitoring.
  Even casual requests like "how's it going with those tasks" should trigger this skill.
---

# Scheduled Patrol

Set up a recurring timer that wakes Claude Code at a user-defined interval to **deeply verify** that all running work is progressing correctly, then report in a compact table.

## Core Principle

Users launch background tasks and move on. They don't want to hear "the process is alive" — they want to know **the work is actually progressing as intended**. Each patrol must answer:

> "For every task the user asked me to do — where is it now? Is it doing the right thing? Has it drifted?"

Don't just glance at `ps aux`. Act like a responsible project manager: open the actual outputs, read the content, and confirm it matches expectations.

## Step 1: Capture the User's Full Requirements

This is the most critical step. Before setting any timer, precisely record what the user asked for.

### 1.1 Extract the Task List

Pull every concrete task from the user's message. For example:

> "I have a subagent converting all JS files to TS, another running e2e tests, and a third generating API docs. Report every 10 minutes."

Extract:
1. Convert JS files to TS
2. Run e2e tests
3. Generate API docs

### 1.2 Confirm the Patrol Interval

How often should you check? If the user is vague (e.g., "keep an eye on things"), ask directly:
- "How often would you like me to report? Every 5 minutes, 10, 30?"

### 1.3 Confirm the Monitoring Scope

If the user doesn't specify which tasks, run `TaskList` to discover running tasks and present them for confirmation:
- "I see these tasks currently running: A, B, C. Should I monitor all of them or just specific ones?"

## Step 2: Build the Patrol Prompt and Set the Timer

Use `CronCreate` to schedule recurring wake-ups. **Critical: each wake-up has no memory of previous runs**, so the cron prompt must be fully self-contained:

1. Complete record of the user's original requirements (what each task should be doing)
2. Full inspection procedure
3. Report format template

### Cron Prompt Template

```
You have been woken up for a scheduled patrol. Follow these steps exactly.

## FIRST: Read Patrol State

Before doing anything else, read the file `.patrol_state.json`.
- If it exists: read `patrol_count` (this tells you which patrol number this is) and each task's previous progress data. You need this to determine whether tasks have made progress since last check.
- If it does not exist: this is patrol #1. You will create the file at the end.

## User's Original Requirements

The user asked for the following work. Verify each item is progressing correctly:

1. [Task description with goal, scope, and expected output]
2. [Task description]
3. [Task description]

## Inspection Procedure

### Layer 1: Task Status (required)

1. Run `TaskList` to list all tasks
2. For each in_progress task, run `TaskGet` to get details and latest output
3. Record each task's current status

### Layer 2: Process Verification (required)

4. Run `ps aux | grep -v grep | grep -E '<relevant keywords>'` to confirm processes are alive
5. If background Bash commands are running, read their output files for latest output

### Layer 3: Deep Output Verification (most critical — do not skip)

The purpose of this layer is to verify tasks are **not just running, but doing the right thing**.

6. Locate each task's output files or working directory
7. Use `stat` to check file modification times — are files being updated recently?
8. Use `Read` to read the last 30-50 lines of output files — does the content look correct?
9. Use `wc -l` or `ls | wc -l` to count outputs — are quantities growing?
10. **Cross-check output content against the user's requirements**:
    - If the user asked for "convert JS to TS", read the generated .ts files and verify they contain actual type annotations, not just renamed extensions
    - If the user asked for "run tests", verify test output is continuously producing new results
    - If the user asked for "generate docs", read the docs and verify content is reasonable
    - If output does not match what the user asked for, mark as WRONG

### Layer 4: Progress Comparison (core — this is how you know your patrol number and track progress)

11. Read `.patrol_state.json` (if it exists). This file is your ONLY communication channel with previous patrols — since you have no memory across wake-ups, this file tells you:
    - **Which patrol number this is** (`patrol_count`)
    - **Each task's progress data from last time** (file counts, line counts, timestamps)
    - With this data, you can determine "has there been progress since last check?"
12. If the file does not exist, this is patrol #1 — set `patrol_count` to 1
13. If the file exists, read `patrol_count` and increment by 1, then **compare each task**:
    - Last time file_count was 150, now it's 180 → progress (↑)
    - Last time file_count was 150, still 150 → possibly stuck (→)
    - 2 consecutive patrols with no change → mark STUCK
14. After completing the patrol, update `.patrol_state.json` with current metrics:
    ```json
    {
      "patrol_count": 3,
      "last_check": "2026-04-16T14:37:00Z",
      "tasks": {
        "task_name": {
          "file_count": 180,
          "line_count": 4500,
          "last_modified": "2026-04-16T14:35:22Z",
          "status": "in_progress",
          "unchanged_streak": 0
        }
      }
    }
    ```
    - `unchanged_streak`: how many consecutive patrols this metric has not changed. Reset to 0 on progress, increment on no change. When >= 2, mark STUCK.

## Health Ratings

| Rating | Meaning | Criteria |
|--------|---------|----------|
| OK | Progressing normally | Measurable progress, output content is correct |
| SLOW | Slower than expected | Some progress but rate is notably low |
| STUCK | Stalled | Process alive but no output change for 2+ patrol cycles (`unchanged_streak` >= 2) |
| WRONG | Off track | Process running but output doesn't match user's requirements |
| FAILED | Failed | Process exited, errored, or output contains error/panic |
| DONE | Completed | Task finished |

## Report Format

## Patrol #N — {current time}

| Task | User Asked For | Status | Health | Details |
|------|---------------|--------|--------|---------|
| ... | ... | ... | ... | ... |

> Patrol #N summary: one-line overall status.

Rules:
- #N is the patrol number from `.patrol_state.json` `patrol_count` — lets the user instantly see which check this is
- "User Asked For" column: brief description of what this task should be doing
- "Details" column: must contain concrete data (file counts, line counts, timestamps, percentages)
- If health is STUCK/WRONG/FAILED, explain why in details
- If comparing with previous patrol, use ↑ ↓ → trend markers (e.g., `180 files ↑ prev 150`)
- If all tasks are complete, remind user to cancel the patrol
- Summary line starts with "Patrol #N:"
```

### Cron Expression Reference

- Every 5 minutes: `*/5 * * * *`
- Every 10 minutes: `*/10 * * * *`
- Every 30 minutes: `3,33 * * * *` (avoid :00 and :30)
- Every hour: `7 * * * *` (avoid :00)

Per CronCreate conventions, avoid scheduling at :00 and :30 marks.

## Step 3: Confirm Timer is Active

After calling CronCreate, do two things:

1. **Tell the user the setup is complete**, including:
   - The patrol interval
   - Which tasks are being monitored
   - Approximate time of next patrol
2. **Run the first patrol immediately** — don't make the user wait for the first cron cycle. Execute the full inspection procedure right away and deliver an initial status report. This gives the user instant visibility and validates the patrol logic.

## Step 4: Report Format Details

**Use this format strictly — no filler text:**

```markdown
## Patrol #3 — 14:47

| Task | User Asked For | Status | Health | Details |
|------|---------------|--------|--------|---------|
| Data cleaning | Clean 5000-row CSV | in_progress | OK | 3200/5000 rows processed ↑ prev 2400, output.csv updated 14:45, content format verified |
| API tests | Test all endpoints | in_progress | SLOW | 12/50 done, only 2 completed in last 8 min |
| File conversion | JS to TS | in_progress | WRONG | Process running but .ts files only have renamed extensions, no type annotations |

> Patrol #3: cleaning on track; API tests slow, watch closely; file conversion may be off — check conversion logic.
```

**Rules:**
- One row per task, never merge
- "User Asked For" column: brief expected outcome so user can compare "what should be done vs what is being done"
- "Details" column: concrete data only (counts, timestamps, percentages) — no vague descriptions
- Use `↑` `↓` `→` trend markers when comparing to previous patrol (e.g., `3200 rows ↑ prev 2400`)
- Summary line: one sentence covering the full picture; call out anomalies explicitly
- If everything is normal with no changes, still report but keep it brief

## Step 5: Exception Handling

When a patrol finds serious issues:

- **STUCK**: Flag prominently, state how long it's been stuck (how many patrol cycles), recommend user intervention
- **WRONG**: Flag prominently, explain what the output should look like vs what it actually looks like
- **FAILED**: Read error messages, include the actual error content in the report
- **All tasks completed**: Report completion status, proactively tell the user "All tasks complete — you can cancel the patrol" and suggest the cancellation command

## Example Conversation

**User:** I have three background tasks: subagent A converting JS to TS in src/, subagent B running pytest, and a build process compiling the project. Report every 10 minutes.

**Claude:** OK, patrol set up every 10 minutes monitoring:

1. Subagent A — JS to TS conversion (src/)
2. Subagent B — pytest
3. Build process — project compilation

Running the first patrol now:

## Patrol #1 — 14:27

| Task | User Asked For | Status | Health | Details |
|------|---------------|--------|--------|---------|
| Subagent A | JS→TS in src/ | in_progress | OK | 23/89 files converted, latest user.ts created 14:25, contains type annotations ✓ |
| Subagent B | Run pytest | in_progress | OK | 47/120 tests run, 38 passed 9 running, 0 failures |
| Build | Compile project | in_progress | OK | webpack compiling, output updated 14:26, no errors |

> Patrol #1: All three tasks progressing normally. Next patrol ~14:37.

*(10 minutes later, auto wake-up)*

## Patrol #2 — 14:37

| Task | User Asked For | Status | Health | Details |
|------|---------------|--------|--------|---------|
| Subagent A | JS→TS in src/ | in_progress | OK | 52/89 files ↑ prev 23, content verified correct |
| Subagent B | Run pytest | in_progress | SLOW | 58/120 ↑ prev 47, only 11 tests in 10 min — some tests may be heavy |
| Build | Compile project | completed | DONE | Finished 14:31, dist/ directory generated, no errors |

> Patrol #2: Build complete; A progressing well; B slower than expected, monitor closely.

## Cancelling the Patrol

User can say "stop patrol", "cancel monitoring", or "停止巡检" at any time. Use `CronDelete` to remove the scheduled job and confirm cancellation.
