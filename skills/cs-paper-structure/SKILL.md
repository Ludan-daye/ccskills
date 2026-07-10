---
name: cs-paper-structure
description: >
  Scaffold a CS research paper in official venue LaTeX: first ask journal vs conference
  and the exact venue, download the official format/template from the venue site, confirm
  section architecture with the user, then fill LaTeX section skeletons (plus optional
  STRUCTURE.md map). Use when starting a 顶会/顶刊 paper, "论文结构", "下载模板",
  "LaTeX 模板", "先定架构", or preparing camera-ready layout before drafting prose.
---

# CS Paper Structure (Official LaTeX Scaffold)

For **computer science conference / journal papers**. This skill does **not** write full scientific prose or invent results. It:

1. Clarifies **venue type + exact venue** with the user  
2. Fetches the **official LaTeX style/template** from the venue (or publisher) website  
3. Confirms **section architecture** with the user (aligned to that template)  
4. Fills a **LaTeX project** with section skeletons + theme comments  
5. Optionally writes `paper/STRUCTURE.md` as a bilingual checklist that mirrors the `.tex`  

Later skills (`paper-draft` / `paper-polish`) edit the same LaTeX sources.

---

## Hard rules

1. **Venue first.** Do not scaffold files until you know **conference vs journal** and the **exact venue name** (and year/track if it matters for the template).  
2. **Official template only.** Prefer the venue/publisher official zip/cls/sty. Do **not** invent a fake `\documentclass` that “looks like” the venue. If download fails, stop and ask the user for a local path or URL.  
3. **Confirm architecture** after the template is in hand (templates already imply section commands and length). Never silently finalize section order.  
4. **No fake content.** Skeleton text only: `% TODO` comments, `\section{}` placeholders, short `% Theme: ...` notes. No fabricated numbers, citations, or abstract claims.  
5. **Do not overwrite** existing main `.tex` / project without confirmation.  
6. Discuss with the user in **Chinese** unless they use English; LaTeX section titles follow the **venue language** (almost always English).

---

## Step 0 — Ask venue (required, before anything else)

Ask **in order**. If the user already answered some items, skip those.

### Q1 — Type

> 这篇准备投 **会议（conference）** 还是 **期刊（journal）**？

### Q2 — Exact venue

> 具体是哪个？请给官方常用名或缩写（例如 NeurIPS 2026、ICML、CVPR、ACL、SOSP、IEEE TPAMI、ACM TOCS、JMLR…）。  
> 若已知：年份、track（main / findings / workshop）、投稿阶段（initial / camera-ready / journal extension）。

### Q3 — Optional context (only if still missing)

- Paper type: method / system / theory / empirical  
- One-line problem + one-line idea  
- Page/column limit if they already know it  
- Existing draft or repo path  

**Gate:** Without Q1+Q2 answers, do not download or create paper files.

Record answers in a short internal summary, e.g.:

```text
venue_type: conference | journal
venue_name: ...
year_or_volume: ...
track: ...
stage: initial | camera-ready | revision
```

---

## Step 1 — Locate and download the official format

### 1.1 Find the official source

Use web search / open pages. Priority order:

| Priority | Source |
|----------|--------|
| 1 | Venue **author kit / call for papers / submission instructions** page for the correct year |
| 2 | Publisher portal (IEEE Author Center, ACM Master Article Template, Springer LNCS, Elsevier, OpenReview/ML conference site, CVF, ACL pub kit, USENIX, etc.) |
| 3 | User-supplied URL or local zip/cls |

**Examples of what “official” looks like (illustrative, always re-verify for the year):**

- ML conferences: often `*.zip` style kit on the conference site or linked from CFP  
- CVF (CVPR/ICCV/ECCV): CVF author guidelines + LaTeX  
- ACL anthology pubs: official ACL pub checklist / LaTeX  
- IEEE journals/conferences: IEEE template (often via IEEE / conference site)  
- ACM: ACM consolidated template (`acmart`)  
- Springer LNCS: LNCS author package  

### 1.2 Download into the project

Preferred layout:

```text
paper/
├── vendor/                    # official kit, unmodified when possible
│   └── <venue>-template/      # extracted zip
├── main.tex                   # our working main (or venue’s main renamed)
├── sections/                  # optional split files
│   ├── abstract.tex
│   ├── intro.tex
│   ├── related.tex
│   ├── method.tex
│   ├── experiments.tex
│   ├── limitations.tex
│   └── conclusion.tex
├── refs.bib
├── figures/
└── STRUCTURE.md               # optional human checklist
```

Actions:

1. Create `paper/` if needed.  
2. Download zip/PDF instructions with `curl`/`wget` or browser-equivalent tools available.  
3. Extract under `paper/vendor/<venue>-template/`.  
4. Identify the **main example** `.tex` and required `.cls` / `.sty` / fonts.  
5. Copy or symlink style files so `main.tex` compiles from `paper/` (document how you resolved paths).  
6. Write `paper/TEMPLATE_SOURCE.md` with:
   - venue name + year  
   - official URL(s) used  
   - download date  
   - package filename + hash if easy  
   - compile command (e.g. `latexmk -pdf main.tex`)  

If multiple templates exist (e.g. review vs camera-ready, journal vs preprint), **ask the user which stage** before filling.

### 1.3 Failure handling

If official kit cannot be found or is behind login:

1. Tell the user what you tried (URLs).  
2. Ask them to upload the zip or paste the author-kit link.  
3. Do **not** proceed with a guessed template.

---

## Step 2 — Read the template, then confirm architecture

Open the official example `.tex` and author guidelines. Extract:

- Document class and options (e.g. dual column, anonymous review)  
- Default front matter (title, authors, abstract environment)  
- Recommended or example **section headings**  
- Page limit, bibliography style (`.bst` / biblatex)  
- Whether dual submission anonymity is required  

### Default CS research body (propose, then adapt to template)

```text
1. Abstract
2. Introduction
3. Related Work
4. Method          (Approach / System / Model — match venue wording)
5. Experiments     (Evaluation / Results)
6. Limitations
7. Conclusion
```

### Common variants

| Variant | When |
|---------|------|
| Related Work after Method/Experiments | Common in some ML papers |
| Limitations folded into Discussion/Conclusion | Short conference papers; keep a `% Limitations` subsection at minimum |
| Separate Results + Discussion | More common in journals |
| Preliminaries / Background / Problem Setup | Theory or heavy notation papers |
| Ethics / Reproducibility / Impact statements | Venue checklist (NeurIPS-style, etc.) |

Present to the user:

1. What the **official template** expects (class, anonymity, bib style, page limit if stated)  
2. Proposed **section list** (mapped to LaTeX `\section` / `\subsection` titles)  
3. Recommended **write order** (Method → Experiments → Intro → RW → Limitations → Conclusion → Abstract last)  

Ask:

> 请确认：会议/期刊模板是否用这份官方包？章节架构是否按以上列表？需要增删/改名/调序吗？

**Do not write skeleton body files until they confirm.**

---

## Step 3 — Section theme catalog (for comments + STRUCTURE.md)

When filling LaTeX, put a short `% Theme / Must include / Done when` block under each section. Use this catalog:

### Abstract

- **Theme:** Standalone summary — problem, method, key evidence, takeaway  
- **Must include:** closed loop; prefer quantitative highlight when real numbers exist  
- **Must not:** claims absent from body; hype; heavy citations  
- **Done when:** reader can restate contribution without the paper  

### Introduction

- **Theme:** Narrative + testable contributions  
- **Must include:** motivation → gap → high-level idea → contributions list → optional roadmap  
- **Must not:** full method detail; RW-style survey  
- **Done when:** reviewer can recite ~3 contributions; gap matches method  

### Related Work

- **Theme:** Positioning and differentiation  
- **Must include:** topic clusters; explicit same/different axes; closest baselines  
- **Must not:** uncritical laundry list; missing direct competitors  
- **Done when:** reader knows who we compare to and why we are different  

### Method

- **Theme:** Technical contribution — what and why  
- **Must include:** setup/formalism → overview → modules → design rationale  
- **Must not:** full hyperparameter tables (put in Experiments)  
- **Done when:** a peer could reimplement the core idea  

### Experiments

- **Theme:** Evidence for claims  
- **Must include:** protocol, data, baselines, main results, ablations/analysis  
- **Must not:** claims without tables/figures; hidden protocol  
- **Done when:** each major claim maps to a figure/table  

### Limitations

- **Theme:** Failure modes and scope  
- **Must include:** honest assumptions, data/compute limits, negative findings  
- **Must not:** fake humility; pure “future work” marketing  
- **Done when:** obvious reviewer attacks are pre-framed without voiding claims  

### Conclusion

- **Theme:** Close the loop  
- **Must include:** problem/method recap, findings, contribution echo, restrained outlook  
- **Must not:** new experimental claims  
- **Done when:** consistent with Abstract/Intro  

---

## Step 4 — Fill LaTeX (main deliverable)

After confirmation:

### 4.1 Create working `main.tex`

- Start from the **official example** in the vendor kit (preserve required preamble).  
- Set placeholder title/authors (`Anonymous` if blind review).  
- Keep venue options (e.g. `anonymous`, `twocolumn`) as required for the chosen stage.  
- Use `\input{sections/...}` **only if** it does not break the template; some kits require a single file — then keep one `main.tex` with clear `% ==== Section ====` markers.

### 4.2 Section skeleton pattern

For each confirmed section:

```latex
% =============================================================================
% Section: Introduction
% Theme: narrative + testable contributions
% Must include: motivation, gap, idea, contributions
% Done when: reviewer can list ~3 contributions
% Status: [ ] not drafted
% =============================================================================
\section{Introduction}
\label{sec:intro}

% TODO: motivation (1--2 paragraphs)
% TODO: gap / limitations of prior work (high level; detail in Related Work)
% TODO: our idea (high level only)
% TODO: contributions (enumerate, testable)
% TODO: optional paper roadmap

% Placeholder paragraph — replace when drafting (paper-draft skill).
We will describe the problem motivation, the gap in prior work, our high-level
approach, and list testable contributions here.
```

Use the venue’s preferred heading strings when known (e.g. `Related Work` vs `Related Works`, `Experiments` vs `Evaluation`).

### 4.3 Front/back matter

- Abstract: use the template’s `abstract` environment, with `% TODO` bullets inside comments + one short placeholder sentence.  
- Keywords if the template has them.  
- `\bibliographystyle` / biblatex: keep **official** style; create empty `refs.bib` with a comment header.  
- Limitations: own `\section` or `\subsection` under Discussion/Conclusion per user confirmation.  

### 4.4 Optional `paper/STRUCTURE.md`

Mirror architecture, themes, claim→evidence map, writing order, and paths to `.tex` files. This is for humans and other skills; **LaTeX remains source of truth for submission layout.**

### 4.5 Try compile (best effort)

If TeX is available:

```bash
cd paper && latexmk -pdf -interaction=nonstopmode main.tex
```

(or the command documented in the author kit).  

- Success: note PDF path.  
- Failure: paste the critical error, fix missing style paths if caused by our layout, otherwise report blockers (fonts, old TeX live). Do not fake a successful build.

---

## Step 5 — Report back

In Chinese (unless user writes English):

1. **Venue:** conference/journal + name + stage  
2. **Template source:** official URL + local `paper/vendor/...` path  
3. **Confirmed architecture:** final section list  
4. **Main files:** `main.tex`, section files, `refs.bib`, `TEMPLATE_SOURCE.md`  
5. **Compile status:** OK / failed + why  
6. **Next step:** lock contributions → draft Method in LaTeX (`paper-draft`), or adjust template options  

---

## Anti-patterns

- Scaffolding before knowing journal vs conference and exact venue  
- Using a random Overleaf “NeurIPS-like” template instead of the official kit  
- Writing multi-page Method prose in this skill  
- Inventing bibliography entries  
- Ignoring anonymity / page-limit options in the official class  
- Overwriting the user’s existing submission project without asking  

---

## Relationship to other skills

| Skill | Role |
|-------|------|
| `managing-research-projects` | Repo TODO, experiments, data layout |
| **`cs-paper-structure` (this)** | Venue → official LaTeX kit → confirmed architecture → skeleton `.tex` |
| future `paper-draft` | Fill section prose **inside** this LaTeX project |
| future `paper-polish` | Submission-oriented revise (clarity, claims, length) |
