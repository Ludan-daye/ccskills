---
name: paper-structure
description: >
  Use when scaffolding a CS paper's LaTeX project — 论文结构, 搭骨架, 下载模板,
  LaTeX/Overleaf, 先定架构, IEEE/venue 模板, 确认章节架构. Not for section prose
  (paper-section) or the abstract (paper-abstract).
---

# Paper Structure (child of `paper`)

**Parent:** `paper` — owns subagent scan → `paper/PAPER_REPO_SURVEY.md`.  
**This skill:** IEEE/venue LaTeX + GUIDANCE + architecture + skeletons only (no full-repo scan).

# CS Paper Structure (Official LaTeX Scaffold)

For **computer science conference / journal papers**. This skill does **not** write full scientific prose or invent results. It:

1. Clarifies **venue type + exact venue** with the user (**default template = IEEE** if unspecified)  
2. Clarifies **compile target**: local LaTeX vs Overleaf (and Git key / remote if Overleaf)  
3. **Writes every Q&A into a guidance text file** (`paper/GUIDANCE.md`) as the lasting brief  
4. Fetches the **official LaTeX style/template** (IEEE by default; venue-specific when named)  
5. Confirms **section architecture** with the user (aligned to that template)  
6. Fills a **LaTeX project** with section skeletons + theme comments  
7. Optionally writes `paper/STRUCTURE.md` as a bilingual checklist that mirrors the `.tex`  

Later skills (`paper-section` / `paper-polish` / `paper-abstract`) must **read `paper/GUIDANCE.md` first** and edit the same LaTeX sources. If no template is chosen yet, **write in IEEE / IEEEtran format**.

---

## Hard rules

1. **Default template is IEEE.** If the user does **not** name a specific venue, or says “随便 / 先写着 / 默认格式 / 通用模板”, use the **official IEEE LaTeX package (IEEEtran)** downloaded from IEEE (or CTAN as fallback). Do **not** invent a home-grown class.  
2. **Venue when known.** If they name NeurIPS / ACL / ACM / Springer / a specific IEEE Transactions, prefer **that venue’s official kit**; still log it in GUIDANCE. Many IEEE venues still use IEEEtran—use the mode they require (`conference` vs `journal`).  
3. **Ask type early, but do not block forever on exact venue.** Q1 (conference vs journal) is enough to pick IEEE conference vs journal mode. Exact venue (Q2) remains strongly preferred for submit links; if user defers, set `venue_name: IEEE-default (unspecified)` and proceed with IEEE.  
4. **Compile environment next.** Must know **local vs Overleaf** before promising compile/push steps.  
5. **Log every intake answer to disk.** All Step 0 questions and answers go into `paper/GUIDANCE.md` (create early; update after each answer). This file is the project brief for humans and later skills.  
6. **Never store secrets in the repo.** Do **not** write Git tokens, Overleaf passwords, SSH private keys, or API keys into `GUIDANCE.md` or any project file. Only record: has_key yes/no, remote URL if non-secret, and *where* the user keeps credentials (e.g. “SSH agent”, “env var — not committed”).  
7. **Official template only.** Prefer the venue/publisher official zip/cls/sty. Do **not** invent a fake `\documentclass` that “looks like” the venue. If download fails, stop and ask the user for a local path or URL.  
8. **Confirm architecture** after the template is in hand. Never silently finalize section order.  
9. **No fake content.** Skeleton text only: `% TODO` comments, `\section{}` placeholders, short `% Theme: ...` notes. No fabricated numbers, citations, or abstract claims.  
10. **Do not overwrite** existing main `.tex` / project without confirmation.  
11. Discuss with the user in **Chinese** unless they use English; LaTeX section titles follow the **venue language** (almost always English).

---

## Step 0 — Intake questions (required) + guidance log

Ask **in order**. If the user already answered some items, skip those questions but still **write the known answers** into the guidance file.

As soon as the workspace path is known, create `paper/` and maintain:

**`paper/GUIDANCE.md`** — living record of questions, answers, and operational guidance.

Update this file **after every answered question** (append or fill the template fields). Do not keep answers only in chat memory.

### Q1 — Type

> 这篇准备投 **会议（conference）** 还是 **期刊（journal）**？  
> （若尚未定 venue：**默认按 IEEE 格式**搭 LaTeX；会议用 `IEEEtran` conference 模式，期刊用 journal 模式。）

### Q2 — Exact venue

> 具体是哪个？请给官方常用名或缩写（例如 NeurIPS 2026、ICML、CVPR、ACL、SOSP、IEEE TPAMI、ACM TOCS、JMLR…）。  
> 若已知：年份、track（main / findings / workshop）、投稿阶段（initial / camera-ready / journal extension）。  
> **若暂时不定：** 回复「先用默认 / IEEE」即可 → 使用官方 **IEEE IEEEtran** 模板继续。

Log in GUIDANCE:

- If named venue → `template_policy: venue-official`  
- If deferred → `template_policy: IEEE-default` + note user can switch later  

### Q2b — Submission links（投稿入口）

在知道具体 venue 后，**必须**把「投稿相关链接」写进 `GUIDANCE.md`（用户可提供；未提供则 agent 上网查官方页并填入，标注来源与查证日期）。

若 **IEEE-default（未指定 venue）**，至少写入：

| 类型 | 默认 URL（查证后可更新） |
|------|--------------------------|
| IEEE 会议模板页 | https://www.ieee.org/conferences/publishing/templates |
| IEEE 期刊 / Author Center 模板 | https://template-selector.ieee.org/ 与 IEEE Author Center article templates |
| CTAN IEEEtran（备用） | https://ctan.org/pkg/ieeetran |

尽量收集并记录（能找到多少写多少，找不到写 `TBD` + 已尝试的检索词）：

| 链接类型 | 说明 | 常见例子 |
|----------|------|----------|
| **投稿系统 / Submit** | 实际上传稿件的入口 | OpenReview、HotCRP、CMT、Softconf、IEEE Author Portal、ScholarOne、Editorial Manager |
| **会议/期刊主页** | 当届或期刊官方站 | `https://neurips.cc/Conferences/2026/`、期刊 homepage |
| **CFP / Author guidelines** | 截稿、格式、政策 | Call for Papers、Author Instructions |
| **官方 LaTeX / author kit** | 模板下载页（可与 TEMPLATE_SOURCE 交叉引用） | Author kit zip 页面 |
| **重要日期页** | deadline / rebuttal / camera-ready | Dates / Important dates |

问用户时可用：

> 你是否已有**投稿系统链接**（OpenReview / HotCRP / CMT / 期刊投稿系统等）？若有请直接贴 URL。  
> 没有的话我会按 venue 名称去查官方投稿页，并写入 `GUIDANCE.md`。

**规则：**

- 只写 **https 公开链接**，不要写需要登录才能看到的一次性 token 链接（若用户只给了带 token 的 URL，记「用户提供了私有链接 — 未写入仓库」并请其提供可分享的官方页）。  
- 每个链接旁注明：`用户提供` 或 `agent 查证 YYYY-MM-DD` + 页面标题。  
- 查到多个候选时，列 2–3 个并请用户确认主投稿入口，再把「已确认」标在表里。  
- 期刊还要尽量写：Editorial Manager / ScholarOne 等 **Manuscript submission** 入口，而不仅是期刊介绍页。

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

**Gate:** Without **Q1 + Q3** answers, do not download kits or fill skeletons.  
**Q2** may be “IEEE-default / 未指定”.  
Q4 is required before any **git push to Overleaf**. Without Git access, still allowed to scaffold locally and give upload instructions.

完整 GUIDANCE.md 模板见 **`references/guidance-template.md`**。intake 时据此创建并逐问更新。

---

## Step 1 — Locate and download the official format
默认 IEEE IEEEtran；指定 venue 用其官方包。完整下载源、优先级、目录布局、失败处理见 **`references/template-sources.md`**。下载后写 `paper/TEMPLATE_SOURCE.md` 并回填 GUIDANCE §1b/§6。

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

## Step 3 — Section themes
各节 Theme / Must include / Must not / Done-when 见 **`../references/section-themes.md`**（与 `paper-section` 共用）。填骨架注释时引用它。

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

% Placeholder paragraph — replace when drafting (paper-section skill).
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
2. **Submission links:** primary submit URL + CFP/homepage (from `GUIDANCE.md` §1b; note 已确认/待确认)  
3. **Compile mode:** local / Overleaf / both — and Git key status (yes/no only)  
4. **Guidance file:** path to `paper/GUIDANCE.md` (remind: all Q&A + links are there)  
5. **Template source:** official URL + local `paper/vendor/...` path  
6. **Confirmed architecture:** final section list  
7. **Main files:** `main.tex`, section files, `refs.bib`, `TEMPLATE_SOURCE.md`  
8. **Compile / sync status:** local PDF OK/fail; Overleaf push OK/fail/skipped  
9. **Next step:** lock contributions → draft Method in LaTeX (`paper-section`), or fix Overleaf Git auth  

---

## Anti-patterns

- Blocking forever because the user has not named a venue (use **IEEE default** instead)  
- Using a random “IEEE-like” Overleaf clone instead of **official IEEE / IEEEtran** sources  
- Ignoring compile mode (local vs Overleaf) or forgetting to ask about Overleaf Git  
- Leaving intake answers only in chat — **must** write `paper/GUIDANCE.md`  
- Committing Overleaf tokens, passwords, or private keys  
- Using a random Overleaf “NeurIPS-like” template instead of the official kit when a venue **was** named  
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
| **`paper`** (parent) | Subagent repo scan → `paper/PAPER_REPO_SURVEY.md` (paths); routes to section skills |
| **`paper-structure` (this)** | Intake + `GUIDANCE.md` → official LaTeX kit → architecture → skeleton `.tex` (+ Overleaf sync if configured) |
| `paper-abstract` | Child of `paper`: menu → lock → Abstract (reads survey; does not own scan) |
| **`paper-section`** | Body sections: intro/method/experiments/… prose |
| future `paper-polish` | Read `GUIDANCE.md` / survey, submission-oriented revise |
