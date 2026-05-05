#!/usr/bin/env zsh

# Install LarkSuite (Feishu) CLI via npm
# Repo: https://github.com/larksuite/cli  (npm: @larksuite/cli)

if ! command -v npm >/dev/null 2>&1; then
    echo "❌ npm 未安装，请先运行 Node.js 安装步骤"
    return 1
fi

if command -v lark-cli >/dev/null 2>&1; then
    echo "✅ Lark CLI 已安装: $(lark-cli --version 2>/dev/null)"
    return 0
fi

echo "📦 正在安装 Lark CLI..."
npm install -g @larksuite/cli

if [[ $? -ne 0 ]]; then
    echo "❌ Lark CLI 安装失败"
    return 1
fi

if command -v lark-cli >/dev/null 2>&1; then
    echo "✅ Lark CLI 安装完成: $(lark-cli --version 2>/dev/null)"
else
    echo "⚠️ Lark CLI 安装完成，但未检测到可执行文件"
fi

cat <<'EOF'

---
👉 首次使用前还需要手动跑两步（会弹授权链接，需在浏览器完成）：

  1. 应用配置（必做，bot/user 都需要）：
       lark-cli config init --new

  2. user 身份登录（仅当要以本人身份访问日历/邮件/私人云盘等时）：
       lark-cli auth login --domain <业务域>
       # 或按最小权限：lark-cli auth login --scope "<scope>"
---
EOF

return 0
