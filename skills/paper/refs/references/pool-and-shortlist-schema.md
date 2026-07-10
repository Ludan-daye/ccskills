# REFS_POOL.md & REFS_SHORTLIST.md schemas

Both live in the user repo under `<ROOT>/paper/`.

## `paper/REFS_POOL.md` — verified pool (≥80)
```markdown
# REFS_POOL — <direction>
- seeded_from: paper/PAPER_REPO_SURVEY.md ; paper_type: <type>
- counts: collected <raw> → verified <M≥80> → dropped <K>

## Angle: <lineage | competing | existing-explanation | foundation | prior-result>
| id | title | authors | year | venue | tier | link | content_summary | why_relevant | verify |
|----|-------|---------|------|-------|------|------|-----------------|--------------|--------|
| P01 | … | … | 2025 | NeurIPS | top | https://… | … | … | verified(fetched) |

## Dropped / quarantine
| claimed_title | link | reason |
|---------------|------|--------|
```

## `paper/REFS_SHORTLIST.md` — ~20–25 proposed → user decides
```markdown
# REFS_SHORTLIST (propose → user decides)
- from: paper/REFS_POOL.md (verified M)

| id | title | venue/year | angle | why_cite | link | 建议 | 用户决定 |
|----|-------|-----------|-------|----------|------|------|----------|
| P01 | … | NeurIPS'25 | lineage | 直接前驱 | https://… | 推荐 |  |

## USER_SELECTION   (locked ONLY after the user confirms)
- Included: <ids>
- Excluded: <ids>
- Status: CONFIRMED
```

**Selection principle:** cover every active angle, prefer recent + top-tier + highest relevance; the shortlist is a *proposal* — the user's `USER_SELECTION: CONFIRMED` is the gate. The confirmed set is the input to later writing / `refs.bib` (not produced here).
