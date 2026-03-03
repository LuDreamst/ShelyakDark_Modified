#!/bin/bash
# LuDreamst
# 截断脚本：检测中文，自动调整显示字符数
# 用法: truncate.sh "文本" "最大字符数"

TEXT="$1"
MAX_CHARS="${2:-20}"

if [[ -z "$TEXT" ]]; then
    exit 0
fi

# 检测是否包含中文字符
if echo "$TEXT" | grep -qP '[\x{4E00}-\x{9FFF}]'; then
    # 包含中文，字符数减半
    DISPLAY_CHARS=$((MAX_CHARS / 2))
else
    # 纯英文，使用原始字符数
    DISPLAY_CHARS=$MAX_CHARS
fi

# 截断字符串
result="${TEXT:0:$DISPLAY_CHARS}"

# 如果被截断了，添加省略号
if [[ ${#TEXT} -gt $DISPLAY_CHARS ]]; then
    result="${result}..."
fi

echo "$result"
