# Install LLVM compiler infrastructure
local os=$(detect_os)

echo "Installing LLVM..."

case $os in
    "macos")
        if ! command -v llvm-config >/dev/null 2>&1; then
            echo "Installing LLVM via Homebrew..."
            brew install llvm
            # 确保llvm命令在PATH中
            export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
            echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc
        else
            echo "LLVM is already installed"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v llvm-config >/dev/null 2>&1; then
            echo "Installing LLVM via apt..."
            sudo apt update
            sudo apt install -y llvm llvm-dev clang libclang-dev
            # Ubuntu的LLVM路径可能在/usr/bin/llvm-config*
            export PATH="/usr/bin:$PATH"
        else
            echo "LLVM is already installed"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for LLVM installation: $os"
        return 1
        ;;
esac