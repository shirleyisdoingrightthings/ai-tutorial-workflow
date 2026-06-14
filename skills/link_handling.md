# Link Handling Skill

> 激活条件：用户提供外部链接时加载此文件。

---

## YouTube 视频

使用 `YouTube Transcript Scraper and Summary` 工具包中的 `fetch_transcript.py` 脚本提取字幕，该脚本通过 `youtube-transcript.io` 第三方 API 工作，无需 OAuth，可绕过 TLS 限制。

**路径与解释器：** 字幕工具包目录、Python 解释器均不在此硬编码，统一从工作流根目录的 `config.sh` 读取（变量 `TRANSCRIPT_DIR` 和 `TRANSCRIPT_PYTHON`）——这是唯一事实来源，换机器只改那一处。

**API Key：** 已配置在 `$TRANSCRIPT_DIR/.env` 中（`YOUTUBE_TRANSCRIPT_API_KEY`）。

遇到 YouTube 链接时，必须在后台静默执行以下命令来提取字幕（无需向用户确认，命令需在工作流根目录下运行）：
```bash
source ./config.sh && "$TRANSCRIPT_PYTHON" "$TRANSCRIPT_DIR/fetch_transcript.py" "<YouTube URL>"
```
*(注意：直接读取命令的标准输出即可，**严禁**将提取出的字幕重定向或保存到 `logs/` 或工作区的任何其他位置，必须保持工作区清洁。)*

**操作步骤：**
1. 从用户提供的链接提取 Video ID（`youtu.be/` 或 `?v=` 后的 11 位字符）
2. 运行上述命令获取 JSON 输出
3. 读取 JSON 中的 `transcript` 字段，整理为连续文本
4. 基于字幕内容进行分析和讲解，标注"来源：视频字幕（youtube-transcript.io）"

> ⚠️ 如果脚本运行失败（网络错误/视频无字幕），记录到 `logs/fetch_errors.md`，告知用户改为手动复制字幕。

---

## Twitter / X 帖子

许多 AI 工程师会在 Twitter/X 上发布关于前沿技术的第一手观察和长推。

**已确认限制**：Twitter/X 对所有未登录请求返回登录墙，WebFetch 无法绕过，不尝试直接抓取。

**处理方式（唯一可靠路径）**：

收到 Twitter 链接时，**立即**告知用户：
> "Twitter/X 需要登录才能读取，请直接复制推文文字粘贴给我，我来分析内容。"

请用户提供：推文正文（包括引用内容和回复串，如有）。

---

## 一般网页

**操作步骤：**

1. 直接 WebFetch 读取
2. 如果返回 403 或其他错误：
   - 记录到 `logs/fetch_errors.md`
   - 告知用户具体错误原因，请用户复制粘贴关键段落

> **关于 Paywall**：用户不会主动提供有付费墙的链接，无需专门处理。如果遇到意外的付费墙，按上述失败流程处理。

---

## 失败记录格式

每次链接读取失败，追加以下内容到 `logs/fetch_errors.md`：

```
| 日期 | 链接 | 失败原因 | 建议处理方式 |
| YYYY-MM-DD | {链接} | {登录墙/403/无字幕/...} | {用户粘贴/手动获取/...} |
```
