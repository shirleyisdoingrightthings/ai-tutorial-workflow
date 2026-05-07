# AI Tutorial · 操作手册 (PLAYBOOK)

> 适用环境：Claude Code / Cursor / Codex 等支持 CLAUDE.md 的 AI 编程环境
> 系统架构说明见 → [README.md](README.md)

---

## 一、启动

### 首次使用
1. 用你的 AI 编程工具打开 `AI Tutorial/` 目录
2. 填写 `PROFILE.md`——把里面的占位符替换为你自己的偏好
3. AI 自动读取 `CLAUDE.md` + `PROFILE.md`，工作流就绪
4. 直接提问或发送链接

### 切换 AI 环境时（复制粘贴以下指令给新模型）

```
请先读以下两个文件，然后我们继续之前的工作：
1. CLAUDE.md
2. logs/session_handoff.md
读完告诉我你的理解，我们从「待处理事项」接着做。
```

---

## 二、Session 中的指令表

| 场景 | 你说的话 | AI 触发的动作 |
|---|---|---|
| 发送链接 | 直接发 URL | 加载 `skills/link_handling.md`，抓取处理 |
| 保存笔记 | "记下来" 或 **AI 主动建议** | 加载 `skills/note_taking.md`，保存到 `notes/` |
| 知识测验 | "考考我" 或 **笔记保存后 AI 询问** | 加载 `skills/quiz.md`，出题检验理解 |
| 深入某概念 | 直接追问 | Socratic 探测启动，AI 引导发现更深层问题 |
| 核查信息来源 | "这个说法从哪来的？" | 加载 `research_methodology.md`，逐条追溯 |
| 触发 QA 复盘 | "QA 复盘" | 加载 `skills/qa_council.md`，审查规则缺口 |
| 系统健康体检 | 运行 `./check_health.sh` | 终端一键诊断底层依赖和文件清洁度 |
| **结束 Session** | **"收尾"** | **Gate Check → session_handoff.md 更新** |

---

## 三、"收尾" Gate Check（AI 自动执行，你确认）

```
□ 今天修改、新增或删除了任何文件？
  → 是：README 的「文件结构」和 CHANGELOG 的「迭代记录」是否已同步？

□ 有链接抓取失败？
  → 是：logs/fetch_errors.md 是否已记录？

□ 有 QA 触发条件满足，但尚未写入 qa_proposals.md？

□ 有"之后处理"但未记录的待办事项？
  → 是：写入 session_handoff.md 待办区

□ 本次 session 是否观察到新的用户偏好信号？
  → 是：建议更新 PROFILE.md 对应条目（覆盖式修改）
```

全部通过 → `logs/session_handoff.md` 更新完成。

---

## 四、PROFILE 更新

**AI 触发时机**：发现新的学习偏好规律时，在当次回复末尾建议。
**手动触发**：说 `"帮我检查一下 PROFILE.md 是否需要更新"`
**更新方式**：覆盖式修改，不追加历史——文件始终代表当前状态。
