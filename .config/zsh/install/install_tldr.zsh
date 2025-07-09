# Install tldr
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v tldr >/dev/null 2>&1; then
            echo "Installing tldr via pip..."
            pip3 install tldr
        else
            echo "tldr is already installed"
        fi
        ;;
    "ubuntu")
        if ! command -v tldr >/dev/null 2>&1; then
            echo "Installing tldr via pip..."
            pip3 install tldr
        else
            echo "tldr is already installed"
        fi
        ;;
    *)
        echo "Unsupported OS for tldr installation: $os"
        return 1
        ;;
esac 