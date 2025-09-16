#!/usr/bin/env zsh

# Install OpenAI Codex CLI via npm

if ! command -v npm >/dev/null 2>&1; then
    echo "❌ npm 未安装，请先运行 Node.js 安装步骤"
    return 1
fi

if command -v codex >/dev/null 2>&1; then
    echo "✅ Codex CLI 已安装: $(codex --version 2>/dev/null)"
    return 0
fi

echo "📦 正在安装 Codex CLI..."
npm install -g @openai/codex

if [[ $? -ne 0 ]]; then
    echo "❌ Codex CLI 安装失败"
    return 1
fi

if command -v codex >/dev/null 2>&1; then
    echo "✅ Codex CLI 安装完成: $(codex --version 2>/dev/null)"
else
    echo "⚠️ Codex CLI 安装完成，但未检测到可执行文件"
fi

return 0
