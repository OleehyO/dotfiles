# https://github.com/sharkdp/bat/blob/master/doc/README-zh.md
# Install bat
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v bat >/dev/null 2>&1; then
            echo "Installing bat via Homebrew..."
            brew install bat
        else
            echo "bat is already installed"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v bat >/dev/null 2>&1 && ! command -v batcat >/dev/null 2>&1; then
            echo "Installing bat via APT..."
            sudo apt install -y bat
            echo "Note: On Ubuntu, bat is installed as 'batcat' to avoid conflicts"
        else
            echo "bat is already installed"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for bat installation: $os"
        return 1
        ;;
esac 