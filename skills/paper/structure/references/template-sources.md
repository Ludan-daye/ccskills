# Official template sources & download (used by paper-structure)

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

## Submission links（投稿入口）

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
