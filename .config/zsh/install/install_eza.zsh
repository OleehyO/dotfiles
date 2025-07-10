# ref: https://github.com/eza-community/eza/blob/main/INSTALL.md
# Install eza
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v eza >/dev/null 2>&1; then
            echo "Installing eza via Homebrew..."
            brew install eza
        else
            echo "eza is already installed"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v eza >/dev/null 2>&1; then
            echo "Installing eza via snap..."
            sudo mkdir -p /etc/apt/keyrings
            wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
            echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
            sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
            sudo apt update
            sudo apt install -y eza
        else
            echo "eza is already installed"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for eza installation: $os"
        return 1
        ;;
esac 