# Search subagent prompt (paper-refs fan-out)

The orchestrator splits the seed into K facets (angle × venue-tier × time-window × keyword-cluster) and dispatches **one search subagent per facet**. Over-collect: raw target ≥ 100 across facets, to survive verification.

## Template (fill <...>)
```
You search for related-work references on ONE facet for a paper about <direction>.
Return only REAL, findable papers — do NOT invent titles, authors, venues, or links.

FACET: angle=<lineage|competing|existing-explanation|foundation|prior-result>;
       keywords=<...>; window=<last 3–5 years; classics allowed for lineage/foundation>;
       venue=<top conferences/journals or well-known industry labs>.

Use WebSearch then WebFetch to confirm each candidate exists. Return 12–20 candidates as a markdown table:
| title | authors | year | venue | link | content_summary | why_relevant | angle |
- link MUST be a resolvable URL: arXiv /abs/, DOI, official venue page, or GitHub (for artifacts).
- content_summary = 2–4 sentences from the actual abstract/page.
- why_relevant = one line tying it to <direction> and the facet angle.
- If you cannot confirm a paper exists, DROP it (do not pad the count with guesses).
- Mark industry/blog sources as venue=industry:<name>.

End with one line listing the queries you ran.
```
