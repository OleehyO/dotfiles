# Install fzf: https://github.com/junegunn/fzf
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v fzf >/dev/null 2>&1; then
            echo "Installing fzf via git..."
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install
        else
            echo "fzf is already installed"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v fzf >/dev/null 2>&1; then
            echo "Installing fzf via git..."
            git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
            ~/.fzf/install
        else
            echo "fzf is already installed"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for fzf installation: $os"
        return 1
        ;;
esac 