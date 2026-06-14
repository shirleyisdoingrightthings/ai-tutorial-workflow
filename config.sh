# AI Tutorial Workflow · 路径配置（单一事实来源 / Single Source of Truth）
#
# 字幕工具包（YouTube Transcript Scraper and Summary）所在目录的绝对路径。
# 换机器、换用户名、或移动文件夹时，只需改这一行；
# check_health.sh 与 skills/link_handling.md 都从这里读取，不再各自硬编码。

TRANSCRIPT_DIR="/Users/jialiwu/Desktop/youtube transcript scraper and summary"

# 抓取字幕用的 Python 解释器（依赖 requests + python-dotenv 已在此解释器下安装）
TRANSCRIPT_PYTHON="/usr/bin/python3"
