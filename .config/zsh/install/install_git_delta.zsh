# Install git-delta via cargo
if ! command -v cargo >/dev/null 2>&1; then
    echo "Cargo is not installed. Please install cargo first."
    return 1
fi

if ! command -v git >/dev/null 2>&1; then
    echo "Git is not installed. Please install Git first."
    return 1
fi

if ! command -v delta >/dev/null 2>&1; then
    echo "Installing git-delta via cargo..."
    cargo install git-delta || {
        echo "Error: git-delta installation failed"
        return 1
    }

    export PATH="$HOME/.cargo/bin:$PATH"
fi

if ! command -v delta >/dev/null 2>&1; then
    echo "Error: git-delta is not available after installation"
    return 1
fi

echo "git-delta is available: $(delta --version)"
git config --global core.pager delta
git config --global delta.line-numbers true
git config --global delta.navigate true
git config --global delta.pager 'less -R'
git config --global delta.side-by-side false

echo "Configured git to use delta with line numbers, navigation, and pager enabled"
