#!/usr/bin/env zsh

# Install zsh without changing the user's default login shell.
local os=$(detect_os)

if command -v zsh >/dev/null 2>&1; then
    echo "zsh is already installed: $(zsh --version)"
    return 0
fi

case $os in
    "macos")
        echo "Installing zsh via Homebrew..."
        brew install zsh
        ;;
    "ubuntu")
        echo "Installing zsh via APT..."
        sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
            -o 'Dpkg::Options::=--force-confdef' \
            -o 'Dpkg::Options::=--force-confold' \
            zsh
        ;;
    *)
        echo "Unsupported OS for zsh installation: $os"
        return 1
        ;;
esac

if command -v zsh >/dev/null 2>&1; then
    echo "zsh installed successfully: $(zsh --version)"
    echo "Default shell was not changed."
    return 0
fi

echo "Failed to install zsh"
return 1
