# Install ripgrep: https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v rg >/dev/null 2>&1; then
            echo "Installing ripgrep via Homebrew..."
            brew install ripgrep
        else
            echo "ripgrep is already installed"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v rg >/dev/null 2>&1; then
            echo "Installing ripgrep via APT..."
            sudo apt install -y ripgrep
        else
            echo "ripgrep is already installed"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for ripgrep installation: $os"
        return 1
        ;;
esac 