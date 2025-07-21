#!/bin/zsh
# Install @anthropic-ai/claude-code: https://github.com/anthropics/claude-code

# First, check if npm is installed, as it's required.
if ! command -v npm >/dev/null 2>&1; then
    echo "Error: npm is not installed. Please install Node.js and npm first."
    echo "Visit https://nodejs.org/ for installation instructions."
    return 1 # Use 'exit 1' if you run this as a standalone file e.g., ./install_claude.sh
fi

# Now, check if the claude command is already installed.
if ! command -v claude >/dev/null 2>&1; then
    echo "Installing @anthropic-ai/claude-code via npm..."
    # The -g flag installs the package globally.
    npm install -g @anthropic-ai/claude-code
else
    echo "@anthropic-ai/claude-code is already installed."
    return 0
    # Optional: You could add a command here to check the version.
    # echo "Current version: $(claude --version)"
fi