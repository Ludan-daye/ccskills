---
name: paper-structure
description: >
  Child of the paper skill: scaffold CS research paper LaTeX (default IEEE IEEEtran).
  Ask journal vs conference and venue, local vs Overleaf (+ Git), log GUIDANCE.md,
  download official template, confirm architecture, fill skeletons. Use when 论文结构,
  cs-paper-structure, 下载模板, LaTeX 模板, Overleaf, 先定架构, IEEE template.
  Repo survey is owned by parent paper skill (PAPER_REPO_SURVEY.md)—do not full-scan here.
---

# CS Paper Structure (Official LaTeX Scaffold)

For **computer science conference / journal papers**. This skill does **not** write full scientific prose or invent results. It:

1. Clarifies **venue type + exact venue** with the user (**default template = IEEE** if unspecified)  
2. Clarifies **compile target**: local LaTeX vs Overleaf (and Git key / remote if Overleaf)  
3. **Writes every Q&A into a guidance text file** (`paper/GUIDANCE.md`) as the lasting brief  
4. Fetches the **official LaTeX style/template** (IEEE by default; venue-specific when named)  
5. Confirms **section architecture** with the user (aligned to that template)  
6. Fills a **LaTeX project** with section skeletons + theme comments  
7. Optionally writes `paper/STRUCTURE.md` as a bilingual checklist that mirrors the `.tex`  

Later skills (`paper-draft` / `paper-polish` / `paper-abstract`) must **read `paper/GUIDANCE.md` first** and edit the same LaTeX sources. If no template is chosen yet, **write in IEEE / IEEEtran format**.

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

### `paper/GUIDANCE.md` template (write and keep updated)

```markdown
# Paper setup guidance (intake log)

> 本文件记录用户确认过的投稿与编译约定，供后续写作/改稿 skill 遵守。  
> **禁止**在此文件写入任何 token、密码、私钥。

## 1. Venue

| 项 | 用户回答 | 记录时间 |
|----|----------|----------|
| 类型（会议/期刊） |  |  |
| 具体 venue | （可写 IEEE-default / 未指定） |  |
| 模板策略 | IEEE-default / venue-official |  |
| IEEEtran 模式 | conference / journal / technote |  |
| 年份 / volume |  |  |
| Track |  |  |
| 阶段（initial / camera-ready / revision） |  |  |

## 1b. 投稿链接（Submission links）

> 后续 skill 与人工投稿以本表为准。更新链接时保留旧链接并标注 deprecated。

| 类型 | URL | 状态 | 来源 | 备注 |
|------|-----|------|------|------|
| 投稿系统 Submit |  | 已确认 / 待确认 / TBD | 用户提供 / agent 查证日期 | 系统名：OpenReview/HotCRP/… |
| 会议或期刊主页 |  |  |  |  |
| CFP / Author guidelines |  |  |  | 页数、匿名、补充材料政策摘要 |
| 官方 LaTeX / author kit |  |  |  | 与 vendor/ 对应 |
| 重要日期 |  |  |  | abstract/full/rebuttal/CR 截止日期 |
| 其他（rebuttal、camera-ready 门户等） |  |  |  |  |

**截稿与门户摘录（人工可读，随查证更新）：**

- Full paper deadline:  
- Abstract deadline:  
- Timezone:  
- Submission portal notes:  

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
| 官方模板 URL | （须与 §1b author kit 行一致或互链） |
| 投稿系统 URL | （须与 §1b Submit 行一致） |
| 本地 vendor 路径 |  |
| 确认的章节架构 |  |
| main 文件 |  |
| 最近编译结果 |  |
```

After each Q&A, append a **§4 transcript** entry and refresh **§1–1b–2 tables** + **§5 playbook**.

After Q2 / Q2b, if submission links are missing, **search the web** for the official CFP and submit portal for that venue+year, fill §1b, and ask the user to confirm the primary submit URL before treating it as final.

---

## Step 1 — Locate and download the official format

### 1.0 Default path: IEEE (when venue unspecified or user asks for default)

**Always try official IEEE sources first** for the default case:

| Step | Action |
|------|--------|
| 1 | Open IEEE conference templates: https://www.ieee.org/conferences/publishing/templates |
| 2 | And/or IEEE Template Selector: https://template-selector.ieee.org/ |
| 3 | IEEE Author Center — article templates (journals/transactions) |
| 4 | Download the **LaTeX** zip for **conference** or **journal** per Q1 |
| 5 | Prefer files based on **`IEEEtran.cls`** (e.g. bare conference / bare journal examples) |
| 6 | Fallback if IEEE site blocks automation: CTAN `ieeetran` package https://ctan.org/pkg/ieeetran — still document as “IEEE IEEEtran via CTAN” in TEMPLATE_SOURCE.md |

**Class options (default policy):**

| Q1 answer | Suggested start |
|-----------|-----------------|
| conference | `\documentclass[conference]{IEEEtran}` (or kit’s bare_conf) |
| journal | `\documentclass[journal]{IEEEtran}` (or kit’s bare_jrnl) |
| unknown | Ask once; if user still skips → **conference** mode as temporary default and label it clearly in GUIDANCE |

Tell the user explicitly:

> 未指定具体会议/期刊时，已按 **IEEE 官方 IEEEtran** 下载并搭建；若之后改投 ACL/NeurIPS/ACM 等，可再换官方包并迁移正文。

Log template URLs + download date in `GUIDANCE.md` §1b / §6.

### 1.1 Find the official source (when venue **is** specified)

Use web search / open pages. Priority order:

| Priority | Source |
|----------|--------|
| 1 | Venue **author kit / call for papers / submission instructions** page for the correct year |
| 2 | Publisher portal (IEEE Author Center, ACM Master Article Template, Springer LNCS, Elsevier, OpenReview/ML conference site, CVF, ACL pub kit, USENIX, etc.) |
| 3 | User-supplied URL or local zip/cls |
| 4 | If venue is IEEE-* but kit unclear → same IEEE default path as §1.0 |

**Examples of what “official” looks like (illustrative, always re-verify for the year):**

- **Default / unspecified:** IEEE IEEEtran (conference or journal)  
- ML conferences: often `*.zip` style kit on the conference site or linked from CFP  
- CVF (CVPR/ICCV/ECCV): CVF author guidelines + LaTeX  
- ACL anthology pubs: official ACL pub checklist / LaTeX  
- IEEE journals/conferences: IEEE template selector + IEEEtran  
- ACM: ACM consolidated template (`acmart`)  
- Springer LNCS: LNCS author package  

### 1.2 Download into the project

Preferred layout:

```text
paper/
├── GUIDANCE.md                # required — Q&A log + compile/sync playbook
├── vendor/                    # official kit, unmodified when possible
│   └── ieee-ieeetran/         # default; or <venue>-template/
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
   - **submission portal URL** (same as `GUIDANCE.md` §1b when known)  
   - download date  
   - package filename + hash if easy  
   - compile command (e.g. `latexmk -pdf main.tex`)  
7. Copy template URL + **submit URL** + vendor path + compile command into `GUIDANCE.md` §1b and §6.

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
2. **Submission links:** primary submit URL + CFP/homepage (from `GUIDANCE.md` §1b; note 已确认/待确认)  
3. **Compile mode:** local / Overleaf / both — and Git key status (yes/no only)  
4. **Guidance file:** path to `paper/GUIDANCE.md` (remind: all Q&A + links are there)  
5. **Template source:** official URL + local `paper/vendor/...` path  
6. **Confirmed architecture:** final section list  
7. **Main files:** `main.tex`, section files, `refs.bib`, `TEMPLATE_SOURCE.md`  
8. **Compile / sync status:** local PDF OK/fail; Overleaf push OK/fail/skipped  
9. **Next step:** lock contributions → draft Method in LaTeX (`paper-draft`), or fix Overleaf Git auth  

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
| future section skills under `paper/` | Intro/Method/… |
| future `paper-polish` | Read `GUIDANCE.md` / survey, submission-oriented revise |
