# ~/.zshrc

# 下载字体：https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
# 在vscode terminal中配置font（cmd + ，后搜索font, 加上'JetBrainsMono Nerd Font'）
# (其他字体可以看https://www.nerdfonts.com/#home)

# MACOS
# 下载ITEM：https://iterm2.com/index.html
# item中导入ItemSetting.json：Item -> settings -> profiles -> other actions -> import json files -> 选中这个配置 -> other actions -> set as default
# ITEM的其他主题可以参考：https://github.com/mbadolato/iTerm2-Color-Schemes

# TODO: item2 远端vim yank到本地

# -- PATH 相关 ------------------------------------------
export PATH="$HOME/.local/bin:$PATH"


# -- nvim 替换 vim --------------------------------------
export VISUAL='nvim'
export EDITOR="$VISUAL"
alias vim="$VISUAL"
alias vi="$VISUAL"


# -- 加载别名配置和函数配置 --------------------------------
DOTFILE="${HOME}/dotfile"
source "${DOTFILE}/.config/zsh/functions.zsh"

eval $(curl -fsSL proxy.msh.work:3128/env --noproxy proxy.msh.work)

# =============================================================================
# Oh my zsh
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"

plugins=(
    z # 记录你访问过的目录，并快速跳转
    fzf
    git
    docker
    tmux # Oh My Zsh 自带的 tmux 插件
    zsh-autosuggestions # 必须放在后面
    zsh-syntax-highlighting # 必须放在最后
    fzf-tab  # ref: https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#oh-my-zsh
    zsh-vi-mode  # 最好放在最后；ref: https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#as-an-oh-my-zsh-custom-plugin
)

# --  zsh-vi-mode插件相关配置 --------------------------------------------
# 使用zsh-vi-mode插件后会自动绑定vim

# 设置低延迟
export KEYTIMEOUT=1

# -M vicmd 指定了正常模式 (vi command, normal模式)
bindkey -M vicmd -r '/'  # 禁用/在正常模式下的搜索功能
bindkey -M vicmd -r '?'  # 禁用?在正常模式下的搜索功能
bindkey -M vicmd ":" undefined-key  # 禁用正常模式下输入“:”进入excute模式

# 把编辑模式下的Ctrl+R绑定到fzf-history上
zvm_after_init_commands+=(
  # Bind Ctrl+R in insert mode to the fzf history search widget
  'bindkey -M viins "^R" fzf-history-widget'

  # 让 Control+K 在插入模式 (viins) 和普通模式 (vicmd) 下都实现清屏
  'bindkey -M viins "^K" clear-screen'
  'bindkey -M vicmd "^K" clear-screen'
)

# 加载oh-my-zsh
source $ZSH/oh-my-zsh.sh
# 加载主题配置
source "${DOTFILE}/.config/zsh/theme.zsh"
# 加载别名
source "${DOTFILE}/.config/zsh/aliases.zsh"


# =============================================================================
# Custom zsh style
# =============================================================================

# -- fzf-tab相关的tab补全style --------------------------------------------
# (ref: https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#configure)

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# tmux 弹出窗口
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# -- fzf界面美化 --------------------------------------------------
# ref： https://github.com/catppuccin/fzf?tab=readme-ov-file#usage
export FZF_DEFAULT_OPTS=" \
--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
--color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
--color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
--color=selected-bg:#BCC0CC \
--color=border:#CCD0DA,label:#4C4F69"

# fzf ctrl+T的时候增加预览，并使用full模式
export FZF_CTRL_T_OPTS="--style full \
  --preview 'fzf-preview.sh {}' \
  --bind 'focus:transform-header:file --brief {}'"


# =============================================================================
# 环境变量设置
# =============================================================================

# 设置默认编辑器
export EDITOR="nvim"
export VISUAL="nvim"

# Homebrew 镜像设置
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
export HOMEBREW_NO_AUTO_UPDATE=1

# 其他环境变量
export TLDR_AUTO_UPDATE_DISABLED=1

# 确保 ~/.local/bin 在 PATH 中
export PATH="$HOME/.local/bin:$PATH"


# =============================================================================
# ZSH 基础配置
# =============================================================================

# 历史记录设置
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# ZSH 选项
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# -- nvm ---------------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# -- conda --------------------------------------
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

__conda_setup="$('/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup

# <<< conda initialize <<<
