#!/bin/zsh

# 设置错误时立即退出 - 注释掉以便手动处理错误
# set -e

# 颜色定义
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# 确保 ~/.local/bin 在 PATH 中，以便检测到已安装的工具
export PATH="$HOME/.local/bin:$PATH"

# 错误计数器
ERROR_COUNT=0
FAILED_INSTALLS=()

# 日志文件
LOG_FILE="$HOME/dotfiles_install.log"
echo "Installation started at $(date)" > "$LOG_FILE"

# 日志记录函数
log_message() {
    local message="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$LOG_FILE"
}

# 错误处理函数
handle_error() {
    local exit_code=$?
    local step_name="$1"
    if [ $exit_code -ne 0 ]; then
        local error_msg="❌ Error: $step_name failed with exit code $exit_code"
        echo -e "${RED}$error_msg${NC}"
        log_message "$error_msg"
        ERROR_COUNT=$((ERROR_COUNT + 1))
        FAILED_INSTALLS+=("$step_name")
        return 1
    else
        local success_msg="✅ $step_name completed successfully"
        echo -e "${GREEN}$success_msg${NC}"
        log_message "$success_msg"
        return 0
    fi
}

# 执行安装步骤的函数
run_install() {
    local step_name="$1"
    local script_path="$2"
    
    echo -e "${BLUE}==================================${NC}"
    echo -e "${BLUE}Installing $step_name...${NC}"
    echo -e "${BLUE}==================================${NC}"
    log_message "Starting installation of $step_name"
    
    # 执行安装脚本并记录输出，正确捕获退出状态
    # 使用临时文件来捕获退出状态
    local temp_exit_file=$(mktemp)
    (source "$script_path"; echo $? > "$temp_exit_file") 2>&1 | tee -a "$LOG_FILE"
    local install_exit_code=$(cat "$temp_exit_file")
    rm -f "$temp_exit_file"
    
    if [ "${install_exit_code:-1}" -eq 0 ]; then
        # 安装成功，手动设置退出代码为0再调用handle_error
        (exit 0)
        handle_error "$step_name"

        # 重新加载环境以确保新安装的工具可以被后续脚本使用
        [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
        [ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"
        [ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

        # 更新 PATH（针对 Homebrew 等）
        if [[ "$OSTYPE" == "darwin"* ]]; then
            [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
            [ -x /usr/local/bin/brew ] && eval "$(/usr/local/bin/brew shellenv)"
        fi

        # 刷新 zsh 命令缓存
        command -v rehash >/dev/null 2>&1 && rehash
    else
        # 手动设置退出代码以便 handle_error 正确处理
        (exit "${install_exit_code:-1}")
        handle_error "$step_name"
        echo -e "${YELLOW}Options:${NC}"
        echo -e "${YELLOW}  r) Retry this installation${NC}"
        echo -e "${YELLOW}  s) Skip and continue${NC}"
        echo -e "${YELLOW}  q) Quit installation${NC}"
        echo -e "${YELLOW}Choose (r/s/q): ${NC}"
        read choice
        case $choice in
            r|R)
                echo -e "${BLUE}Retrying $step_name...${NC}"
                run_install "$step_name" "$script_path"
                return
                ;;
            q|Q)
                echo -e "${RED}Installation aborted by user${NC}"
                log_message "Installation aborted by user"
                exit 1
                ;;
            *)
                echo -e "${YELLOW}Skipping $step_name and continuing...${NC}"
                log_message "Skipped $step_name"
                ;;
        esac
    fi
    
    echo -e "${YELLOW}Press Enter to continue...${NC}"
    read
    clear
}

echo -e "${RED}Starting initial setup for $(detect_os)...${NC}"
echo -e "${BLUE}Log file: $LOG_FILE${NC}"

source ~/dotfiles/.config/zsh/functions.zsh

# 首先更新包管理器
echo -e "${BLUE}Updating package manager...${NC}"
log_message "Starting package manager update"
if update 2>&1 | tee -a "$LOG_FILE"; then
    handle_error "Package manager update"
else
    handle_error "Package manager update"
fi

# 安装各个工具
INSTALL_DIR="$HOME/dotfiles/.config/zsh/install"

# 定义所有安装步骤（使用有序数组保证执行顺序）
# 格式: "步骤名称:脚本路径"
INSTALL_STEPS=(
    "Oh My Zsh:$INSTALL_DIR/install_ohmyzsh.zsh"
    "tzdata:$INSTALL_DIR/install_tzdata.zsh"
    "Git:$INSTALL_DIR/install_git.zsh"
    "Cargo:$INSTALL_DIR/install_cargo.zsh"
    "tmux:$INSTALL_DIR/install_tmux.zsh"
    "eza:$INSTALL_DIR/install_eza.zsh"
    "bat:$INSTALL_DIR/install_bat.zsh"
    "z:$INSTALL_DIR/install_z.zsh"
    "tldr:$INSTALL_DIR/install_tldr.zsh"
    "fzf:$INSTALL_DIR/install_fzf.zsh"
    "ripgrep:$INSTALL_DIR/install_ripgrep.zsh"
    "fd:$INSTALL_DIR/install_fd.zsh"
    "Neovim:$INSTALL_DIR/install_nvim.zsh"
    "tpm:$INSTALL_DIR/install_tpm.zsh"
    "uv:$INSTALL_DIR/install_uv.zsh"
    "zip:$INSTALL_DIR/install_zip.zsh"
    "Node.js:$INSTALL_DIR/install_node.zsh"
    "git-branchless:$INSTALL_DIR/install_git_branchless.zsh"
    "Codex CLI:$INSTALL_DIR/install_codex.zsh"
    "Claude Code:$INSTALL_DIR/install_claude_code.zsh"
    "ncdu:$INSTALL_DIR/install_ncdu.zsh"
    "rclone:$INSTALL_DIR/install_rclone.zsh"
)

# 执行所有安装步骤（按数组顺序）
for step in "${INSTALL_STEPS[@]}"; do
    step_name="${step%%:*}"
    script_path="${step#*:}"
    run_install "$step_name" "$script_path"
done

# 安装私有工具（有自己的安装逻辑和交互）
echo -e "${BLUE}==================================${NC}"
echo -e "${BLUE}Installing Private Tools...${NC}"
echo -e "${BLUE}==================================${NC}"
source "$INSTALL_DIR/install_private.zsh"

# 显示最终结果
echo -e "${BLUE}==================================${NC}"
echo -e "${BLUE}Installation Summary${NC}"
echo -e "${BLUE}==================================${NC}"

if [ $ERROR_COUNT -eq 0 ]; then
    echo -e "${GREEN}✅ All installations completed successfully!${NC}"
    log_message "All installations completed successfully"
else
    echo -e "${RED}❌ $ERROR_COUNT installation(s) failed:${NC}"
    for failed in "${FAILED_INSTALLS[@]}"; do
        echo -e "${RED}  - $failed${NC}"
    done
    echo -e "${YELLOW}You can retry the failed installations individually.${NC}"
    echo -e "${YELLOW}Check the log file for details: $LOG_FILE${NC}"
    log_message "$ERROR_COUNT installation(s) failed: ${FAILED_INSTALLS[*]}"
fi

log_message "Installation process completed at $(date)"
echo -e "${BLUE}==================================${NC}"
echo -e "${YELLOW}Please restart your shell or run 'source ~/.zshrc' to apply changes.${NC}"

# End of script
