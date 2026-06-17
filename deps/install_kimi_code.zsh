#!/usr/bin/env zsh

# Install Kimi Code CLI via the official install script.

if command -v kimi >/dev/null 2>&1; then
    echo "✅ Kimi Code 已安装: $(kimi --version 2>/dev/null)"
    return 0
fi

if ! command -v curl >/dev/null 2>&1; then
    echo "❌ curl 未安装，请先安装 curl"
    return 1
fi

if ! command -v bash >/dev/null 2>&1; then
    echo "❌ bash 未安装，请先安装 bash"
    return 1
fi

echo "📦 正在安装 Kimi Code..."
curl -fsSL https://code.kimi.com/kimi-code/install.sh | bash

if [[ $? -ne 0 ]]; then
    echo "❌ Kimi Code 安装失败"
    return 1
fi

if command -v kimi >/dev/null 2>&1; then
    echo "✅ Kimi Code 安装完成: $(kimi --version 2>/dev/null)"
else
    echo "⚠️ Kimi Code 安装完成，但未检测到 kimi 可执行文件；请重启 shell 或检查 PATH"
fi

return 0
