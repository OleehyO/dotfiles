# Install zip utilities
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v zip >/dev/null 2>&1; then
            echo "Installing zip via Homebrew..."
            brew install zip
        else
            echo "zip is already installed"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v zip >/dev/null 2>&1; then
            echo "Installing zip via APT..."
            sudo apt install -y zip unzip
        else
            echo "zip is already installed"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for zip installation: $os"
        return 1
        ;;
esac 