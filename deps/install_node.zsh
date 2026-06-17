#!/usr/bin/env zsh

# Node.js安装脚本
# 使用 nvm (Node Version Manager) 安装和管理 Node.js

# 检查是否已经安装nvm和node
if [[ -d "$HOME/.nvm" ]] && command -v node >/dev/null 2>&1; then
    echo "✅ nvm 和 Node.js 已经安装"
    echo "Node.js version: $(node --version)"
    echo "nvm version: $(nvm --version 2>/dev/null || echo 'nvm loaded')"
    return 0
fi

echo "📦 安装 nvm (Node Version Manager)..."

# 下载并安装 nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# 如果curl失败，尝试使用wget
if [[ $? -ne 0 ]]; then
    echo "curl 失败，尝试使用 wget..."
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
fi

if [[ $? -ne 0 ]]; then
    echo "❌ nvm 安装失败"
    return 1
fi

# 加载 nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# 安装最新的 LTS 版本
echo "📦 安装 Node.js LTS 版本..."
nvm install --lts

if [[ $? -ne 0 ]]; then
    echo "❌ Node.js 安装失败"
    return 1
fi

# 验证安装
if command -v node >/dev/null 2>&1; then
    echo "✅ Node.js 安装成功!"
    echo "Node.js version: $(node --version)"
    echo "npm version: $(npm --version)"
    return 0
else
    echo "❌ Node.js 安装失败"
    return 1
fi
