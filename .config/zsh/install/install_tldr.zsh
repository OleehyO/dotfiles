# Install tldr
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v tldr >/dev/null 2>&1; then
            echo "Installing tldr via Homebrew..."
            brew install tldr
        else
            echo "tldr is already installed"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v tldr >/dev/null 2>&1; then
            echo "Installing tldr via snap..."
            sudo snap install tldr
        else
            echo "tldr is already installed"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for tldr installation: $os"
        return 1
        ;;
esac 