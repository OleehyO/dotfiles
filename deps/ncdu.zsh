# Install ncdu: https://dev.yorhel.nl/ncdu
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v ncdu >/dev/null 2>&1; then
            echo "Installing ncdu via Homebrew..."
            brew install ncdu
        else
            echo "ncdu is already installed"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v ncdu >/dev/null 2>&1; then
            echo "Installing ncdu via APT..."
            sudo apt install -y ncdu
        else
            echo "ncdu is already installed"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for ncdu installation: $os"
        return 1
        ;;
esac
