---
name: cs-paper-structure
description: >
  Scaffold a CS research paper in official venue LaTeX: ask journal vs conference and
  exact venue, local vs Overleaf compile (and Overleaf Git access if any), log all Q&A
  into a guidance file, download the official template, confirm architecture, then fill
  LaTeX skeletons. Use when starting a 顶会/顶刊 paper, "论文结构", "下载模板",
  "LaTeX 模板", "Overleaf", "先定架构", or preparing camera-ready layout before drafting.
---

# CS Paper Structure (Official LaTeX Scaffold)

For **computer science conference / journal papers**. This skill does **not** write full scientific prose or invent results. It:

1. Clarifies **venue type + exact venue** with the user  
2. Clarifies **compile target**: local LaTeX vs Overleaf (and Git key / remote if Overleaf)  
3. **Writes every Q&A into a guidance text file** (`paper/GUIDANCE.md`) as the lasting brief  
4. Fetches the **official LaTeX style/template** from the venue (or publisher) website  
5. Confirms **section architecture** with the user (aligned to that template)  
6. Fills a **LaTeX project** with section skeletons + theme comments  
7. Optionally writes `paper/STRUCTURE.md` as a bilingual checklist that mirrors the `.tex`  

Later skills (`paper-draft` / `paper-polish`) must **read `paper/GUIDANCE.md` first** and edit the same LaTeX sources.

---

## Hard rules

1. **Venue first.** Do not scaffold template fills until you know **conference vs journal** and the **exact venue name** (and year/track if it matters for the template).  
2. **Compile environment next.** Must know **local vs Overleaf** before promising compile/push steps.  
3. **Log every intake answer to disk.** All Step 0 questions and answers go into `paper/GUIDANCE.md` (create early; update after each answer). This file is the project brief for humans and later skills.  
4. **Never store secrets in the repo.** Do **not** write Git tokens, Overleaf passwords, SSH private keys, or API keys into `GUIDANCE.md` or any project file. Only record: has_key yes/no, remote URL if non-secret, and *where* the user keeps credentials (e.g. “SSH agent”, “env var — not committed”).  
5. **Official template only.** Prefer the venue/publisher official zip/cls/sty. Do **not** invent a fake `\documentclass` that “looks like” the venue. If download fails, stop and ask the user for a local path or URL.  
6. **Confirm architecture** after the template is in hand. Never silently finalize section order.  
7. **No fake content.** Skeleton text only: `% TODO` comments, `\section{}` placeholders, short `% Theme: ...` notes. No fabricated numbers, citations, or abstract claims.  
8. **Do not overwrite** existing main `.tex` / project without confirmation.  
9. Discuss with the user in **Chinese** unless they use English; LaTeX section titles follow the **venue language** (almost always English).

---

## Step 0 — Intake questions (required) + guidance log

Ask **in order**. If the user already answered some items, skip those questions but still **write the known answers** into the guidance file.

As soon as the workspace path is known, create `paper/` and maintain:

**`paper/GUIDANCE.md`** — living record of questions, answers, and operational guidance.

Update this file **after every answered question** (append or fill the template fields). Do not keep answers only in chat memory.

### Q1 — Type

> 这篇准备投 **会议（conference）** 还是 **期刊（journal）**？

### Q2 — Exact venue

> 具体是哪个？请给官方常用名或缩写（例如 NeurIPS 2026、ICML、CVPR、ACL、SOSP、IEEE TPAMI、ACM TOCS、JMLR…）。  
> 若已知：年份、track（main / findings / workshop）、投稿阶段（initial / camera-ready / journal extension）。

### Q3 — Compile environment

> 你打算用哪种方式编译 LaTeX？  
> **A. 本地编译**（TeX Live / MacTeX / MiKTeX + `latexmk` 等）  
> **B. Overleaf**（在线编译）  
> **C. 两者都要**（本地为主同步到 Overleaf，或反过来）

### Q4 — Overleaf Git (only if Q3 is B or C)

> 若使用 Overleaf：项目是否已开启 **Git 同步 / 有 Git 远程**？你是否已配置可用于 push 的 **Git key**（Overleaf Git token 或 SSH key）？  
> - 如果有：请给 **Git remote URL**（可粘贴 `https://git.overleaf.com/...` 或 SSH 形式）。**不要**在聊天里粘贴 token/私钥正文；说明“已配置在本机 credential / SSH agent”即可。  
> - 如果没有：是否需要我按「仅本地骨架 + 你手动上传 zip 到 Overleaf」的方式进行？或你先去 Overleaf 打开 Git 再继续？

### Q5 — Optional context (only if still missing)

- Paper type: method / system / theory / empirical  
- One-line problem + one-line idea  
- Page/column limit if they already know it  
- Existing draft or repo path  
- Local TeX distribution if Q3 is A/C (`which latexmk` / TeX Live year)  

**Gate:** Without Q1+Q2+Q3 answers, do not download official kits or fill section skeletons.  
Q4 is required before any **git push to Overleaf**. Without Git access, still allowed to scaffold locally and give upload instructions.

### `paper/GUIDANCE.md` template (write and keep updated)

```markdown
# Paper setup guidance (intake log)

> 本文件记录用户确认过的投稿与编译约定，供后续写作/改稿 skill 遵守。  
> **禁止**在此文件写入任何 token、密码、私钥。

## 1. Venue

| 项 | 用户回答 | 记录时间 |
|----|----------|----------|
| 类型（会议/期刊） |  |  |
| 具体 venue |  |  |
| 年份 / volume |  |  |
| Track |  |  |
| 阶段（initial / camera-ready / revision） |  |  |

## 2. Compile & sync

| 项 | 用户回答 | 记录时间 |
|----|----------|----------|
| 编译方式 | local / overleaf / both |  |
| Overleaf 项目 | 有 / 无 / 待建 |  |
| Overleaf Git remote URL | （无密钥的 URL；可写 “TBD”） |  |
| Git key 是否已配置 | yes / no / n/a |  |
| 密钥存放方式（勿写密钥内容） | e.g. SSH agent / OS keychain / 用户自行粘贴到 CI — 未配置 |  |
| 首选同步方式 | git push to Overleaf / 手动上传 zip / 仅本地 |  |

## 3. Paper intent (optional)

| 项 | 用户回答 |
|----|----------|
| 论文类型 |  |
| 一句话问题 |  |
| 一句话方法 |  |
| 已有材料路径 |  |

## 4. Q&A transcript

按时间追加，格式固定：

### YYYY-MM-DD HH:MM

- **Q:** …
- **A:** …
- **Guidance:** （这条回答对后续步骤的约束，1–3 句）

## 5. Operational playbook (derived from answers)

根据第 2 节自动维护（agent 填写，用户可改）：

### If local only
- 工作目录：`paper/`
- 编译命令：（填官方 kit 要求，默认 `latexmk -pdf main.tex`）
- 不执行 Overleaf push

### If Overleaf without Git
- 本地生成完整 `paper/` 后打包 zip
- 指导用户：Overleaf → New Project → Upload Project
- 或：替换 Overleaf 项目中的文件后在网站 Compile
- **不要**假装已在线更新

### If Overleaf with Git
- `git remote` 名称约定：`overleaf`（若尚未添加则添加）
- 推送前：确认无密钥进入 commit；确认用户允许 push
- 流程：本地改 → commit → `git push overleaf <branch>`（分支名按 Overleaf 文档，常见 `master`）
- pull 前先说明可能覆盖本地未提交修改

### If both
- 以 Git remote 为桥：本地编译验证 ↔ push Overleaf 在线预览
- 冲突时询问用户以哪边为准

## 6. Template & architecture (filled later)

| 项 | 内容 |
|----|------|
| 官方模板 URL |  |
| 本地 vendor 路径 |  |
| 确认的章节架构 |  |
| main 文件 |  |
| 最近编译结果 |  |
```

After each Q&A, append a **§4 transcript** entry and refresh **§1–2 tables** + **§5 playbook**.

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
├── GUIDANCE.md                # required — Q&A log + compile/sync playbook
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
├── TEMPLATE_SOURCE.md
└── STRUCTURE.md               # optional human checklist
```

Actions:

1. Ensure `paper/GUIDANCE.md` exists and venue/compile answers are already logged.  
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
7. Copy template URL + vendor path + compile command into `GUIDANCE.md` §6.

If multiple templates exist (e.g. review vs camera-ready, journal vs preprint), **ask the user which stage** before filling; log the choice in `GUIDANCE.md`.

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

### 4.5 Compile according to GUIDANCE.md

Read `paper/GUIDANCE.md` §2 / §5 and branch:

**Local (or both):**  
If TeX is available:

```bash
cd paper && latexmk -pdf -interaction=nonstopmode main.tex
```

(or the author-kit command). Record result in `GUIDANCE.md` §6.

- Success: note PDF path.  
- Failure: critical error + fix or blockers. Do not fake success.

**Overleaf only, no Git:**  
Do **not** claim online compile. Package instructions in the report + `GUIDANCE.md` §5 (zip upload path). Optionally create `paper/` ready to zip.

**Overleaf with Git:**  
Only after user confirms push is allowed:

1. Ensure remote exists (e.g. `git remote add overleaf <url>` if missing)  
2. Commit skeleton **without secrets**  
3. `git push overleaf <branch>`  
4. Log push result (success/fail, commit hash) in `GUIDANCE.md` §4–6  

If push fails (auth), update playbook to “manual zip upload” and tell the user how to fix Git auth **without** pasting secrets into files.

---

## Step 5 — Report back

In Chinese (unless user writes English):

1. **Venue:** conference/journal + name + stage  
2. **Compile mode:** local / Overleaf / both — and Git key status (yes/no only)  
3. **Guidance file:** path to `paper/GUIDANCE.md` (remind: all Q&A are there)  
4. **Template source:** official URL + local `paper/vendor/...` path  
5. **Confirmed architecture:** final section list  
6. **Main files:** `main.tex`, section files, `refs.bib`, `TEMPLATE_SOURCE.md`  
7. **Compile / sync status:** local PDF OK/fail; Overleaf push OK/fail/skipped  
8. **Next step:** lock contributions → draft Method in LaTeX (`paper-draft`), or fix Overleaf Git auth  

---

## Anti-patterns

- Scaffolding before knowing journal vs conference and exact venue  
- Ignoring compile mode (local vs Overleaf) or forgetting to ask about Overleaf Git  
- Leaving intake answers only in chat — **must** write `paper/GUIDANCE.md`  
- Committing Overleaf tokens, passwords, or private keys  
- Using a random Overleaf “NeurIPS-like” template instead of the official kit  
- Writing multi-page Method prose in this skill  
- Inventing bibliography entries  
- Ignoring anonymity / page-limit options in the official class  
- Overwriting the user’s existing submission project without asking  
- Claiming Overleaf is updated when only local files changed  

---

## Relationship to other skills

| Skill | Role |
|-------|------|
| `managing-research-projects` | Repo TODO, experiments, data layout |
| **`cs-paper-structure` (this)** | Intake + `GUIDANCE.md` → official LaTeX kit → architecture → skeleton `.tex` (+ Overleaf sync if configured) |
| future `paper-draft` | Read `GUIDANCE.md`, fill section prose **inside** this LaTeX project |
| future `paper-polish` | Read `GUIDANCE.md`, submission-oriented revise |
