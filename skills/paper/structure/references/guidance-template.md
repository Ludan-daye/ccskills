# GUIDANCE.md template (used by paper-structure)

> paper-structure 在 intake 时创建 `<ROOT>/paper/GUIDANCE.md` 并逐问更新。禁止写 token/密码/私钥。

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
