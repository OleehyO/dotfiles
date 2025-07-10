# Install fzf: https://github.com/junegunn/fzf
local os=$(detect_os)

# Function to check fzf version
check_fzf_version() {
    local required_version="0.64.0"
    local current_version=$(fzf --version | head -n1 | cut -d' ' -f1)
    
    if [[ -z "$current_version" ]]; then
        echo "fzf version could not be determined"
        return 1
    fi
    
    # Compare versions using sort -V (version sort)
    # Check if current version is less than required version
    if printf '%s\n' "$current_version" "$required_version" | sort -V | head -n1 | grep -q "$current_version"; then
        if [[ "$current_version" != "$required_version" ]]; then
            echo "fzf version $current_version is < $required_version, needs reinstall"
            return 1
        fi
    fi
    
    echo "fzf version $current_version is >= $required_version"
    return 0
}

# Function to install/reinstall fzf
install_fzf() {
    echo "Installing fzf via git..."
    # Remove existing installation if it exists
    if [[ -d ~/.fzf ]]; then
        rm -rf ~/.fzf
    fi
    
    # Check if fzf is installed via Homebrew and remove it
    if command -v brew >/dev/null 2>&1 && brew list fzf >/dev/null 2>&1; then
        echo "Removing fzf installed via Homebrew..."
        brew uninstall fzf
    fi
    
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
}

case $os in
    "macos")
        if ! command -v fzf >/dev/null 2>&1; then
            install_fzf
        elif ! check_fzf_version; then
            echo "Reinstalling fzf due to version requirement..."
            install_fzf
        else
            echo "fzf is already installed with compatible version"
            return 0
        fi
        ;;
    "ubuntu")
        if ! command -v fzf >/dev/null 2>&1; then
            install_fzf
        elif ! check_fzf_version; then
            echo "Reinstalling fzf due to version requirement..."
            install_fzf
        else
            echo "fzf is already installed with compatible version"
            return 0
        fi
        ;;
    *)
        echo "Unsupported OS for fzf installation: $os"
        return 1
        ;;
esac 