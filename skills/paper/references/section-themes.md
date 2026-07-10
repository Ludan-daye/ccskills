# Section themes (quick index)

各节速查索引，供 `paper-section`（正文）、`paper-structure`（骨架注释）共用。
深潜细节见 `sections/<name>.md`（缺失时以本索引为准）。
**Abstract 不在此展开** —— 见 `../abstract/references/`。

| 节 | Theme | 典型长度 | Move 顺序 |
|----|-------|----------|-----------|
| Introduction | 叙事 + 可检验贡献 | 0.75–1.25 页 | 动机→gap→高层 idea→贡献列表→(路线图) |
| Related Work | 定位与区分 | 0.5–1 页 | 主题簇→相同/不同轴→最近基线 |
| Method | 技术贡献：是什么 + 为什么 | 1.5–3 页 | setup/形式化→总览→模块→设计理由 |
| Experiments | 为主张提供证据 | 1.5–3 页 | 协议/数据/基线→主结果→消融/分析 |
| Limitations | 失效模式与范围 | 0.2–0.5 页 | 诚实假设→数据/算力限→负面发现 |
| Conclusion | 闭环 | 0.2–0.4 页 | 问题/方法回顾→发现→贡献回声→克制展望 |

## Introduction
- **Must include:** motivation → gap → high-level idea → contributions（可枚举、可检验）→ optional roadmap
- **Must not:** 完整方法细节；related-work 式综述
- **Done when:** reviewer 能复述约 3 条贡献；gap 与 method 对得上

## Related Work
- **Must include:** 主题簇；显式 same/different 轴；最近基线
- **Must not:** 无批判的罗列；漏掉直接竞争者
- **Done when:** 读者知道我们和谁比、为何不同

## Method
- **Must include:** setup/formalism → overview → modules → design rationale
- **Must not:** 完整超参表（放 Experiments）
- **Done when:** 同行能重实现核心 idea

## Experiments
- **Must include:** protocol、data、baselines、main results、ablations/analysis
- **Must not:** 无表/图支撑的主张；隐藏协议
- **Done when:** 每条主张都映射到某图/表

## Limitations
- **Must include:** 诚实假设、数据/算力限、负面发现
- **Must not:** 假谦虚；纯 future-work 营销
- **Done when:** 明显的 reviewer 攻击已被预先框定且不自毁主张

## Conclusion
- **Must include:** 问题/方法回顾、发现、贡献回声、克制展望
- **Must not:** 新实验主张
- **Done when:** 与 Abstract/Intro 一致
