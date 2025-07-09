# Install tmux
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v tmux >/dev/null 2>&1; then
            echo "Installing tmux via Homebrew..."
            brew install tmux
        else
            echo "tmux is already installed"
        fi
        ;;
    "ubuntu")
        if ! command -v tmux >/dev/null 2>&1; then
            echo "Installing tmux via APT..."
            sudo apt install -y tmux
        else
            echo "tmux is already installed"
        fi
        ;;
    *)
        echo "Unsupported OS for tmux installation: $os"
        return 1
        ;;
esac 