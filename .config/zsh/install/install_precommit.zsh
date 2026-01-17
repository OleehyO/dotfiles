#!/bin/zsh

# 颜色定义
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing pre-commit...${NC}"

# 检查是否已安装
if command -v pre-commit &> /dev/null; then
    echo -e "${GREEN}pre-commit is already installed.${NC}"
    pre-commit --version
    exit 0
fi

# 确保 uv 已安装
if ! command -v uv &> /dev/null; then
    echo -e "${RED}uv is not installed. Please install uv first.${NC}"
    exit 1
fi

# 使用 uv 安装 pre-commit
echo -e "${YELLOW}Installing pre-commit via uv tool install...${NC}"
uv tool install pre-commit

# 检查安装结果
if command -v pre-commit &> /dev/null; then
    echo -e "${GREEN}✅ pre-commit installed successfully!${NC}"
    pre-commit --version
else
    echo -e "${RED}❌ Failed to install pre-commit${NC}"
    exit 1
fi