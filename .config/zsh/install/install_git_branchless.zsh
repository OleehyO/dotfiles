# https://github.com/arxanas/git-branchless/wiki/Installation
# Install git-branchless
local os=$(detect_os)

# Check if git-branchless is already installed
if command -v git-branchless >/dev/null 2>&1; then
    echo "git-branchless is already installed ($(git-branchless --version))"
    return 0
fi

# Ensure Git version >= 2.29
if ! command -v git >/dev/null 2>&1; then
    echo "Git is not installed. Installing Git first..."
    source "$DOTFILE/.config/zsh/install/install_git.zsh" || {
        echo "Error: Failed to install Git"
        return 1
    }
else
    local git_version=$(git --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    local major=$(echo $git_version | cut -d. -f1)
    local minor=$(echo $git_version | cut -d. -f2)

    if [ "$major" -lt 2 ] || ([ "$major" -eq 2 ] && [ "$minor" -lt 29 ]); then
        echo "Git version $git_version is too old. Upgrading Git first..."
        source "$DOTFILE/.config/zsh/install/install_git.zsh" || {
            echo "Error: Failed to upgrade Git"
            return 1
        }
    fi
fi

case $os in
    "macos")
        echo "Installing git-branchless via Homebrew..."
        brew install git-branchless
        ;;
    "ubuntu")
        echo "Installing git-branchless via Cargo..."

        # Ensure Cargo is installed
        if ! command -v cargo >/dev/null 2>&1; then
            echo "Cargo is not installed. Installing Cargo first..."
            source "$DOTFILE/.config/zsh/install/install_cargo.zsh" || {
                echo "Error: Failed to install Cargo"
                return 1
            }
        fi

        # Try to install from source
        cargo install --locked git-branchless

        if [ $? -ne 0 ]; then
            echo ""
            echo "Error: Cargo installation failed due to compilation errors."
            echo "This might be caused by Rust version compatibility issues."
            echo ""
            echo "Alternative solutions:"
            echo "1. Try installing from pre-built binaries:"
            echo "   Visit https://github.com/arxanas/git-branchless/releases"
            echo ""
            echo "2. Try installing via snap:"
            echo "   sudo snap install --classic git-branchless"
            return 1
        fi
        ;;
    *)
        echo "Unsupported OS for git-branchless installation: $os"
        return 1
        ;;
esac

if command -v git-branchless >/dev/null 2>&1; then
    echo "git-branchless installed successfully: $(git-branchless --version)"
    echo ""
    echo "To enable git-branchless in a repository, run:"
    echo "  git branchless init"
    echo ""
    echo "An alias 'git=git-branchless wrap --' has been added to aliases.zsh"

    # 配置 git fixup alias：从顶端把改动 fixup 进目标 commit 并 restack
    # 原理：GIT_SEQUENCE_EDITOR=true 使 rebase -i 变为非交互式自动执行
    echo ""
    echo "Configuring 'git fixup' alias..."
    git config --global alias.fixup '!sh -c '"'"'REV=$(git rev-parse $1) && git commit --fixup $@ && GIT_SEQUENCE_EDITOR=true git rebase -i --autostash --autosquash $REV^ && git restack'"'"' -'

    # 关闭 branchless 导航命令自动切换分支：next/prev/checkout 等只移动 HEAD，保持 branchless 工作流
    echo "Disabling branchless.navigation.autoSwitchBranches..."
    git config --global branchless.navigation.autoSwitchBranches false
else
    echo "Error: git-branchless installation failed"
    return 1
fi
