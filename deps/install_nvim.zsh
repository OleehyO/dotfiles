# Install Neovim
local os=$(detect_os)

# Function to compare version numbers
compare_version() {
    local version1=$1
    local version2=$2
    
    # Remove 'v' prefix and split version numbers
    version1=$(echo "$version1" | sed 's/^v//')
    version2=$(echo "$version2" | sed 's/^v//')
    
    # Use sort -V to compare versions
    local higher=$(printf '%s\n%s\n' "$version1" "$version2" | sort -V | tail -n1)
    
    if [[ "$higher" == "$version1" ]]; then
        return 0  # version1 >= version2
    else
        return 1  # version1 < version2
    fi
}

# Function to check nvim version requirement
check_nvim_version() {
    local current_version=$(nvim --version | head -n 1 | awk '{print $2}')
    local required_version="0.11.0"
    
    if compare_version "$current_version" "$required_version"; then
        echo "Neovim version $current_version meets requirement (>= $required_version)"
        return 0
    else
        echo "ERROR: Neovim version $current_version is too old (requires >= $required_version)"
        echo "Please uninstall the current version of Neovim and run this script again to install the latest version."
        return 1
    fi
}

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
            if ! check_nvim_version; then
                return 1
            fi
            return 0
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
            if ! check_nvim_version; then
                return 1
            fi
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for Neovim installation: $os"
        return 1
        ;;
esac 