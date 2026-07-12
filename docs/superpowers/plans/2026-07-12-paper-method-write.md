# Method Writing (SP5) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax.

**Goal:** Enhance `paper-section`'s Method path: innovation-point structure (small overview + one subsection per innovation, user-locked list), idea-dig from repo code (`METHOD_NOTES.md`, ideas-not-code, needs-confirm gate), formula discipline (prose per formula + multi-agent verification, zero experimental content), and a researched `method-examples.md`.

**Architecture:** Not a new skill (same as SP4). New reference `method-dig-prompt.md` + researched `method-examples.md`; rewrite `sections/method.md`; add a Method special-case to `paper-section/SKILL.md`; register `METHOD_NOTES.md` in `storage-framework.md`; extend the fixture with fake code; RED→GREEN.

**Tech Stack:** Markdown SKILL docs, LaTeX/math conventions, `WebSearch`/`WebFetch` (examples research), subagent probes, git. Spec: `docs/superpowers/specs/2026-07-12-paper-method-write-design.md`.

**Branch:** `paper-method-write` → merge `main` when done (hold push for user). Repo root: `/root/ludandaye/program/Skills/paperSkill/ccskills`. Commit locally, don't push.

---

## PHASE A — Research + guidance/skill edits

### Task 1: Research `method-examples.md` (top-venue Method sections)

**Files:** Create `skills/paper/references/sections/method-examples.md`

Research-driven (same process as `related-work-examples.md`). Dispatch a web-enabled research subagent.

- [ ] **Step 1: Research + author.** Find **6–8 recent top-venue** CS papers (NeurIPS/ICML/ICLR/CVPR/ACL/OSDI/SOSP/…) with a substantial Method/Approach section. For each, produce a **structural analysis (NO copied sentences)**: `paper + venue/year + link | overview 占比与写法 | 创新点/组件怎么分 subsection | 设计理由(why)怎么穿插 | 公式密度 + 每条公式配多少文字(数一数典型段落) | 记号怎么引入 | 总览图怎么用`. Then a final `## Style — 写法总结 (summarized, flexible)` section that **generalizes across the set** (overview-to-detail ratio norms, one-innovation-per-subsection patterns, prose-per-formula norms, notation-introduction habits, rationale placement) — explicitly 参照不逐词照搬、不死板, derived from the examples not a preset list. Header line: *structure-teaching only; do not copy sentences.*
- [ ] **Step 2: Verify.** Run: `grep -c "^## " skills/paper/references/sections/method-examples.md` → ≥ 3. And `grep -ci "公式\|formula" skills/paper/references/sections/method-examples.md` → ≥ 3 (prose-per-formula analysis present). Manually confirm no verbatim sentences.
- [ ] **Step 3: Commit.** `git add skills/paper/references/sections/method-examples.md && git commit -m "Add method-examples.md (top-venue Method structures + summarized style)"`

---

### Task 2: `references/method-dig-prompt.md`

**Files:** Create `skills/paper/references/method-dig-prompt.md`

- [ ] **Step 1: Write the file** — exact content:

````markdown
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
````

- [ ] **Step 2: Verify.** Run: `grep -c "needs-confirm\|NOT a code walkthrough\|METHOD_NOTES\|innovation" skills/paper/references/method-dig-prompt.md` → ≥ 4.
- [ ] **Step 3: Commit.** `git add skills/paper/references/method-dig-prompt.md && git commit -m "paper-section: add method-dig-prompt (ideas not code, needs-confirm)"`

---

### Task 3: Rewrite `sections/method.md` (deep dive v2)

**Files:** Modify `skills/paper/references/sections/method.md`

- [ ] **Step 1: Replace `## Move order`** with:

```markdown
## Move order
结构公式 = **总方法(小) + N × 创新点**：
1. Setup / notation（记号集中定义，先定义后使用）
2. Overview（**只占一小部分**：方法框架、模块如何串起、总览图占位 `\ref{fig:TODO-overview}` + 丰富 `% FIG-NEEDED:` 描述图应含的模块/数据流；常规/工程部分在此一句带过，**不单独成节**）
3. **每个 `\subsection` = 一个创新点**（来自 INNOVATION_LOCK 清单，顺序照清单）：动机(为什么需要) → 原理 → 公式(每条配足量文字) → 设计理由
写作流程见 `## Innovation-point flow`；风格参照 `method-examples.md` 归纳（灵活不死板）。
```

- [ ] **Step 2: Insert `## Innovation-point flow (INNOVATION_LOCK)`** after `## Move order`:

```markdown
## Innovation-point flow (INNOVATION_LOCK)
```text
Step 1 定结构   method-dig (../method-dig-prompt.md) → paper/METHOD_NOTES.md + survey → 候选创新点
Step 2 清单门禁  创新点清单 → 用户 ← 硬门禁 INNOVATION_LOCK
               每条: 名称 | 一句话原理 | 来源路径 | 建议(核心/次要) | needs-confirm?
               用户 改/删/加/合并/排序；needs-confirm 项逐条确认后才可入正文
Step 3 搭框架   overview 骨架 + 每创新点一个 \subsection 骨架（% Theme / % 原理要点 / % 公式清单）
               落盘后给用户过目（软确认，可喊停；不设第二道硬门禁）
Step 4 逐部分写 默认一次 run 写一个 subsection → 自检(公式验证+配文+零实验) → 报告 → 用户说继续
               （可要求一口气写完）；% Status 按 subsection 粒度: % Status(sub:<slug>): [x] drafted
```
INNOVATION_LOCK 即 method 版 CONTENT_LOCK；**最终以用户改定的清单为准**——skill 不替用户决定什么算创新。
```

- [ ] **Step 3: Insert `## Idea-dig & METHOD_NOTES (挖思路，不抄代码)`** after the flow section:

```markdown
## Idea-dig & METHOD_NOTES (挖思路，不抄代码)
- 写 Method 前派只读 dig 子代理（模板 `../method-dig-prompt.md`）→ `paper/METHOD_NOTES.md`。
- NOTES 记**原理语言**（机制做什么、为什么），`source_path` 只作溯源证据；`needs-confirm` 项未经用户确认不得入正文。
- 正文硬规矩：❌ 贴代码片段 ❌ 变量/函数名级叙述 ❌ 照代码结构逐文件复述；✅ 实现翻译成原理与公式语言。
```

- [ ] **Step 4: Insert `## Formula discipline (公式纪律)`** after the dig section:

```markdown
## Formula discipline (公式纪律)
- 记号先定义后使用（setup 集中定义，跨节一致；方法名照 `TERMS.md`）。
- **每条公式配足量文字**：算什么、每个符号是什么、为什么长这样——禁止裸公式堆砌（参照 method-examples 的 prose-per-formula 观察）。
- **多 agent 公式验证**（Phase 5 自检扩展）：公式逐条交验证子代理（符号定义齐? 量纲/形状自洽? 与 METHOD_NOTES 思路一致? 推导成立?）；问题 → `% FORMULA-CHECK: <issue>`，不静默保留。
- 公式只能来自 METHOD_NOTES 或用户确认的输入——不发明数学。
```

- [ ] **Step 5: Tighten existing sections.** In `## Must not`, add bullets: `- 任何实验内容/结果数字/提升幅度（比较留给 \Cref{sec:experiments} 前向引用，不带数值）`、`- 代码级叙述或代码片段（挖思路不抄代码）`、`- 裸公式（无文字解释）`. In `## Claim → evidence mapping`, replace body with: `Method 零实验内容——不出现任何结果数字。机制陈述追 METHOD_NOTES(id+path) 或用户确认项；复杂度/参数量等如需数字，追 survey claim_id 并 % src:，否则 % NUM-NEEDED。`. In `## Done-when checklist`, add: `- [ ] 结构=总方法(小)+每 subsection 一创新点；清单经 INNOVATION_LOCK`、`- [ ] 每条公式有配文且通过验证（无未处理 % FORMULA-CHECK）`、`- [ ] 零实验内容；零代码级叙述；needs-confirm 均已确认`.
- [ ] **Step 6: Verify + commit.** Run: `grep -c "INNOVATION_LOCK\|METHOD_NOTES\|FORMULA-CHECK\|零实验\|method-examples" skills/paper/references/sections/method.md` → ≥ 8.
```bash
git add skills/paper/references/sections/method.md && git commit -m "method.md v2: innovation-point structure, idea-dig, formula discipline, zero-experiment"
```

---

### Task 4: Method special-case in `paper-section/SKILL.md`

**Files:** Modify `skills/paper/section/SKILL.md`

- [ ] **Step 1: Insert after the `## Related-work special case` block** (before `## Hard rules`):

```markdown
## Method special case
When the picked section is **method** (see `../references/sections/method.md`):
- First dispatch a read-only **method-dig** subagent (`../references/method-dig-prompt.md`) → `paper/METHOD_NOTES.md` (ideas not code; inferred items = `needs-confirm`).
- Structure = small overview + **one `\subsection` per innovation point**. Present the innovation-point list (name | principle | source_path | core/minor | needs-confirm) → user edits → **INNOVATION_LOCK** (hard gate; needs-confirm items must be individually confirmed).
- Then scaffold the frame on disk (overview + per-innovation skeletons), show it (soft check), and write **one subsection per run** by default; `% Status(sub:<slug>)` per subsection.
- **Zero experimental content**; no code-level narration; every formula gets substantial prose and passes multi-agent formula verification (`% FORMULA-CHECK` for issues); formulas trace to METHOD_NOTES/user-confirmed input only.
```

- [ ] **Step 2: Verify + commit.** Run: `grep -c "Method special case\|INNOVATION_LOCK\|method-dig" skills/paper/section/SKILL.md` → ≥ 3; `wc -w skills/paper/section/SKILL.md` (report; < ~850 ok).
```bash
git add skills/paper/section/SKILL.md && git commit -m "paper-section: method special case (dig -> INNOVATION_LOCK -> scaffold -> per-subsection)"
```

---

### Task 5: `METHOD_NOTES.md` contract in `storage-framework.md`

**Files:** Modify `skills/paper/references/storage-framework.md`

- [ ] **Step 1: Add row** in the `## 1. 用户仓库侧` table, after the `REFS_SHORTLIST.md` row:

```markdown
| `METHOD_NOTES.md` | paper-section (method dig) | method 写作 | 写 Method 前由只读 dig 生成：机制思路(原理语言,非代码摘录)+source_path+状态(from-repo/needs-confirm)；needs-confirm 未确认不得入正文 |
```

- [ ] **Step 2: Verify + commit.** Run: `grep -c "METHOD_NOTES" skills/paper/references/storage-framework.md` → ≥ 1.
```bash
git add skills/paper/references/storage-framework.md && git commit -m "storage-framework: METHOD_NOTES contract (idea-dig, needs-confirm)"
```

---

## PHASE B — Fixture + test

### Task 6: Fixture fake code (diggable, with one inferable-only point)

**Files:** Create `test/fixtures/paper-section/code/slabquant.py`

- [ ] **Step 1: Write the file** — exact content (3 extractable mechanisms + 1 undocumented heuristic for needs-confirm):

```python
"""SlabQuant fixture implementation (fake, for skill testing only)."""
import numpy as np

SLAB_SIZE = 64          # tokens per slab
BITS = 4
QMAX = 2 ** BITS - 1
CLIP_Q = 0.999          # (no comment anywhere about why this exists)


class SlabQuantCache:
    """KV cache stored as sealed 4-bit slabs plus one fp16 open buffer."""

    def __init__(self, head_dim):
        self.open_k, self.open_v = [], []
        self.sealed = []            # list of (codes_k, scale_k, zero_k, codes_v, scale_v, zero_v)
        self.head_dim = head_dim

    def append(self, k_vec, v_vec):
        # Mechanism 1: slab partitioning — accumulate fp16 until SLAB_SIZE, then seal.
        self.open_k.append(k_vec)
        self.open_v.append(v_vec)
        if len(self.open_k) == SLAB_SIZE:
            self.sealed.append(self._seal(np.array(self.open_k), np.array(self.open_v)))
            self.open_k, self.open_v = [], []

    def _seal(self, K, V):
        # Mechanism 2: per-slab affine quantization from the slab's own statistics.
        return (*_quantize(K), *_quantize(V))

    def read_all(self):
        # Mechanism 3: dequantize sealed slabs on read; open buffer stays fp16.
        outs = [(_dequantize(ck, sk, zk), _dequantize(cv, sv, zv))
                for (ck, sk, zk, cv, sv, zv) in self.sealed]
        return outs, (np.array(self.open_k), np.array(self.open_v))


def _quantize(X):
    lo = np.quantile(X, 1 - CLIP_Q)
    hi = np.quantile(X, CLIP_Q)     # range from clipped quantiles, not raw min/max
    X = np.clip(X, lo, hi)
    scale = (hi - lo) / QMAX
    zero = np.round(-lo / scale)
    codes = np.clip(np.round(X / scale) + zero, 0, QMAX).astype(np.uint8)
    return codes, np.float16(scale), np.float16(zero)


def _dequantize(codes, scale, zero):
    return (codes.astype(np.float32) - np.float32(zero)) * np.float32(scale)
```

- [ ] **Step 2: Verify + commit.** Run: `python3 -c "import ast;ast.parse(open('test/fixtures/paper-section/code/slabquant.py').read());print('syntax OK')"` → `syntax OK`. And `grep -c "no comment anywhere" test/fixtures/paper-section/code/slabquant.py` → 1 (the inferable-only CLIP_Q point present).
```bash
git add test/fixtures/paper-section/code && git commit -m "fixture: add fake slabquant.py (3 mechanisms + 1 inferable-only heuristic)"
```

---

### Task 7: RED baseline (isolated, no enhancement)

- [ ] **Step 1: Run.** Copy fixture to `/tmp/mw-red` (fixture only, NO skill docs — includes `code/`). Dispatch a subagent: `Here is a paper repo at /tmp/mw-red (code in code/). Write the Method section into paper/sections/method.tex — a submission-quality section with formulas. Return the LaTeX. Work only from /tmp/mw-red; don't ask questions.`
- [ ] **Step 2: Record** to `docs/superpowers/plans/notes-method-write-RED.md`: look for — no innovation-point list/gate; asserts the CLIP_Q=0.999 intent as fact (no needs-confirm); code-walkthrough narration or code identifiers in prose; naked formulas (little/no prose per formula); no formula verification; experimental content leaking in. Commit.
```bash
git add docs/superpowers/plans/notes-method-write-RED.md && git commit -m "Record method-writing RED baseline"
```

### Task 8: GREEN validation (with enhancement) + REFACTOR

- [ ] **Step 1: Run WITH skill.** Copy `skills/paper` + fixture to `/tmp/mw-green`. Dispatch a subagent following `paper-section` Method special case + `method.md` + `method-examples.md` + `method-dig-prompt.md`: (a) dig → METHOD_NOTES (principle language, paths, CLIP_Q as `needs-confirm`); (b) innovation-point list → simulate user: confirm slab-partitioning + per-slab-affine-quant as core, **confirm** the CLIP_Q outlier-clipping inference as "yes that's intentional"; INNOVATION_LOCK; (c) scaffold frame; (d) write ONE subsection (per-slab affine quantization) — formulas each with substantial prose, then a formula-verification pass (dispatch or simulate verifier: symbols defined? dims consistent? matches NOTES?), zero experimental content, no code identifiers.
- [ ] **Step 2: Assert pass criteria** (vs RED): METHOD_NOTES in idea language with paths + needs-confirm; list gated before writing; scaffold before prose; one-subsection run; every formula has prose + verification result; `% FORMULA-CHECK` mechanism demonstrated; zero experiment numbers; zero code-level narration. Record to `docs/superpowers/plans/notes-method-write-GREEN.md`.
- [ ] **Step 3: REFACTOR if needed** — any leak (asserted inference, naked formula, code narration, skipped gate) → add explicit counter to `method.md`/`paper-section`, re-run. Commit.
```bash
git add docs/superpowers/plans/notes-method-write-GREEN.md skills/paper 2>/dev/null; git commit -m "Record method-writing GREEN (+ any refactor)"
```

---

## Self-review (author checklist — completed)
- **Spec coverage:** §2.1 structure+flow→T3/T4; §2.2 dig→T2/T3/T4/T5; §2.3 formula→T3/T4; §2.4 examples→T1; §2.5 figure→T3; components §3 all mapped (1→T3, 2→T1, 3→T2, 4→T4, 5→T5, 6→T6, 7→T7/8); tests §4→T7/T8. Covered.
- **Placeholders:** none — deterministic tasks carry full content; T1 is research-by-procedure (correct for discovered content); `% FORMULA-CHECK`/`% FIG-NEEDED`/`needs-confirm` are conventions.
- **Consistency:** `METHOD_NOTES.md`, `INNOVATION_LOCK`, `needs-confirm`, `% FORMULA-CHECK`, `% Status(sub:<slug>)`, `method-dig` naming identical across T2–T8.

## Done-when
1. method-examples.md researched (6–8, prose-per-formula analyzed) + flexible style summary.
2. method.md v2 + paper-section special case + METHOD_NOTES contract + dig prompt landed.
3. GREEN: dig(ideas+needs-confirm) → user-locked innovation list → scaffold → one subsection with prose-per-formula + verification, zero experiment, zero code narration. RED shows the opposite.
4. Merged to main (push on user's word).

## Out of scope (YAGNI)
- Real figures; real `\cite` in method; latex/bibtex compile; numeric simulation of formulas; similar digs for other sections.
