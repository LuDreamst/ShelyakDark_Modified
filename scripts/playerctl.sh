#!/bin/bash
# playerctl.sh
# 音乐信息统一输出脚本：封面处理 + 两行文字输出（歌手名 / 歌曲名）
# 供 conky 通过单次 execi 调用，避免重复查询

# ── 配置 ──────────────────────────────────────────────
FIXED_COVER="/tmp/conky_music_cover.png"
DEFAULT_COVER="$HOME/.config/conky/ShelyakDark_Modified/res/default-cover.png"
TRUNCATE="$HOME/.config/conky/ShelyakDark_Modified/scripts/truncate.sh"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

# ── 工具函数 ──────────────────────────────────────────
update_cover() {
    local cover_url="$1"

    if [[ -z "$cover_url" ]]; then
        cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null

    elif [[ "$cover_url" == http* ]]; then
        curl -s --connect-timeout 3 -o "$FIXED_COVER" "$cover_url" \
            || cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null

    elif [[ "$cover_url" == file://* ]]; then
        local local_path="${cover_url#file://}"
        local_path=$(printf '%b' "${local_path//%/\\x}")  # URL 解码
        if [[ -f "$local_path" ]]; then
            cp -f "$local_path" "$FIXED_COVER" 2>/dev/null
        else
            cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null
        fi

    else
        if [[ -f "$cover_url" ]]; then
            cp -f "$cover_url" "$FIXED_COVER" 2>/dev/null
        else
            cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null
        fi
    fi
}

no_music() {
    echo "Oops..."         > /tmp/conky_music_artist.txt
    echo "No Music Played" > /tmp/conky_music_title.txt
    cp -f "$DEFAULT_COVER" "$FIXED_COVER" 2>/dev/null
    exit 0
}

# ── 主逻辑 ────────────────────────────────────────────

# 获取第一个可用的播放器
PLAYER=$(playerctl -l 2>/dev/null | head -n 1)
[[ -z "$PLAYER" ]] && no_music

# 检查播放状态
STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)
[[ -z "$STATUS" || "$STATUS" == "Stopped" ]] && no_music

# ── 有音乐播放 ────────────────────────────────────────

# 歌手名写入缓存（截断至 40 字符）
artist=$(playerctl -p "$PLAYER" metadata xesam:artist 2>/dev/null)
artist="${artist:-Unknown Artist}"
"$TRUNCATE" "$artist" 25 > /tmp/conky_music_artist.txt

# 歌曲名写入缓存（截断至 25 字符）
title=$(playerctl -p "$PLAYER" metadata xesam:title 2>/dev/null)
title="${title:-Unknown Title}"
"$TRUNCATE" "$title" 25 > /tmp/conky_music_title.txt

# 封面更新
cover_url=$(playerctl -p "$PLAYER" metadata mpris:artUrl 2>/dev/null)
update_cover "$cover_url"

exit 0
