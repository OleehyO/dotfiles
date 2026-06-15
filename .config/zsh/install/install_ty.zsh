#!/usr/bin/env zsh

echo "Installing ty..."

# Install ty using uv tool install
if command -v uv &> /dev/null; then
    echo "Using uv to install ty..."
    uv tool install ty
else
    echo "uv not found. Please install uv first."
    return 1
fi

# Verify installation
if command -v ty &> /dev/null; then
    echo "ty installed successfully!"
    ty --version
    return 0
else
    echo "Failed to install ty"
    return 1
fi
