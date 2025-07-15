# ~/.config/zsh/theme.zsh
# ZSH 主题和 Prompt 配置

# 启用颜色支持
autoload -U colors && colors

# 自定义 prompt 函数
prompt_custom() {
    local dir_cnt=$(echo "$PWD" | grep -o '/' | wc -l | sed 's/^ *//')
    local prompt_str="["

    if [ $dir_cnt -ge 3 ]; then
        prompt_str+="..."
    fi

    if [ $dir_cnt -ge 2 ]; then
        prompt_str+=$(echo "$PWD" | awk -F'/' '{printf("/%s",$(NF-1))}')
    fi

    prompt_str+=$(echo "$PWD" | awk -F'/' '{printf("/%s] ",$(NF))}')
    echo "%F{199}${prompt_str}%f"
}

# 利用oh-my-zsh的ZVM_MODE来显示vi模式，并设置为大写+灰色加粗
# 利用prompt_custom来获取当前的路径（最多显示3级）
PROMPT='%B%F{#D3D3D3}${(U)ZVM_MODE}%f%b $(prompt_custom)'


# --- 右侧 Prompt (RPROMPT) 的样式定义 ---
# 加载 vcs_info (版本控制系统信息) 模块
autoload -Uz vcs_info
setopt prompt_subst

# 1. 统一定义 RPROMPT 的颜色为灰色
RPROMPT_COLOR='%F{242}'

# 2. Git 分支信息格式 (使用统一的灰色)
# '  %b' -> ' <图标> <分支名>'
zstyle ':vcs_info:git*' formats " ${RPROMPT_COLOR} %b%f"
zstyle ':vcs_info:git*' actionformats " ${RPROMPT_COLOR} %b|%a%f"

# 3. 定义图标
PYTHON_ICON=''         # Python 的 Nerd Font 图标
TIME_ICON=''           # 时间的图标


# --- precmd 函数在每个 prompt 显示之前运行 ---
precmd() {
    # 更新 VCS (Git) 信息
    vcs_info

    # 定义一个数组来存放 RPROMPT 的各个部分
    local -a rprompt_parts

    # --- 检查并添加元素到数组 ---

    # 1. 检测 Python 环境 (Conda or venv) - 现在使用统一的灰色
    local python_env_str=""
    if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        python_env_str="${RPROMPT_COLOR}${PYTHON_ICON} ${CONDA_DEFAULT_ENV}%f"
    elif [[ -n "$VIRTUAL_ENV" && -d "$VIRTUAL_ENV" && "$PATH" == *"$VIRTUAL_ENV/bin"* ]]; then
        # 检查虚拟环境是否真正激活：PATH中包含该环境的bin目录
        # :h 获取父目录路径, :t 再获取该路径的名称
        python_env_str="${RPROMPT_COLOR}${PYTHON_ICON} ${${VIRTUAL_ENV:h}:t}%f"
    fi

    if [[ -n "$python_env_str" ]]; then
        rprompt_parts+=("$python_env_str")
    fi

    # 2. 检测 Git 仓库
    if [[ -n "${vcs_info_msg_0_}" ]]; then
        rprompt_parts+=("${vcs_info_msg_0_}")
    fi

    # 3. 添加时间戳 (使用统一的灰色)
    rprompt_parts+=("${RPROMPT_COLOR}${TIME_ICON} %T%f")


    # --- 组合 RPROMPT ---
    # 使用 (j:  :) 将数组元素用两个空格连接起来
    RPROMPT="${(j:  :)rprompt_parts}"
}

# 禁用venv左侧prompt提示
export VIRTUAL_ENV_DISABLE_PROMPT=1


# --- 语法高亮 ---
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# --- 主要样式 (main highlighter) ---
# 命令和函数 (使用纯正的绿色)
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,italic'

# 参数和变量
ZSH_HIGHLIGHT_STYLES[option]='fg=magenta,bold'               # <--- 选项：鲜艳的洋红色，非常醒目
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=178'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=178'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=178'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=cyan'         # <--- 使用标准青色，见下方提示
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[assign]='fg=black'                      # <--- 赋值：黑色在白底上对比度最高

# 路径 (使用纯正的蓝色)
ZSH_HIGHLIGHT_STYLES[path]='fg=blue,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=blue'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=blue,underline,italic'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'

# 其他符号
ZSH_HIGHLIGHT_STYLES[redirection]='fg=red'                   # <--- 重定向：使用纯红色
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=purple,underline'
ZSH_HIGHLIGHT_STYLES[comment]='fg=250,italic'               # <--- 注释：用带斜体的灰色


# --- 括号样式 (brackets highlighter) ---
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=green'


# --- 自定义模式 (pattern highlighter) ---
# 高亮 "TODO:", "FIXME:", "NOTE:" 等关键字
ZSH_HIGHLIGHT_PATTERNS[todo-keywords]='(TODO|FIXME|NOTE):'
ZSH_HIGHLIGHT_STYLES[todo-keywords]='fg=purple,bold,underline'

# 高亮数字
ZSH_HIGHLIGHT_PATTERNS[numeric]='fg=magenta'