#!/usr/bin/env zsh

echo "Installing ruff..."

# Install ruff using uv tool install
if command -v uv &> /dev/null; then
    echo "Using uv to install ruff..."
    uv tool install ruff
else
    echo "uv not found. Please install uv first."
    exit 1
fi

# Verify installation
if command -v ruff &> /dev/null; then
    echo "ruff installed successfully!"
    ruff --version
else
    echo "Failed to install ruff"
    exit 1
fi