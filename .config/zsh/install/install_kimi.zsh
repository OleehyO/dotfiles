#!/bin/zsh

# 颜色定义
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing Kimi CLI...${NC}"

# 使用官方安装脚本安装 Kimi CLI
curl -LsSf https://code.kimi.com/install.sh | bash

# 检查安装是否成功
if command -v kimi >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Kimi CLI installed successfully!${NC}"
    kimi --version
    exit 0
else
    echo -e "${RED}❌ Kimi CLI installation failed!${NC}"
    exit 1
fi