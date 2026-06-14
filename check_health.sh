#!/bin/bash

# AI Tutorial Workflow - Health Check Script
# 
# 这是一个按需运行的“体检工具”。
# 随着系统进化，当你遇到新的易错点时，可以通过添加新的 check_* 函数来扩展它；
# 当某些架构问题被彻底解决时，可以删除对应的检查项。
# 
# 运行方式： ./check_health.sh

# 加载路径配置（单一事实来源）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/config.sh" ]; then
    source "$SCRIPT_DIR/config.sh"
else
    echo "[FAIL] 找不到 config.sh，无法确定字幕工具包路径"
    exit 1
fi

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "🩺 ${GREEN}开始 AI Tutorial 系统体检...${NC}\n"

# 统计变量
ERRORS=0
WARNINGS=0

# --- 辅助函数 ---
pass() {
    echo -e "  [${GREEN}OK${NC}] $1"
}

fail() {
    echo -e "  [${RED}FAIL${NC}] $1"
    ERRORS=$((ERRORS+1))
}

warn() {
    echo -e "  [${YELLOW}WARN${NC}] $1"
    WARNINGS=$((WARNINGS+1))
}

# --- 检查项定义区域 ---

check_transcript_script() {
    SCRIPT_PATH="$TRANSCRIPT_DIR/fetch_transcript.py"
    if [ -f "$SCRIPT_PATH" ]; then
        pass "字幕抓取脚本存在 ($SCRIPT_PATH)"
        # 进一步验证脚本能真正运行（依赖 + 解释器），而不只是文件存在
        if "$TRANSCRIPT_PYTHON" -c "import requests, dotenv" 2>/dev/null; then
            pass "Python 依赖就绪 (requests + dotenv，解释器 $TRANSCRIPT_PYTHON)"
        else
            fail "Python 依赖缺失：请运行 $TRANSCRIPT_PYTHON -m pip install -r \"$TRANSCRIPT_DIR/requirements.txt\""
        fi
    else
        fail "找不到字幕抓取脚本 ($SCRIPT_PATH)"
    fi
}

check_api_keys() {
    # API Key 配置在字幕工具包目录的 .env 中，不在本工作流目录
    ENV_PATH="$TRANSCRIPT_DIR/.env"
    if [ -f "$ENV_PATH" ]; then
        if grep -qE "YOUTUBE_(TRANSCRIPT_)?API_KEY=.+" "$ENV_PATH"; then
            pass "环境变量文件存在，且 YouTube API Key 已填写"
        else
            warn "存在 .env 文件，但 YouTube API Key 为空或缺失"
        fi
    else
        warn "找不到 .env 文件 ($ENV_PATH)，YouTube 抓取可能受限"
    fi
}

check_log_pollution() {
    # 检查 logs 目录下是否有违规生成的 json 字幕残留
    if ls logs/transcript_*.json 1> /dev/null 2>&1; then
        fail "在 logs/ 目录下发现了残留的字幕 JSON 文件（违反了无痕内存分析原则）"
        # 提示用户具体文件
        ls -1 logs/transcript_*.json | while read file; do
            echo -e "         -> $file"
        done
    else
        pass "logs/ 目录清洁，无字幕文件残留"
    fi
}

# --- 扩展建议 ---
# 未来如果需要增加新的检查（如：检查 session_handoff.md 的格式是否合法，
# 或者检查某个必须存在的依赖是否安装），只需在上面写一个 check_* 函数，
# 然后在下面的运行队列里调用即可。

# --- 运行检查队列 ---

echo "1. 环境依赖检查"
check_transcript_script
check_api_keys
echo ""

echo "2. 工作区清洁度检查"
check_log_pollution
echo ""

# --- 总结报告 ---
if [ $ERRORS -eq 0 ]; then
    if [ $WARNINGS -eq 0 ]; then
        echo -e "✨ ${GREEN}体检完成：所有系统指标正常，脚手架运转良好！${NC}"
    else
        echo -e "⚠️ ${YELLOW}体检完成：发现 $WARNINGS 个警告，但不影响核心流程，请酌情关注。${NC}"
    fi
else
    echo -e "❌ ${RED}体检完成：发现 $ERRORS 个致命错误，请根据上方提示修复后再运行工作流。${NC}"
fi
