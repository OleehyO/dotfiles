#!/bin/zsh

# 颜色定义
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# 检查是否已经安装有brew
if command -v brew &> /dev/null; then
    echo -e "${GREEN}✅ Homebrew 已经安装在 $(which brew)${NC}"

    # 检查是否需要更新
    echo -e "${BLUE}正在检查 Homebrew 更新...${NC}"
    brew update

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Homebrew 已更新到最新版本${NC}"
    else
        echo -e "${YELLOW}⚠️  更新 Homebrew 时出现问题${NC}"
    fi

    exit 0
fi

# 检查是否在macOS上运行
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${YELLOW}⚠️  当前系统不是macOS，跳过Homebrew安装${NC}"
    echo -e "${YELLOW}   如果是Linux系统，请考虑使用Linuxbrew或其他包管理器${NC}"
    exit 0
fi

echo -e "${BLUE}正在安装Homebrew...${NC}"

# 使用官方安装脚本安装Homebrew
if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
    echo -e "${GREEN}✅ Homebrew 安装成功${NC}"

    # 根据系统架构设置正确的路径
    if [[ "$(uname -m)" == "arm64" ]]; then
        # Apple Silicon Macs
        HOMEBREW_PREFIX="/opt/homebrew"
    else
        # Intel Macs
        HOMEBREW_PREFIX="/usr/local"
    fi

    # 检查brew命令是否可用
    if [ -f "${HOMEBREW_PREFIX}/bin/brew" ]; then
        # 添加到当前shell的环境变量
        eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

        echo -e "${GREEN}✅ Homebrew 已添加到当前会话的环境变量${NC}"
        echo -e "${BLUE}Homebrew 安装位置: ${HOMEBREW_PREFIX}/bin/brew${NC}"

        # 验证安装
        if command -v brew &> /dev/null; then
            echo -e "${GREEN}✅ 验证成功: brew 命令可用${NC}"

            # 显示版本信息
            BREW_VERSION=$(brew --version | head -n1)
            echo -e "${BLUE}版本信息: $BREW_VERSION${NC}"

            # 可选：安装一些有用的工具
            if [[ -t 0 ]]; then
                echo -e "${YELLOW}是否安装推荐的常用工具？(y/N)${NC}"
                read -r response
                if [[ "$response" =~ ^[Yy]$ ]]; then
                    # 安装一些基本的开发者工具
                    brew install --quiet wget curl git git-lfs tree gnupg || true
                    echo -e "${GREEN}✅ 已安装推荐的常用工具${NC}"
                fi
            fi
        else
            echo -e "${RED}❌ 安装似乎成功了，但brew命令不可用${NC}"
            echo -e "${YELLOW}请确保手动将Homebrew添加到您的PATH环境变量${NC}"
            exit 1
        fi
    else
        echo -e "${RED}❌ Homebrew 安装失败：找不到brew命令${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ Homebrew 安装失败${NC}"
    exit 1
fi