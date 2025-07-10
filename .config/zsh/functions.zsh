# ~/.config/zsh/functions.zsh
# ZSH 实用函数配置

# =============================================================================
# 代理管理
# =============================================================================

# 设置代理
set_proxy() {
    if [ $# -eq 0 ]; then
        # 使用默认代理地址
        export http_proxy="http://127.0.0.1:64991"
        export https_proxy="http://127.0.0.1:64991"
        export HTTP_PROXY="http://127.0.0.1:64991"
        export HTTPS_PROXY="http://127.0.0.1:64991"
        echo "Proxy set to: http://127.0.0.1:64991"
    else
        # 使用用户提供的代理地址
        export http_proxy="$1"
        export https_proxy="$1"
        export HTTP_PROXY="$1"
        export HTTPS_PROXY="$1"
    fi
}

# 取消代理
unset_proxy() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
}

# 显示当前代理状态
show_proxy() {
    echo "Current proxy settings:"
    echo "  http_proxy: ${http_proxy:-"Not set"}"
    echo "  https_proxy: ${https_proxy:-"Not set"}"
    echo "  HTTP_PROXY: ${HTTP_PROXY:-"Not set"}"
    echo "  HTTPS_PROXY: ${HTTPS_PROXY:-"Not set"}"
}

# =============================================================================
# 系统检测
# =============================================================================

# 检测当前系统
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v lsb_release >/dev/null 2>&1; then
            local distro=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
            if [[ "$distro" == "ubuntu" ]]; then
                echo "ubuntu"
            else
                echo "linux"
            fi
        elif [[ -f /etc/os-release ]]; then
            local distro=$(grep '^ID=' /etc/os-release | cut -d'=' -f2 | tr -d '"')
            if [[ "$distro" == "ubuntu" ]]; then
                echo "ubuntu"
            else
                echo "linux"
            fi
        else
            echo "linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# 检查是否为 macOS
is_macos() {
    [[ "$(detect_os)" == "macos" ]]
}

# 检查是否为 Ubuntu
is_ubuntu() {
    [[ "$(detect_os)" == "ubuntu" ]]
}

# =============================================================================
# 包管理自适应函数
# =============================================================================

# 更新包管理器
update() {
    local os=$(detect_os)
    case $os in
        "macos")
            echo "Updating Homebrew..."
            brew update && brew upgrade --verbose
            ;;
        "ubuntu")
            echo "Updating APT packages..."
            sudo apt update && sudo apt upgrade -y
            ;;
        *)
            echo "Unsupported operating system: $os"
            return 1
            ;;
    esac
}

# 安装包
install() {
    if [ $# -eq 0 ]; then
        echo "Usage: install <package_name>"
        return 1
    fi
    
    local os=$(detect_os)
    case $os in
        "macos")
            echo "Installing $1 via Homebrew..."
            brew install "$1"
            ;;
        "ubuntu")
            echo "Installing $1 via APT..."
            sudo apt install -y "$1"
            ;;
        *)
            echo "Unsupported operating system: $os"
            return 1
            ;;
    esac
}

# 卸载包
remove() {
    if [ $# -eq 0 ]; then
        echo "Usage: remove <package_name>"
        return 1
    fi
    
    local os=$(detect_os)
    case $os in
        "macos")
            echo "Removing $1 via Homebrew..."
            brew uninstall "$1"
            ;;
        "ubuntu")
            echo "Removing $1 via APT..."
            sudo apt remove -y "$1"
            ;;
        *)
            echo "Unsupported operating system: $os"
            return 1
            ;;
    esac
}

# 搜索包
search() {
    if [ $# -eq 0 ]; then
        echo "Usage: search <package_name>"
        return 1
    fi
    
    local os=$(detect_os)
    case $os in
        "macos")
            echo "Searching for $1 in Homebrew..."
            brew search "$1"
            ;;
        "ubuntu")
            echo "Searching for $1 in APT..."
            apt search "$1"
            ;;
        *)
            echo "Unsupported operating system: $os"
            return 1
            ;;
    esac
}


# =============================================================================
# 实用工具函数
# =============================================================================

# 解压文件/目录
extract() {
    if [ $# -eq 0 ]; then
        echo "Usage: extract <archive_file>"
        echo "Supported formats: .tar, .zip"
        return 1
    fi
    
    if [ -f "$1" ]; then
        case "$1" in
            *.tar)
                echo "Extracting tar archive: $1"
                tar xf "$1"
                ;;
            *.zip)
                echo "Extracting zip archive: $1"
                unzip "$1"
                ;;
            *)
                echo "Error: Unsupported archive format for '$1'"
                echo "Supported formats: .tar, .zip"
                return 1
                ;;
        esac
        
        if [ $? -eq 0 ]; then
            echo "Archive extracted successfully: $1"
        else
            echo "Error: Failed to extract archive"
            return 1
        fi
    else
        echo "Error: '$1' is not a valid file"
        return 1
    fi
}

# 打包压缩文件/目录
compress() {
    if [ $# -lt 2 ]; then
        echo "Usage: compress <archive_name> <file_or_directory> [additional_files...]"
        echo "Examples:"
        echo "  compress backup.tar ~/Documents"
        echo "  compress project.zip src/ README.md"
        return 1
    fi
    
    local archive="$1"
    shift
    
    # 检查要压缩的文件/目录是否存在
    for item in "$@"; do
        if [ ! -e "$item" ]; then
            echo "Error: '$item' does not exist"
            return 1
        fi
    done
    
    case "$archive" in
        *.tar)
            echo "Creating tar archive: $archive"
            tar cf "$archive" "$@"
            ;;
        *.zip)
            echo "Creating zip archive: $archive"
            zip -r "$archive" "$@"
            ;;
        *)
            echo "Error: Unsupported archive format for '$archive'"
            echo "Supported formats: .tar, .zip"
            return 1
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        echo "Archive created successfully: $archive"
        ls -lh "$archive"
    else
        echo "Error: Failed to create archive"
        return 1
    fi
}

# 显示目录大小
dirsize() {
    du -sh "${1:-.}" | sort -h
}

# 快速备份文件
backup() {
    cp "$1" "$1.backup.$(date +%Y%m%d%H%M%S)"
}

# =============================================================================
# 配置文件编辑
# =============================================================================

# 编辑主 zsh 配置文件
editzsh() {
    $EDITOR "$DOTFILE/.zshrc"
}

# 编辑别名配置文件
editaliases() {
    $EDITOR "$DOTFILE/.config/zsh/aliases.zsh"
}

# 编辑函数配置文件
editfunctions() {
    $EDITOR "$DOTFILE/.config/zsh/functions.zsh"
}

# 编辑主题配置文件
edittheme() {
    $EDITOR "$DOTFILE/.config/zsh/theme.zsh"
}

# 查看当前定义的别名
showaliases() {
    local aliases_file="$DOTFILE/.config/zsh/aliases.zsh"
    
    if [[ ! -f "$aliases_file" ]]; then
        echo "Error: aliases.zsh file not found at $aliases_file"
        return 1
    fi
    
    echo "Current aliases defined in aliases.zsh:"
    echo "========================================"
    
    # 显示所有别名定义，过滤掉注释和空行
    # 使用更兼容的正则表达式
    grep -E '^[ \t]*alias' "$aliases_file" | \
    sed 's/^[ \t]*//' | \
    sort
    
    echo "========================================"
    echo "Total aliases: $(grep -E '^[ \t]*alias' "$aliases_file" | wc -l)"
}

# 重新加载 zsh 配置
reload() {
    source ~/.zshrc
    echo "ZSH configuration reloaded!"
} 