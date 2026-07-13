*structure-teaching only; do not copy sentences from sources.*

# Introduction — Top-Venue Examples（附「数字用法」专项结论）

## Scope and method

Eight papers, all confirmed accepted at top venues via official proceedings/anthology/OpenReview pages (not just arXiv), spanning 2023–2024: NeurIPS ×2, SOSP, ICCV, ICLR, ACL, OSDI, CVPR. For each, the **Introduction (Section 1) only** was read in full, with the Abstract fetched separately and cross-checked so that headline numbers are not misattributed to the Introduction when they actually live only in the Abstract or a later section — this distinction turned out to matter a lot (see papers 4 and 7). All descriptions are paraphrased; no sentences are copied. Numbers are reported as bare figures (the data point), not as quoted sentences.

**Quick comparison**

| # | Paper | Venue/Year | Numbers in Intro body? | Where | How much |
|---|-------|-----------|------------------------|-------|----------|
| 1 | QLoRA | NeurIPS 2023 | Yes — rich | gap paragraph + dedicated results-preview paragraph, before the technical contributions | ~8 figures (memory, %, hours, GB) |
| 2 | DPO | NeurIPS 2023 | No | — | 0 |
| 3 | vLLM (PagedAttention) | SOSP 2023 | Yes — rich | opening motivational stat; own-profiling gap paragraphs; one headline stat bridging to contributions | 4 figures; contributions list itself clean |
| 4 | Segment Anything (SAM) | ICCV 2023 | No (Section 1 body) | headline numbers reserved for Abstract + §5 Dataset | 0 in Section 1 |
| 5 | FlashAttention-2 | ICLR 2024 | Yes — richest of the set | motivational context-length numbers; prior-work baseline; own gap-quantification; results paragraph after contributions | ~9 figures, "sandwich" pattern |
| 6 | Self-Instruct | ACL 2023 | Yes | one results-preview paragraph right before the contributions list | 4 figures |
| 7 | AlpaServe | OSDI 2023 | Partial — illustrative only, not headline | opening scale numbers + a stylized worked example (symbolic units); real headline stays Abstract-only | 0 headline result figures in body |
| 8 | Depth Anything | CVPR 2024 | Only scale numbers, no performance numbers | method-description paragraph (dataset sizes) | 2 figures, dataset scale not results |

---

## 1. QLoRA — NeurIPS 2023 (Oral)
[proceedings.neurips.cc](https://proceedings.neurips.cc/paper_files/paper/2023/hash/1feb87871436031bdc0f2beaa62a049b-Abstract-Conference.html)

**Numbers? YES — dense.** Two spots: an early gap-setup paragraph states the status-quo memory cost as a hard figure; and before the technical contributions are listed, a separate paragraph previews the paper's own headline results (memory-reduction, two "% of ChatGPT level" figures, two training-time figures, a small-beats-big comparison). A "results-preview paragraph" pattern: numbers as a block, after the idea is named but before the enumerated contributions.
**Move order:** motivation → quantified gap → core-claim announcement → results-preview paragraph → 3 named technical contributions (metric-free bullets) → scale-of-study → findings summary → reproducibility.
**Contributions:** three technical mechanisms, purely qualitative in the bullets; metrics live in the paragraph before the list.

## 2. Direct Preference Optimization (DPO) — NeurIPS 2023
[papers.nips.cc](https://papers.nips.cc/paper_files/paper/2023/hash/a85b405ed65c6477a4fe8302b5e06ce7-Abstract-Conference.html)

**Numbers? NO.** Zero percentages/win-rates/benchmarks in Section 1 — the clearest counter-example (award-caliber paper, number-free intro).
**Move order:** framing → procedural gap (RLHF is complex: multiple stages, reward model, in-loop sampling) → idea (direct objective, no RL) → reparameterization insight → qualitative contribution sentence (competitive-or-better, up to a stated scale).
**Gap style:** structural/procedural, not quantitative — complexity itself is the hook, no magnitude attached.

## 3. vLLM (PagedAttention) — SOSP 2023
[ACM DL](https://dl.acm.org/doi/10.1145/3600006.3613165)

**Numbers? YES, three distinct rhetorical roles.** (a) opening cited external cost-estimate as motivation (not own result); (b) middle paragraphs use the authors' own profiling (a referenced figure) to quantify memory breakdown and waste percentage — gap made numerically concrete; (c) final intro paragraph, just before "we make the following contributions", states the paper's own headline throughput figure as a single bridge sentence.
**Contributions:** four qualitative bullets; none restate the throughput number stated one sentence earlier.
**Standout:** the gap is quantified with the authors' *own measurement*, not a citation — makes inefficiency feel undeniable.

## 4. Segment Anything (SAM) — ICCV 2023
[CVF](https://openaccess.thecvf.com/content/ICCV2023/html/Kirillov_Segment_Anything_ICCV_2023_paper.html)

**Numbers? NO in Section 1 body** (the famous billion-mask / 11M-image / 400× figures live in the Abstract and the Dataset section, not the intro). Section 1 uses qualitative superlatives ("largest … by far") instead.
**Move order:** analogy to NLP foundation models → vision-specific gap → goal (segmentation foundation model) → task/model/data three-question framing → forward-reference roadmap (one short paragraph per later section).
**Contributions:** distributed as descriptive lead-ins to forward-referenced sections, describing *what*, not *how well*. Analogy-driven, not number-driven.

## 5. FlashAttention-2 — ICLR 2024
[OpenReview](https://openreview.net/forum?id=mZn2Xyh9Ec)

**Numbers? YES — densest, a deliberate "sandwich".** Before contributions: field-level context-length figures (landscape, not own result) → predecessor's own published speedup/memory figures as baseline → a paragraph quantifying the *remaining* inefficiency precisely (predecessor's hardware-utilization % on fwd/bwd vs an optimized matmul's %). After contributions: closing paragraph restates the new method's own results as a small set (a speedup ×, two utilization %s, a throughput figure).
**Move order:** field context → prior-work baseline (numbers) → precise numeric gap (exact utilization ceiling vs reference) → pivot → 3 contributions (metric-free) → results-validation paragraph → implicit roadmap.
**Standout:** the most rigorously quantified gap paragraph of the set.

## 6. Self-Instruct — ACL 2023
[ACL Anthology](https://aclanthology.org/2023.acl-long.754/)

**Numbers? YES**, in one results-preview paragraph between the idea paragraph and the contributions list: an absolute-improvement % over the untuned baseline on a named benchmark, a generated-dataset-size figure, a remaining % gap behind a stronger system, the small seed-set size.
**Move order:** motivation → gap (human instruction data limited in quantity/diversity/creativity) → idea (self-bootstrapped instruction signal) → results-preview paragraph → 3 contributions.
**Contributions:** three bullets; one references dataset scale, none restate the benchmark %s (those stay in the narrative).

## 7. AlpaServe — OSDI 2023
[USENIX](https://www.usenix.org/conference/osdi23/presentation/li-zhouhan)

**Numbers? Nuanced.** The real headline (higher-rate ×, burstier-traffic ×) is in the Abstract, **not repeated in the intro body**. The intro body instead has (a) an opening scale figure (a known model's memory footprint → minimum GPU count) motivating difficulty, and (b) a stylized worked arithmetic example (symbolic/normalized time unit, tied to Fig. 1) making a counterintuitive claim concrete — a toy illustration, not an empirical result.
**Move order:** scale motivation → gap (over-provision vs one-device-per-model, missing multiplexing) → counterintuitive insight via symbolic example → design-space-is-hard → system → roadmap → contributions.
**Contributions:** three capability-framed bullets, no numbers (not even the Abstract's multipliers).

## 8. Depth Anything — CVPR 2024
[CVF](https://openaccess.thecvf.com/content/CVPR2024/html/Yang_Depth_Anything_Unleashing_the_Power_of_Large-Scale_Unlabeled_Data_CVPR_2024_paper.html)

**Numbers? Partial — scale yes, performance no.** Two dataset-size figures (unlabeled + labeled pools) in the data-engine paragraph. No comparative performance numbers in the intro — comparisons to prior best models are named but qualitative ("stronger zero-shot than"); actual numbers deferred to experiments.
**Move order:** foundation-model analogy → gap (leading prior depth model capped by limited data, fails in some scenarios) → idea (abundant unlabeled monocular images) → method walkthrough (data engine scale, a training difficulty + fix, auxiliary semantic supervision) → 4 contributions (qualitative).

---

## Style — 写法总结 (summarized, flexible)

以下是从这 8 篇顶会 intro 归纳的写法倾向，**仅供参照、灵活运用、不逐词照搬、不死板**：

- **Move order 高度收敛**：field-level motivation → 紧邻的最佳方法里的 named gap → 核心 idea（常带一个 "we propose X" 的命名时刻）→ 枚举贡献列表（或框架型论文如 SAM 用"各节前向引用"代替）→ 偶尔 roadmap。系统/效率型（vLLM、AlpaServe、FlashAttention-2）额外爱插一段**量化 gap**段落，锚定到自测 profiling 图或前作公布的天花板；单一优雅算法（DPO）或大框架/新任务（SAM）则跳过，走定性。
- **贡献列表几乎总是无指标**：8 篇里没有一篇把数字塞进贡献 bullet 本身。有数字时，数字在列表**前后的连接散文**里（"预览"或"佐证"段），列表本身只讲*做了什么*，不讲*打了多少分*。这条一致到可当约定。
- **有数字时是一小撮、绝不整表**：用数字的论文把它控制在约 2–9 个（多为 2–5）独立统计量，全是散文内联的裸数字（百分比、倍数、显存、时间），**从不整张表**——完整结果表统一留给 Experiments。数字做三种活之一：(1) **field-context**（外部/公认，motivate *为什么问题重要*，非自己的成绩）；(2) **gap 量化**（多为自测，把现有最佳方法的*不足*坐实）；(3) **headline 结果预览**（自有成绩的紧凑预览 1–5 个，常作贡献列表前/后的桥句，从不散落、从不在 bullet 里重复）。
- **不放数字也是合法、刻意的选择，且与论文类型相关**：DPO（一个干净的算法重构）和 SAM（引入全新问题设定的 task+model+data 框架）都让 §1 全/近乎无数字，把大数字留给 Abstract 或后面专门章节，改用定性最高级（"competitive with or superior to"、"largest to date"）。**规律：当贡献本质是"某个已知轴上的可测提升（速度/显存/精度对基线）"时用数字；当贡献更适合描述为"新能力/新框架/简化"、其价值一时难约化成一个轴时，跳过数字。**
- **gap 框定分"量化"与"结构/定性"两派**，与数字问题同一条线：效率型（QLoRA、vLLM、FlashAttention-2）用具体测量数字量化 gap；算法简化/新框架型（DPO、SAM、Self-Instruct、Depth Anything）用 named 定性属性（复杂度、覆盖有限、多样性不足）描述 gap 而不附幅度，即便它们随后会量化*自己的结果*。

---

## NUMBERS VERDICT（供 introduction.md 规则参照）
**YES —— 顶会 intro 常放 headline 数字，但是刻意、非普适的约定**（本组 8 篇中 6 篇有；2 个例外 DPO/SAM 属"干净算法/新框架"型，系统性走定性）。有数字时的规范：一小撮（约 1–9、典型 2–5）独立 headline 数字，**绝不整表**（表留 Experiments），做三种活之一（field-context 动机 / 自测 gap 量化 / 自有 headline 预览），最常作**贡献列表前后的桥句**而非塞进 bullet；贡献列表本身**基本永远无指标**。每个数字都**可追**——自有结果或明确外部引用，**无一含糊/无出处**。

**Sources analyzed (venue-verified; structural paraphrase only, no copied sentences):** QLoRA (NeurIPS'23), DPO (NeurIPS'23), vLLM (SOSP'23), SAM (ICCV'23), FlashAttention-2 (ICLR'24), Self-Instruct (ACL'23), AlpaServe (OSDI'23), Depth Anything (CVPR'24).
