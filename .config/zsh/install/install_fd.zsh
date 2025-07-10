# Install fd
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v fd >/dev/null 2>&1; then
            echo "Installing fd via Homebrew..."
            brew install fd
        else
            echo "fd is already installed"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v fd >/dev/null 2>&1 && ! command -v fdfind >/dev/null 2>&1; then
            echo "Installing fd via APT..."
            sudo apt install -y fd-find
            echo "Creating symbolic link for fd command..."
            mkdir -p ~/.local/bin
            ln -sf $(which fdfind) ~/.local/bin/fd
            echo "Note: ~/.local/bin should be in your PATH"
        else
            echo "fd is already installed"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for fd installation: $os"
        return 1
        ;;
esac 