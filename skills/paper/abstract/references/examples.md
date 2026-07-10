# Annotated Abstract Examples (Top-Venue CS)

Texts below are **public arXiv abstracts** of widely known papers, used here for **structure/style teaching**. Always cite the original paper if you reuse phrasing patterns—**do not copy sentences into a new submission**.

Word counts are approximate (English words).

---

## Example A — New architecture (NeurIPS 2017)

**Paper:** Attention Is All You Need (Vaswani et al.)  
**arXiv:** 1706.03762 · **Venue:** NeurIPS 2017  
**~166 words**

### Abstract (source: arXiv)

> The dominant sequence transduction models are based on complex recurrent or convolutional neural networks in an encoder-decoder configuration. The best performing models also connect the encoder and decoder through an attention mechanism. We propose a new simple network architecture, the Transformer, based solely on attention mechanisms, dispensing with recurrence and convolutions entirely. Experiments on two machine translation tasks show these models to be superior in quality while being more parallelizable and requiring significantly less time to train. Our model achieves 28.4 BLEU on the WMT 2014 English-to-German translation task, improving over the existing best results, including ensembles by over 2 BLEU. On the WMT 2014 English-to-French translation task, our model establishes a new single-model state-of-the-art BLEU score of 41.8 after training for 3.5 days on eight GPUs, a small fraction of the training costs of the best models from the literature. We show that the Transformer generalizes well to other tasks by applying it successfully to English constituency parsing both with large and limited training data.

### Move map

| Move | Text cue |
|------|----------|
| Context | dominant models = RNN/CNN encoder–decoder + attention |
| Gap (implicit) | complexity; recurrence/convolutions as default |
| Pivot | *We propose… the Transformer… solely on attention* |
| Approach | dispense with recurrence/convolutions; MT experiments |
| Evidence | 28.4 BLEU, +2 over best incl. ensembles; 41.8 BLEU; 3.5 days / 8 GPUs |
| Scope | constituency parsing, large & limited data |

### Style notes

- Names the artifact early (**Transformer**).  
- Strong contrast: *dispensing with… entirely*.  
- Evidence is **metric-first**, then cost.  
- Ends with **generality**, not hype.

---

## Example B — Training breakthrough (CVPR 2016)

**Paper:** Deep Residual Learning for Image Recognition (He et al.)  
**arXiv:** 1512.03385 · **Venue:** CVPR 2016  
**~198 words**

### Abstract (source: arXiv)

> Deeper neural networks are more difficult to train. We present a residual learning framework to ease the training of networks that are substantially deeper than those used previously. We explicitly reformulate the layers as learning residual functions with reference to the layer inputs, instead of learning unreferenced functions. We provide comprehensive empirical evidence showing that these residual networks are easier to optimize, and can gain accuracy from considerably increased depth. On the ImageNet dataset we evaluate residual nets with a depth of up to 152 layers---8x deeper than VGG nets but still having lower complexity. An ensemble of these residual nets achieves 3.57% error on the ImageNet test set. This result won the 1st place on the ILSVRC 2015 classification task. We also present analysis on CIFAR-10 with 100 and 1000 layers. The depth of representations is of central importance for many visual recognition tasks. Solely due to our extremely deep representations, we obtain a 28% relative improvement on the COCO object detection dataset. Deep residual nets are foundations of our submissions to ILSVRC & COCO 2015 competitions, where we also won the 1st places on the tasks of ImageNet detection, ImageNet localization, COCO detection, and COCO segmentation.

### Move map

| Move | Text cue |
|------|----------|
| Gap-first | *Deeper nets are more difficult to train* (one-line hook) |
| Pivot | residual learning framework |
| Approach | residual functions w.r.t. layer inputs |
| Evidence | 152 layers; 3.57% ImageNet; 1st place ILSVRC; +28% COCO relative |
| Implication | depth of representations; multi-task wins |

### Style notes

- Opens with a **sharp problem sentence** (no long background).  
- Mechanism in **one clear reformulation sentence**.  
- Stacks **competition outcomes** as social proof + metrics.  
- “Residual nets / ResNet” identity established via repeated *residual networks*.

---

## Example C — Pretraining paradigm (NAACL 2019)

**Paper:** BERT (Devlin et al.)  
**arXiv:** 1810.04805 · **Venue:** NAACL 2019  
**~142 words**

### Abstract (source: arXiv)

> We introduce a new language representation model called BERT, which stands for Bidirectional Encoder Representations from Transformers. Unlike recent language representation models, BERT is designed to pre-train deep bidirectional representations from unlabeled text by jointly conditioning on both left and right context in all layers. As a result, the pre-trained BERT model can be fine-tuned with just one additional output layer to create state-of-the-art models for a wide range of tasks, such as question answering and language inference, without substantial task-specific architecture modifications. BERT is conceptually simple and empirically powerful. It obtains new state-of-the-art results on eleven natural language processing tasks, including pushing the GLUE score to 80.5% (7.7% point absolute improvement), MultiNLI accuracy to 86.7% (4.6% absolute improvement), SQuAD v1.1 question answering Test F1 to 93.2 (1.5 point absolute improvement) and SQuAD v2.0 Test F1 to 83.1 (5.1 point absolute improvement).

### Move map

| Move | Text cue |
|------|----------|
| Pivot-first | *We introduce… BERT* + acronym expansion |
| Contrast | *Unlike recent…* bidirectional both sides all layers |
| Approach | fine-tune with one output layer; many tasks |
| Evidence | 11 tasks; GLUE/MNLI/SQuAD with **absolute deltas** |

### Style notes

- **Brand + expansion** in sentence 1.  
- One sentence of contrast does the novelty work.  
- Results listed as **score (Δ)** pairs—highly scannable.  
- Meta-line *conceptually simple and empirically powerful* is rare; works only because numbers follow immediately.

---

## Example D — Efficiency / adaptation (ICLR 2022)

**Paper:** LoRA (Hu et al.)  
**arXiv:** 2106.09685 · **Venue:** ICLR 2022  
**~197 words**

### Abstract (source: arXiv)

> An important paradigm of natural language processing consists of large-scale pre-training on general domain data and adaptation to particular tasks or domains. As we pre-train larger models, full fine-tuning, which retrains all model parameters, becomes less feasible. Using GPT-3 175B as an example -- deploying independent instances of fine-tuned models, each with 175B parameters, is prohibitively expensive. We propose Low-Rank Adaptation, or LoRA, which freezes the pre-trained model weights and injects trainable rank decomposition matrices into each layer of the Transformer architecture, greatly reducing the number of trainable parameters for downstream tasks. Compared to GPT-3 175B fine-tuned with Adam, LoRA can reduce the number of trainable parameters by 10,000 times and the GPU memory requirement by 3 times. LoRA performs on-par or better than fine-tuning in model quality on RoBERTa, DeBERTa, GPT-2, and GPT-3, despite having fewer trainable parameters, a higher training throughput, and, unlike adapters, no additional inference latency. We also provide an empirical investigation into rank-deficiency in language model adaptation, which sheds light on the efficacy of LoRA. We release a package that facilitates the integration of LoRA with PyTorch models and provide our implementations and model checkpoints for RoBERTa, DeBERTa, and GPT-2 at https://github.com/microsoft/LoRA.

### Move map

| Move | Text cue |
|------|----------|
| Context | pretrain then adapt paradigm |
| Gap | full FT infeasible at 175B; deployment cost |
| Pivot | LoRA + freeze + low-rank matrices |
| Evidence | 10,000× params, 3× memory; quality on-par; no extra latency vs adapters |
| Extra | analysis + code release |

### Style notes

- Cost story is **concrete** (175B instances).  
- Multiplicative **resource claims** paired with quality claim.  
- Ends with **artifact release** (common in systems/ML tooling papers).

---

## Example E — Large empirical / few-shot (NeurIPS 2020)

**Paper:** Language Models are Few-Shot Learners (Brown et al., GPT-3)  
**arXiv:** 2005.14165 · **Venue:** NeurIPS 2020  
**~260 words** (longer; journal-like density)

### Abstract (source: arXiv)

> Recent work has demonstrated substantial gains on many NLP tasks and benchmarks by pre-training on a large corpus of text followed by fine-tuning on a specific task. While typically task-agnostic in architecture, this method still requires task-specific fine-tuning datasets of thousands or tens of thousands of examples. By contrast, humans can generally perform a new language task from only a few examples or from simple instructions - something which current NLP systems still largely struggle to do. Here we show that scaling up language models greatly improves task-agnostic, few-shot performance, sometimes even reaching competitiveness with prior state-of-the-art fine-tuning approaches. Specifically, we train GPT-3, an autoregressive language model with 175 billion parameters, 10x more than any previous non-sparse language model, and test its performance in the few-shot setting. For all tasks, GPT-3 is applied without any gradient updates or fine-tuning, with tasks and few-shot demonstrations specified purely via text interaction with the model. GPT-3 achieves strong performance on many NLP datasets, including translation, question-answering, and cloze tasks, as well as several tasks that require on-the-fly reasoning or domain adaptation, such as unscrambling words, using a novel word in a sentence, or performing 3-digit arithmetic. At the same time, we also identify some datasets where GPT-3's few-shot learning still struggles, as well as some datasets where GPT-3 faces methodological issues related to training on large web corpora. Finally, we find that GPT-3 can generate samples of news articles which human evaluators have difficulty distinguishing from articles written by humans. We discuss broader societal impacts of this finding and of GPT-3 in general.

### Move map

| Move | Text cue |
|------|----------|
| Context + gap | FT needs thousands of labels; humans few-shot |
| Pivot | *Here we show* scaling → few-shot |
| Setup | GPT-3 175B; no gradients; text demos only |
| Evidence | broad task list + qualitative abilities |
| Honesty | datasets where it struggles; contamination issues |
| Broader impact | news generation + societal impacts |

### Style notes

- Uses *Here we show* as classic pivot.  
- **Honest negative space** in the abstract (rare but powerful for credibility).  
- Longer because claim is **paradigm-level**, not one benchmark.

---

## Example F — Theory / inference (ICLR 2014)

**Paper:** Auto-Encoding Variational Bayes (Kingma & Welling)  
**arXiv:** 1312.6114 · **Venue:** ICLR 2014  
**~130 words**

### Abstract (source: arXiv)

> How can we perform efficient inference and learning in directed probabilistic models, in the presence of continuous latent variables with intractable posterior distributions, and large datasets? We introduce a stochastic variational inference and learning algorithm that scales to large datasets and, under some mild differentiability conditions, even works in the intractable case. Our contributions are two-fold. First, we show that a reparameterization of the variational lower bound yields a lower bound estimator that can be straightforwardly optimized using standard stochastic gradient methods. Second, we show that for i.i.d. datasets with continuous latent variables per datapoint, posterior inference can be made especially efficient by fitting an approximate inference model (also called a recognition model) to the intractable posterior using the proposed lower bound estimator. Theoretical advantages are reflected in experimental results.

### Move map

| Move | Text cue |
|------|----------|
| Question-open | *How can we perform efficient inference…* |
| Pivot | stochastic VI algorithm |
| Contributions list | *two-fold. First… Second…* |
| Evidence | theory → experiments (high level) |

### Style notes

- **Question lead** suits theoretical framing.  
- Explicit *contributions are two-fold* enumerates claims.  
- Almost no numbers; evidence is **capability + mild conditions**.

---

## Example G — RL algorithm (widely cited)

**Paper:** Proximal Policy Optimization Algorithms (Schulman et al.)  
**arXiv:** 1707.06347  
**~134 words**

### Abstract (source: arXiv)

> We propose a new family of policy gradient methods for reinforcement learning, which alternate between sampling data through interaction with the environment, and optimizing a "surrogate" objective function using stochastic gradient ascent. Whereas standard policy gradient methods perform one gradient update per data sample, we propose a novel objective function that enables multiple epochs of minibatch updates. The new methods, which we call proximal policy optimization (PPO), have some of the benefits of trust region policy optimization (TRPO), but they are much simpler to implement, more general, and have better sample complexity (empirically). Our experiments test PPO on a collection of benchmark tasks, including simulated robotic locomotion and Atari game playing, and we show that PPO outperforms other online policy gradient methods, and overall strikes a favorable balance between sample complexity, simplicity, and wall-time.

### Move map

| Move | Text cue |
|------|----------|
| Pivot | new family of PG methods + surrogate objective |
| Contrast | vs one-update-per-sample; vs TRPO |
| Evidence | locomotion + Atari; outperforms online PG methods |
| Takeaway | balance sample complexity / simplicity / wall-time |

### Style notes

- **Tradeoff triangle** as the conclusion (systems-friendly).  
- Names **PPO** after describing the idea.  
- Benchmarks named without drowning in scores (still concrete).

---

## Example H — Normalization (ICML 2015)

**Paper:** Batch Normalization (Ioffe & Szegedy)  
**arXiv:** 1502.03167 · **Venue:** ICML 2015  
**~180 words**

### Abstract (source: arXiv)

> Training Deep Neural Networks is complicated by the fact that the distribution of each layer's inputs changes during training, as the parameters of the previous layers change. This slows down the training by requiring lower learning rates and careful parameter initialization, and makes it notoriously hard to train models with saturating nonlinearities. We refer to this phenomenon as internal covariate shift, and address the problem by normalizing layer inputs. Our method draws its strength from making normalization a part of the model architecture and performing the normalization for each training mini-batch. Batch Normalization allows us to use much higher learning rates and be less careful about initialization. It also acts as a regularizer, in some cases eliminating the need for Dropout. Applied to a state-of-the-art image classification model, Batch Normalization achieves the same accuracy with 14 times fewer training steps, and beats the original model by a significant margin. Using an ensemble of batch-normalized networks, we improve upon the best published result on ImageNet classification: reaching 4.9% top-5 validation error (and 4.8% test error), exceeding the accuracy of human raters.

### Move map

| Move | Text cue |
|------|----------|
| Problem mechanism | changing layer-input distributions |
| Named gap | *internal covariate shift* |
| Pivot | normalize layer inputs per mini-batch |
| Benefits | higher LR, less init care, regularizer |
| Evidence | 14× fewer steps; 4.9% ImageNet top-5 |

### Style notes

- Gives the phenomenon a **name**, then solves it.  
- Benefit list before the big number—builds logic.  
- Ends on **SOTA + human comparison** (memorable closer).

---

## Quick comparison table

| Example | Open style | Pivot phrase | Evidence style |
|---------|------------|--------------|----------------|
| Transformer | Status quo models | We propose | BLEU + train cost |
| ResNet | One-line difficulty | We present | Error % + competition ranks |
| BERT | We introduce name | Unlike… | Score (Δ) list |
| LoRA | Paradigm + cost | We propose | × params / memory |
| GPT-3 | FT vs humans | Here we show | Broad tasks + honesty |
| VAE | How-question | We introduce | Two-fold contributions |
| PPO | We propose | Whereas… | Benchmarks + tradeoff |
| BatchNorm | Training pathology | We refer… address | 14× steps + ImageNet |

---

## How to use these examples in the skill

1. Pick **1–2 examples** of the same type as the user’s paper.  
2. Mirror **move order** and **contrast density**, not wording.  
3. Replace their numbers with the user’s **real** metrics only.  
4. If the user’s abstract is longer than the closest example by >40 words without extra claims, cut.
