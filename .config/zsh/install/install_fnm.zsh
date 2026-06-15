#!/usr/bin/env zsh

# Install fnm (Fast Node Manager): https://github.com/Schniz/fnm

export PATH="$HOME/.local/bin:$PATH"

if command -v fnm >/dev/null 2>&1; then
    echo "fnm is already installed: $(fnm --version)"
else
    if ! command -v curl >/dev/null 2>&1; then
        echo "curl is not installed. Please install curl first."
        return 1
    fi

    if ! command -v unzip >/dev/null 2>&1; then
        echo "unzip is not installed. Please install unzip first."
        return 1
    fi

    echo "Installing fnm..."
    curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.local/bin" --skip-shell

    if [[ $? -ne 0 ]]; then
        echo "fnm installation failed"
        return 1
    fi
fi

if command -v fnm >/dev/null 2>&1; then
    echo "fnm installed successfully: $(fnm --version)"
    eval "$(fnm env --shell zsh)"

    echo "Installing Node.js 24 with fnm..."
    fnm install 24

    if [[ $? -ne 0 ]]; then
        echo "Node.js 24 installation failed"
        return 1
    fi

    fnm default 24

    if [[ $? -ne 0 ]]; then
        echo "Failed to set Node.js 24 as the default"
        return 1
    fi

    fnm use 24

    if [[ $? -ne 0 ]]; then
        echo "Failed to use Node.js 24"
        return 1
    fi

    echo "Node.js installed successfully: $(node --version)"
    return 0
fi

echo "fnm installation completed, but the fnm executable was not found"
return 1
