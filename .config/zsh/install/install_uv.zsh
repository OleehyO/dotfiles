#!/bin/bash

set -e  # 遇到错误时退出

echo "🚀 开始安装 UV Python Package Manager..."

# 检查是否已经安装
if command -v uv >/dev/null 2>&1; then
    echo "✅ UV 已经安装"
    uv --version
    return 0
fi

# 检测操作系统
OS="$(uname -s)"
ARCH="$(uname -m)"

echo "检测到系统: $OS $ARCH"

# 安装函数
case "$OS" in
    Linux*)
        echo "📦 在 Linux 上安装 UV..."
        
        # 方法1: 官方安装脚本 (推荐)
        if command -v curl >/dev/null 2>&1; then
            echo "使用 curl 安装..."
            curl -LsSf https://astral.sh/uv/install.sh | sh
        elif command -v wget >/dev/null 2>&1; then
            echo "使用 wget 安装..."
            wget -qO- https://astral.sh/uv/install.sh | sh
        else
            echo "❌ 需要 curl 或 wget 来下载安装脚本"
            echo "请先安装: sudo apt install curl 或 sudo apt install wget"
            exit 1
        fi
        ;;
        
    Darwin*)
        echo "🍎 在 macOS 上安装 UV..."
        
        # 优先使用 Homebrew
        if command -v brew >/dev/null 2>&1; then
            echo "使用 Homebrew 安装..."
            brew install uv
        else
            echo "Homebrew 未找到，使用官方安装脚本..."
            if command -v curl >/dev/null 2>&1; then
                curl -LsSf https://astral.sh/uv/install.sh | sh
            else
                echo "❌ 需要 curl 来下载安装脚本"
                echo "请先安装 Homebrew 或确保 curl 可用"
                exit 1
            fi
        fi
        ;;
        
    *)
        echo "❌ 不支持的操作系统: $OS"
        echo "请手动安装 UV: https://docs.astral.sh/uv/getting-started/installation/"
        exit 1
        ;;
esac

# 验证安装
# 首先尝试更新PATH，以便能找到新安装的uv
if [ -f "$HOME/.local/bin/env" ]; then
    source "$HOME/.local/bin/env"
fi

# 如果环境文件不存在，手动添加到PATH
if [ ! -d "$HOME/.local/bin" ] || [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if command -v uv >/dev/null 2>&1; then
    echo "✅ UV 安装成功!"
    uv --version
    return 0
else
    echo "❌ UV 安装失败"
    return 1
fi