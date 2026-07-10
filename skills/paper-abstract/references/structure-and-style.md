# CS Top-Venue Abstract: Structure & Language Analysis

Sources synthesized for this skill:

- MIT EECS Communication Lab — *Abstract* (6-part formula)
- Philip Koopman (CMU) — *How to Write an Abstract* (architecture checklist)
- Annotated corpus of widely known ML/systems papers (see `examples.md`; texts from arXiv public abstracts)

---

## 1. What the abstract is for

| Reader job | Abstract must do |
|------------|------------------|
| Decide whether to open the PDF | Signal **problem importance** + **concrete contribution** in first 2–3 sentences |
| Assign to reviewers / search | Contain **task names, method names, benchmarks** as searchable phrases |
| Skim at a conference | Deliver a **closed loop**: gap → idea → evidence → takeaway |

If the abstract fails, the paper is often never read. Write it **last**, after results exist—or rewrite when numbers/claims change.

---

## 2. Dominant structure (top ML / CV / NLP venues)

Most strong abstracts are a compressed story with **5–6 moves**. Length is typically **~130–220 words** (venue caps vary; always check `GUIDANCE.md` / author kit).

| # | Move | Role | Typical length |
|---|------|------|----------------|
| 1 | **Context / status quo** | What everyone does or what is known | 1–2 sentences |
| 2 | **Gap / pain** | Why status quo fails or is expensive | 1–2 sentences |
| 3 | **Pivot (“here we …”)** | Name the contribution | 1 sentence |
| 4 | **Approach (high level)** | What you did, not full method | 1–3 sentences |
| 5 | **Evidence** | Prefer **numbers**, tasks, SOTA comparisons | 2–4 sentences |
| 6 | **Implication / scope** | Generality, secondary task, limitation if critical | 0–2 sentences |

### Mapping to classic checklists

| Koopman (CMU) | MIT EECS CommLab | This skill |
|---------------|------------------|------------|
| Motivation | General + specific background | Moves 1–2 |
| Problem statement | Knowledge gap | Move 2 |
| Approach | Here we show + approach | Moves 3–4 |
| Results | Results | Move 5 |
| Conclusions | Implications | Move 6 |

### Common order variants

| Pattern | When |
|---------|------|
| **Problem-first** | Field already knows the problem is hot (start with gap) |
| **Context-first** | Need to educate broader venue readers |
| **Question-open** | Theory / inference papers (e.g. VAE opens with a how-question) |
| **Name-drop early** | Strong brandable artifact: “We introduce BERT / LoRA / Transformer” |

---

## 3. Language style (what top abstracts sound like)

### Voice and tense

- **Active, author-centered:** *We propose / introduce / present / show / find*
- **Present** for architecture and claims; **past** or present perfect for experiments is fine
- Avoid passive stacks: *“A method is proposed that is shown to be…”*

### Density without fog

- Prefer **short independent clauses** chained with clear logic words: *Unlike…, As a result…, Compared to…, Specifically…*
- One **named object** early (method/system name) that the rest of the abstract can refer to
- Jargon only if the venue audience already owns it; expand once if needed

### Contrast is a superpower

Top abstracts sell novelty by **explicit contrast**:

- *dispensing with recurrence and convolutions entirely* (Transformer)
- *Unlike recent language representation models…* (BERT)
- *Compared to GPT-3 175B fine-tuned with Adam, LoRA can reduce…* (LoRA)
- *Whereas standard policy gradient methods…* (PPO)

### Numbers beat adjectives

Prefer:

- *28.4 BLEU*, *+2 BLEU*, *3.57% error*, *10,000× fewer trainable parameters*, *14× fewer training steps*

Avoid empty intensifiers as the only evidence:

- *significantly better*, *greatly improves* (OK only **next to** a number)

### What is usually **not** in the abstract

- Long citation lists (often **zero** citations)
- Hyperparameter dumps, architecture minutiae
- Promissory results (“we will show” without numbers when numbers exist)
- Hype without mechanism (*revolutionary*, *unprecedented* without metric)
- Claims absent from the paper body

---

## 4. Micro-patterns by paper type

| Type | Emphasize in abstract |
|------|------------------------|
| **New architecture / algorithm** | Name + what it removes/adds + main benchmark number |
| **Training / efficiency trick** | Cost of status quo → reduction factor → quality on-par/better |
| **Large empirical / scaling** | Setup scale + broad task suite + honest failure modes (GPT-3 style) |
| **Theory / inference** | Open with precise question; state assumptions; “contributions are two-fold” |
| **Systems** | Metric triad: performance / cost / simplicity; workload names |

---

## 5. Self-check rubric (use after every draft)

| Check | Pass criterion |
|-------|----------------|
| Closed loop | Reader can restate problem, idea, and top result without the paper |
| Contribution named | Method/system has a clear name or crisp description |
| Gap explicit | Status quo limitation is stated, not only topic area |
| Evidence | ≥1 concrete result (number, rank, or clear qualitative finding if theory) |
| No orphans | Every strong claim appears in body (Intro/Experiments) |
| Length | Within venue limit; usually ≤250 words unless journal allows more |
| Searchability | Task + method + key benchmark phrases present |
| Tone | Confident but not oversold; limitations only if they change interpretation |

---

## 6. Recommended writing process

1. Lock **3 testable contributions** and **top 3 numbers** (from real experiments).  
2. Write moves 3→5 first (pivot + approach + results).  
3. Write moves 1–2 (context + gap) to justify the pivot.  
4. Add move 6 only if it adds scope or necessary caveat.  
5. Cut 15–20% of words; kill the weakest sentence.  
6. Read aloud once; check against 1–2 examples in `examples.md` of the same type.
