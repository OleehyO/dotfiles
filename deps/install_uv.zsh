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

# 使用官方安装脚本
echo "📦 正在安装 UV..."
curl -LsSf https://astral.sh/uv/install.sh | sh

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