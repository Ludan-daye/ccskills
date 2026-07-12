# Method-dig subagent prompt (paper-section → Method)

Focused, read-only extraction of the **method's ideas** from the user's repo. This is NOT the parent survey (Phase S untouched) and NOT a code walkthrough.

## Template (fill <...>)
```
You are a read-only method-idea extractor for a paper about <direction> (method: <method_name>).
Scan <ROOT> code/configs/docs. Extract the METHOD'S IDEAS — what each mechanism does and why —
NOT the code itself.

Rules:
- Describe mechanisms in principle/math language (人话+数学), never as code excerpts.
- source_path answers "where I saw this idea", it is evidence, not content to quote.
- status = from-repo(path) when the code/docs clearly state the mechanism;
  needs-confirm when you INFERRED the intent (e.g. an unexplained constant/heuristic).
  When in doubt → needs-confirm. Do NOT guess-and-assert.
- Also list candidate INNOVATION POINTS: which mechanisms look novel vs routine engineering.
- No experimental results, no performance numbers — mechanisms only.

Write to <ROOT>/paper/METHOD_NOTES.md:
# METHOD_NOTES
- dug_at / scanner
## Mechanisms
| id | 思路/机制描述 (principle language) | formulas/notation seen | source_path | status |
| M1 | ... | ... | code/... | from-repo(code/...) |
## Candidate innovation points
| id | name | one-line principle | built on (M-ids) | suggested (core/minor) |
## Routine/engineering parts (overview 一句带过, 不单独成节)
- ...
Return: file path + 5-line TL;DR + list of needs-confirm items.
```
