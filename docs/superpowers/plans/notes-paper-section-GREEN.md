# paper-section GREEN + REFACTOR

## GREEN (Task 12) — isolated, WITH skill
Skill copied to `/tmp/green-skill` (as if installed); same isolated fixture `/tmp/paper-red-fixture` as RED v2. Agent followed the skill: menu → `CONTENT_LOCK` → (simulated "默认，确认") → draft → Phase-5 self-check.

RED v2 failure → GREEN outcome:
1. **No gate** → presented a survey-cited content menu (rows cite T1–T3 / R1–R3 + paths) and a `CONTENT_LOCK`; drafted only after confirmation.
2. **Result numbers leaked into Method** (RED dumped +0.12 PPL / 3.8× / 1.9×) → none present; R1/R2/R3 appear only as un-valued forward-pointers to `\ref{sec:experiments}`; the sole literal number ("4-bit") is tagged `% src: T1 (README.md)`.
3. **No citation placeholders** → `\cite{TODO:...}` + `% CITE-NEEDED` ×2.
4. **needs-user baseline** → T3 excluded, not invented; used generic "full-precision cache".

Bonus discipline: `% NUM-NEEDED` ×3 for unspecified mechanism detail (not invented), `% FIG-NEEDED`, `% Status → [x] drafted`, Phase-5 Done-when self-check, and correctly declined to patch a blank survey §1 field (repo scanning is the parent's job — respects scope).

## REFACTOR (Task 13) — none needed
GREEN complied on the first pass; no new rationalization or loophole surfaced. `section/SKILL.md` unchanged.

## Conclusion
RED (isolated, no skill) fabricates/leaks results and skips the gate; GREEN (isolated, with skill) gates and stays fully traceable. The skill demonstrably changes behavior.
