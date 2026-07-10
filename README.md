# ccskills

面向 Claude Code / Grok / Cursor 的 Agent Skills 合集：科研管理、论文结构、长任务巡检、编码行为约束、UI 设计、计划拷问与会话交接。

## 一览

| Skill | 分类 | 触发 | 说明 |
|-------|------|------|------|
| [`managing-research-projects`](skills/managing-research-projects/) | 科研 | 自动 | TODO 驱动的科研 / 论文项目管理 |
| [`paper`](skills/paper/) | 论文 | 自动 | **论文父 skill**：subagent 扫仓库 → `PAPER_REPO_SURVEY.md`（带路径），再路由到各节 |
| [`paper-structure`](skills/paper/structure/) | 论文 | 自动 | **paper 子 skill**：搭 LaTeX 骨架（venue/模板/GUIDANCE），不写正文 |
| [`paper-section`](skills/paper/section/) | 论文 | 自动 | **paper 子 skill**：菜单勾选 → 确认后写正文某节（intro/method/…），数字/术语溯源 |
| [`paper-abstract`](skills/paper/abstract/) | 论文 | 自动 | **paper 子 skill**：菜单勾选 → 确认后写 Abstract（不负责全库扫描） |
| [`scheduled-patrol`](skills/scheduled-patrol/) | 运维 | 自动 | 定时深巡检后台任务并结构化汇报 |
| [`karpathy-guidelines`](skills/karpathy-guidelines/) | 编码 | 自动 | 少假设、最小实现、只改该改的、先定义成功标准 |
| [`frontend-design`](skills/frontend-design/) | 前端 | 自动 | 有辨识度的 UI，避免模板化 AI 审美 |
| [`grilling`](skills/grilling/) | 规划 | 自动 / 手动 | 实现前逐项拷问计划，直到假设对齐 |
| [`grill-me`](skills/grill-me/) | 规划 | **仅手动** `/grill-me` | 入口，转去 `grilling` |
| [`handoff`](skills/handoff/) | 协作 | **仅手动** `/handoff` | 将会话压成交接文档给新 agent |

共 **11** 个 skill（`grill-me` + `grilling` 成对使用）。

---

## 分类说明

### 1. 科研与项目台账

#### managing-research-projects

用 `TODO.md` 作为执行入口，把每个科研任务绑到状态、相关文件、完成标准、验证结果和 `CHANGELOG.md`。

- 默认科研目录结构：background / ideas / experiments / code / data / results / paper / meetings
- 任务契约：ID、状态 `[ ]` `[~]` `[x]` `[!]`、优先级、相关文件、完成标准、验证结果、更新时间
- 完成前必须验证；重要变更写入 CHANGELOG

**示例：**

- 「用 TODO List 方式管理这个科研项目」
- 「跑完 baseline 后更新 TODO.md」
- 「初始化论文项目结构」

### 2. 论文写作

**约定：所有论文写作 skill 只放在 `skills/paper/` 下**，不再在 `skills/` 顶层新增 paper 相关 skill。四个 skill 共用一份 `PAPER_REPO_SURVEY.md`/`TERMS.md`，构成 `paper`（父）→ `paper-structure` / `paper-section` / `paper-abstract`（子）的一棵树。

#### paper（论文父 skill）

加载时派 subagent 扫描用户研究仓库，写出 `paper/PAPER_REPO_SURVEY.md`（方向/数据/结果/术语，**均带路径**），并据此在 `paper/TERMS.md`、`paper/STATE.md` 里做种子；再按用户意图路由到 `paper-structure` / `paper-section` / `paper-abstract`。

#### paper-structure

面向 **CS 顶会/顶刊** 的论文**结构 skill**（不写科学正文，只搭 LaTeX 骨架）：

1. **先问清**：会议还是期刊、具体 venue（**未指定则默认 IEEE / IEEEtran**）；**投稿系统/CFP 链接**；**本地 / Overleaf** 与 Git
2. **所有问答与投稿链接写入** `paper/GUIDANCE.md`
3. **官网下载**模板：默认 IEEE 官方页 / Template Selector / CTAN `ieeetran`；指定 venue 则用该 venue 官方包 → `paper/vendor/`
4. **确认架构**后用 LaTeX 填骨架；按 GUIDANCE 编译或同步 Overleaf

**示例：**

- 「准备投 ICML，先搭 LaTeX 结构」
- 「这是期刊 TPAMI，下载模板并填章节」
- 「先定论文架构」

#### paper-section

挂在 `paper` 下，起草**正文某一节**（intro / related work / method / experiments / limitations / conclusion）：先读 survey + `TERMS.md`，给出内容菜单（每条带来源路径）→ 你确认 `CONTENT_LOCK` → 才写入对应 `sections/*.tex`。数字必须溯源到 survey，术语照 `TERMS.md`；缺来源就标 `NUM-NEEDED` 或 `needs-user` 问你，不编造。

**示例：**

- 「根据仓库写 Method 正文」
- 「把 Experiments 那节写了」
- 「补一下 Limitations」

#### paper-abstract

挂在 `paper` 下；**不扫全库**，只读 survey → 内容菜单 → 你确认 → 再按顶会风格写 Abstract。同样遵守 `TERMS.md` 与占位约定，不编造术语/数字。

后续计划：`paper-polish`（投稿前打磨）。

### 3. 长任务巡检

#### scheduled-patrol

按你指定的间隔醒来，**深查**后台任务是否在按你的要求推进（不只看进程是否存活）。

- 四层检查：任务状态 → 进程 → 输出内容 → 与上次进度对比
- 状态文件：`.patrol_state.json`
- 健康度：OK / SLOW / STUCK / WRONG / FAILED / DONE

**示例：**

- 「每 10 分钟汇报一次」
- 「帮我盯着后台任务」
- 「每 5 分钟检查运行情况」

> Claude Code 原文使用 `CronCreate` / `TaskList` 等；在 Grok 中可映射为 `scheduler_create`、后台任务与 `monitor`。

### 4. 编码行为

#### karpathy-guidelines

四条硬约束，减少 LLM 常见翻车：

1. **Think Before Coding** — 显式假设，不静默选边  
2. **Simplicity First** — 最小实现，拒绝过度设计  
3. **Surgical Changes** — 只动必须动的代码  
4. **Goal-Driven Execution** — 先定义可验证成功标准  

**来源：** [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills)（MIT）

### 5. 前端设计

#### frontend-design

在写 UI 前先定审美方向（字体、色彩、动效、空间），避免 Inter + 紫渐变等默认 AI 味。

**来源：** [anthropics/skills](https://github.com/anthropics/skills)（Apache-2.0，见目录内 `LICENSE.txt`）

### 6. 规划与交接

#### grilling / grill-me

实现前逐项拷问计划：一次只问一个问题，并给出推荐答案；事实查代码库，决策问人。

- 自动：说「grill me」「拷问一下这个方案」等 → `grilling`
- 手动：`/grill-me`（入口）或 `/grilling`

**来源：** [mattpocock/skills](https://github.com/mattpocock/skills)

#### handoff

把当前会话压成交接文档（含 suggested skills），写到系统临时目录，方便新会话 / 其他 agent 接手。

- **仅手动：** `/handoff`

**来源：** [mattpocock/skills](https://github.com/mattpocock/skills)

---

## 安装

### Claude Code

```bash
# 克隆后按需拷贝单个 skill
git clone https://github.com/Ludan-daye/ccskills.git
cp -R ccskills/skills/karpathy-guidelines ~/.claude/skills/
# 或一次性全部
cp -R ccskills/skills/* ~/.claude/skills/
```

### Grok

```bash
git clone https://github.com/Ludan-daye/ccskills.git
cp -R ccskills/skills/* ~/.grok/skills/
```

也可用脚本：

```bash
./install.sh          # 安装全部到 Claude + Grok（若目录存在）
./install.sh --claude # 仅 Claude
./install.sh --grok   # 仅 Grok
./install.sh karpathy-guidelines frontend-design  # 指定 skill
```

### Cursor

```bash
cp -R ccskills/skills/* ~/.cursor/skills/
```

安装后新开会话，或运行 `grok inspect` / Claude 的 skills 列表确认已发现。

---

## 仓库结构

```text
ccskills/
├── README.md
├── SOURCES.md              # 第三方来源与许可
├── install.sh
└── skills/
    ├── managing-research-projects/   # 自研
    ├── paper/                        # 自研（论文父 skill + 子 skill 树）
    │   ├── SKILL.md
    │   ├── references/
    │   ├── section/
    │   ├── structure/
    │   └── abstract/
    ├── scheduled-patrol/             # 自研
    ├── karpathy-guidelines/          # 第三方
    ├── frontend-design/              # 第三方
    ├── grill-me/                     # 第三方
    ├── grilling/                     # 第三方
    └── handoff/                      # 第三方
```

每个 skill 至少包含 `SKILL.md`（YAML frontmatter + 说明正文）。

---

## 推荐组合

| 场景 | 建议 skill |
|------|------------|
| 论文 / 实验仓库 | `managing-research-projects` |
| 论文写作总入口 / 扫仓库 | `paper` |
| 顶会论文先定章节架构 | `paper-structure` |
| 写正文某一节（intro/method/…） | `paper-section`（依赖 `paper` 的 survey） |
| 写/改 Abstract | `paper-abstract`（依赖 `paper` 的 survey） |
| 多个后台任务跑很久 | `scheduled-patrol` |
| 日常写代码 | `karpathy-guidelines` |
| 做落地页 / 组件 UI | `frontend-design` |
| 大功能开工前 | `grilling`（或 `/grill-me`） |
| 会话要断或换 agent | `/handoff` |

与 [Superpowers](https://github.com/obra/superpowers) 可叠加：Superpowers 管 brainstorm → plan → TDD → review；本仓库管科研台账、巡检、行为约束与规划拷问。

---

## 许可

- **自研 skill**（`managing-research-projects`、`paper`、`paper-structure`、`paper-section`、`paper-abstract`、`scheduled-patrol`）：与本仓库相同，可自由使用与修改。
- **第三方 skill**：保留原作者许可与归属，详见 [SOURCES.md](SOURCES.md)。再分发时请遵守各自 LICENSE。
