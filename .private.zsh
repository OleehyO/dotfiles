#!/bin/zsh
# ~/.private.zsh
# 此文件包含不能公开的私有配置
# 请确保此文件不会被提交到版本控制系统中

# =============================================================================
# 代理设置
# =============================================================================
eval $(curl -fsSL proxy.msh.work:3128/env --noproxy proxy.msh.work)

# =============================================================================
# 其他隐秘操作可以在这里添加
# =============================================================================

# 示例：私有API密钥或令牌
# export PRIVATE_API_KEY="your-secret-key"
# export COMPANY_TOKEN="your-company-token"

# 示例：私有服务器配置
# export INTERNAL_SERVER_URL="https://internal.company.com"
# export DB_PASSWORD="secret-password"

# 示例：个人的私有配置
# alias ssh-work="ssh user@private-server.company.com"
# alias vpn-connect="sudo openvpn /path/to/company.ovpn"

# 注意：请根据实际需要添加您的隐秘配置 

# claude API
export ANTHROPIC_BASE_URL=
export ANTHROPIC_AUTH_TOKEN=

# moonshot + claude
export MSH_ANTHROPIC_BASE_URL=https://api.moonshot.cn/anthropic/
export MSH_ANTHROPIC_AUTH_TOKEN=

# qwen + claude
export QWEN_ANTHROPIC_BASE_URL=https://dashscope.aliyuncs.com/api/v2/apps/claude-code-proxy
export QWEN_ANTHROPIC_AUTH_TOKEN=

# zhipu + claude
export ZHIPU_ANTHROPIC_BASE_URL=https://open.bigmodel.cn/api/anthropic 
export ZHIPU_ANTHROPIC_AUTH_TOKEN=
