# Install z (smart directory jumper): https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v z >/dev/null 2>&1; then
            echo "Installing z via Homebrew..."
            curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
        else
            echo "z is already installed"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v z >/dev/null 2>&1; then
            echo "Installing z via APT..."
            curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
        else
            echo "z is already installed"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for z installation: $os"
        return 1
        ;;
esac 