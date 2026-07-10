---
name: paper-refs
description: >
  Use when gathering related-work / citations for a CS paper — 找相关工作, 搜集引文,
  related work 检索, 参考文献采集. Collects and verifies references; does not write
  the related-work prose or a bib.
---

# Paper Refs (child of `paper`)

**Parent:** `paper` — owns repo scan → `PAPER_REPO_SURVEY.md` + `TERMS.md`.
Gather a **verified** related-work pool around the repo's research direction, then let the user pick which to cite. **Collection only — no prose, no `refs.bib`.**

**REQUIRED BACKGROUND:** `../references/storage-framework.md` (产物契约 / 用户门禁).

## Flow
```text
1 Seed      read paper/PAPER_REPO_SURVEY.md (direction/method/results) + paper/TERMS.md + paper_type
            (survey missing/stale → run parent `paper` Phase S first)
2 Strategy  map paper_type → angles (references/type-strategies.md); CONFIRM type with user
3 Fan-out   split into facets; dispatch search subagents (references/search-agent-prompt.md); over-collect raw ≥100
4 Dedup     merge same paper across links; normalize title/authors/year/venue
5 Verify    batch to verify subagents (references/verify-agent-prompt.md); FETCH each; drop unverifiable + log reason
6 Classify  tag each kept item with its angle
7 Pool      write paper/REFS_POOL.md (≥80 verified; counts collected→verified→dropped) — schema in references/pool-and-shortlist-schema.md
8 Shortlist propose ~20–25 → paper/REFS_SHORTLIST.md table → USER decides → USER_SELECTION lock   ← HARD GATE
```

## Hard rules
1. **No fabricated references.** Every kept item was FETCHED and cross-checked (title/authors/year/venue + claim). Could not fetch → drop.
2. **Seed from the repo direction**, not arbitrary topics.
3. **≥80 verified** in the pool; if short, search more — never silently truncate; always log collected→verified→dropped.
4. **User decides citations.** No item is "selected" before `USER_SELECTION: CONFIRMED`.
5. No unsolicited git push. Chinese discussion.

## Anti-patterns
- Inventing/half-inventing citations or links; keeping an item you couldn't fetch.
- Skipping the type→strategy step; collecting off-direction.
- Writing related-work prose or a `refs.bib` here (later step).
- Auto-picking the cited set without the user gate.

## References
- `references/type-strategies.md`, `references/search-agent-prompt.md`, `references/verify-agent-prompt.md`, `references/pool-and-shortlist-schema.md`
- Parent: `../SKILL.md`; `../references/storage-framework.md`
