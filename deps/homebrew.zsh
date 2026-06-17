#!/bin/zsh

# 颜色定义
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

find_brew() {
    if command -v brew >/dev/null 2>&1; then
        command -v brew
        return 0
    fi

    for brew_path in \
        /opt/homebrew/bin/brew \
        /usr/local/bin/brew \
        /home/linuxbrew/.linuxbrew/bin/brew
    do
        if [[ -x "$brew_path" ]]; then
            echo "$brew_path"
            return 0
        fi
    done

    return 1
}

load_brew_env() {
    local brew_path="$1"
    eval "$("$brew_path" shellenv)"
}

# 检查是否已经安装有brew
local existing_brew=$(find_brew)
if [[ -n "$existing_brew" ]]; then
    load_brew_env "$existing_brew"
    echo -e "${GREEN}✅ Homebrew 已经安装在 $existing_brew${NC}"

    # 检查是否需要更新
    echo -e "${BLUE}正在检查 Homebrew 更新...${NC}"
    brew update

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Homebrew 已更新到最新版本${NC}"
    else
        echo -e "${YELLOW}⚠️  更新 Homebrew 时出现问题${NC}"
    fi

    return 0
fi

echo -e "${BLUE}正在安装Homebrew...${NC}"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo -e "${YELLOW}⚠️  Linux 上不自动安装 Homebrew，避免 sudo 和 /home/linuxbrew/.linuxbrew 权限问题${NC}"
    echo -e "${YELLOW}如确实需要，请按 https://docs.brew.sh/Homebrew-on-Linux 手动安装${NC}"
    return 0
elif [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}❌ Unsupported OS for Homebrew installation: $OSTYPE${NC}"
    return 1
fi

# 使用官方安装脚本安装Homebrew
if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
    echo -e "${GREEN}✅ Homebrew 安装成功${NC}"

    # 根据系统架构设置正确的路径
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    elif [[ "$(uname -m)" == "arm64" ]]; then
        # Apple Silicon Macs
        HOMEBREW_PREFIX="/opt/homebrew"
    else
        # Intel Macs
        HOMEBREW_PREFIX="/usr/local"
    fi

    # 检查brew命令是否可用
    if [ -f "${HOMEBREW_PREFIX}/bin/brew" ]; then
        # 添加到当前shell的环境变量
        load_brew_env "${HOMEBREW_PREFIX}/bin/brew"

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
            return 1
        fi
    else
        echo -e "${RED}❌ Homebrew 安装失败：找不到brew命令${NC}"
        return 1
    fi
else
    echo -e "${RED}❌ Homebrew 安装失败${NC}"
    return 1
fi

return 0
