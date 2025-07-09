# ~/.config/zsh/aliases.zsh
# ZSH 别名配置

# =============================================================================
# 文件与目录导航
# =============================================================================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# =============================================================================
# 现代化工具替代 (需要安装对应工具)
# =============================================================================

# 使用 eza 替代 ls
if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons"
    alias ll="eza -l --icons --git"
    alias la="eza -la --icons --git"
    alias lt="eza -T --icons --level=3"
else
    alias ll="ls -l"
    alias la="ls -la"
    alias lt="tree -L 3"
fi

# 使用 bat 替代 cat
if command -v bat >/dev/null 2>&1; then
    alias cat="bat --paging=never"
    alias catp="bat"
elif command -v batcat >/dev/null 2>&1; then
    alias cat="batcat --paging=never"
    alias catp="batcat"
fi

# 使用 fd 替代 find
if command -v fd >/dev/null 2>&1; then
    alias find="fd"
elif command -v fdfind >/dev/null 2>&1; then
    alias find="fdfind"
fi

# # 使用 rg 替代 grep
# if command -v rg >/dev/null 2>&1; then
#     alias grep="rg"
# fi

# =============================================================================
# 文件操作
# =============================================================================
alias mkdir="mkdir -p"
alias mv="mv -i"
alias cp="cp -i"

# =============================================================================
# 系统监控
# =============================================================================
alias df="df -h"
alias du="du -sh"
alias du1="du -h -d 1 | sort -h"
alias free="free -h"
alias ports="netstat -tulpn"

# 使用 htop 替代 top
if command -v htop >/dev/null 2>&1; then
    alias top="htop"
fi

# =============================================================================
# Tmux 快捷操作
# =============================================================================
alias ta="tmux attach -t"
alias tad="tmux attach -d -t"
alias ts="tmux new-session -s"
alias tl="tmux list-sessions"
alias tk="tmux kill-session -t"
alias trs="tmux rename-session -t"
alias tkss="tmux kill-server"

# =============================================================================
# Git 别名
# =============================================================================
alias g="git"
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias ga="git add"
alias gc="git commit -v"
alias gco="git checkout"
alias gb="git branch"
alias gd="git diff"
alias glog="git log --oneline --graph"

# =============================================================================
# 快速操作
# =============================================================================
alias j="z"  # 兼容 z 快速跳转

# =============================================================================
# 网络相关
# =============================================================================
alias ping="ping -c 5"
alias wget="wget -c"  # 断点续传 