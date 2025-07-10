#!/bin/zsh

# 设置错误时立即退出
set -e

# 颜色定义
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${RED}Starting initial setup for $(detect_os)...${NC}"

source ~/dotfiles/.config/zsh/functions.zsh

# 首先更新包管理器
update

# 安装各个工具
local install_dir="$HOME/dotfiles/.config/zsh/install"

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing Oh My Zsh...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_ohmyzsh.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing tzdata and setting timezone...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_tzdata.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing tmux...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_tmux.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing eza...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_eza.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing bat...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_bat.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing z...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_z.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing tldr...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_tldr.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing fzf...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_fzf.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing ripgrep...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_ripgrep.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing fd...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_fd.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing Neovim...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_nvim.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing tpm...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_tpm.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing uv...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_uv.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing zip...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_zip.zsh"
clear

echo -e "${RED}==================================${NC}"
echo -e "${RED}Installing Node.js...${NC}"
echo -e "${RED}==================================${NC}"
source "$install_dir/install_node.zsh"
clear

echo -e "${GREEN}==================================${NC}"
echo -e "${GREEN}✅ Initial setup completed!${NC}"
echo -e "${GREEN}==================================${NC}"
echo -e "${YELLOW}Please restart your shell or run 'source ~/.zshrc' to apply changes.${NC}"