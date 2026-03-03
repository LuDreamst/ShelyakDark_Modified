#!/bin/bash
# Closebox73
# LuDreamst
# 整合：获取歌手名 + 自动更新音乐封面

# 配置参数
FIXED_COVER="/tmp/conky_music_cover.png"
TEMP_COVER="/tmp/conky_music_cover_temp_$.png"
DEFAULT_COVER="$HOME/.config/conky/Shelyak-Dark/res/default-cover.png"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

# 获取第一个可用的播放器
PLAYER=$(playerctl -l 2>/dev/null | head -n 1)

# 检查是否有可用的播放器
if [[ -z "$PLAYER" ]]; then
    echo "No Music Played"
    cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null
    exit 0
fi

# 获取播放器状态（指定播放器）
PCTL=$(playerctl -p "$PLAYER" status 2>/dev/null)

if [[ -z "${PCTL}" ]] || [[ "${PCTL}" == "Stopped" ]]; then
    # 无播放时：输出提示 + 使用默认封面
    echo "No Music Played"
    cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null
else
    # 有播放时：输出歌手名 + 更新封面
    artist=$(playerctl -p "$PLAYER" metadata xesam:artist 2>/dev/null)
    if [[ -n "$artist" ]]; then
        echo "$artist"
    else
        echo "Unknown Artist"
    fi
    
    # 以下是封面处理逻辑
    cover_url=$(playerctl -p "$PLAYER" metadata mpris:artUrl 2>/dev/null)
    
    if [[ -z "$cover_url" ]]; then
        # 无封面URL时用默认封面
        cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null
    elif [[ "$cover_url" == http* ]]; then
        # 网络封面：用curl下载（失败则用默认）
        curl -s --connect-timeout 3 -o "$FIXED_COVER" "$cover_url" || cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null
    elif [[ "$cover_url" == file://* ]]; then
        # 本地封面：去除file://前缀后复制
        local_path="${cover_url#file://}"
        # URL解码（处理空格等特殊字符）
        local_path=$(printf '%b' "${local_path//%/\\x}")
        if [[ -f "$local_path" ]]; then
            cp -f "$local_path" "$FIXED_COVER" 2>/dev/null
        else
            cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null
        fi
    else
        # 其他情况视为本地路径
        if [[ -f "$cover_url" ]]; then
            cp -f "$cover_url" "$FIXED_COVER" 2>/dev/null
        else
            cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null
        fi
    fi
fi

exit 0
