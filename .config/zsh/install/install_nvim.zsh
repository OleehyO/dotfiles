# Install Neovim
local os=$(detect_os)

case $os in
    "macos")
        if ! command -v nvim >/dev/null 2>&1; then
            echo "Installing Neovim via Homebrew..."
            brew install neovim
            
            if command -v nvim >/dev/null 2>&1; then
                echo "Neovim installed successfully!"
                echo "You can start Neovim with 'nvim'"
            else
                echo "Failed to install Neovim"
                return 1
            fi
        else
            echo "Neovim is already installed"
        fi
        ;;
    "ubuntu"|"linux")
        if ! command -v nvim >/dev/null 2>&1; then
            echo "Installing Neovim for Linux..."
            
            # Create local directory if it doesn't exist
            mkdir -p "$HOME/.local/bin"
            
            # Download the latest Neovim release
            echo "Downloading Neovim..."
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
            
            # Remove existing installation if any
            rm -rf "$HOME/.local/nvim-linux-x86_64"
            
            # Extract to user directory
            echo "Extracting Neovim..."
            tar -C "$HOME/.local" -xzf nvim-linux-x86_64.tar.gz
            
            # Create symlink to make nvim available in PATH
            ln -sf "$HOME/.local/nvim-linux-x86_64/bin/nvim" "$HOME/.local/bin/nvim"
            
            # Clean up downloaded archive
            rm nvim-linux-x86_64.tar.gz
            
            # Check if ~/.local/bin is in PATH and add it if needed
            if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
                echo "Adding $HOME/.local/bin to PATH..."
                export PATH="$HOME/.local/bin:$PATH"
                echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
            fi
            
            if command -v nvim >/dev/null 2>&1; then
                echo "Neovim installed successfully!"
                echo "You can start Neovim with 'nvim'"
                nvim --version | head -n 1
            else
                echo "Failed to install Neovim. Please check if $HOME/.local/bin is in your PATH"
                return 1
            fi
        else
            echo "Neovim is already installed"
            nvim --version | head -n 1
        fi
        ;;
    *)
        echo "Unsupported OS for Neovim installation: $os"
        return 1
        ;;
esac 