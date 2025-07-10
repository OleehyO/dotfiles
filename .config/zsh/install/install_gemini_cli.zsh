#!/bin/zsh

# Install @google/gemini-cli: https://github.com/google/gemini-cli

# First, check if npm is installed, as it's required.
if ! command -v npm >/dev/null 2>&1; then
    echo "Error: npm is not installed. Please install Node.js and npm first."
    echo "Visit https://nodejs.org/ for installation instructions."
    return 1 # Use 'exit 1' if you run this as a standalone file e.g., ./install_gemini.sh
fi

# Now, check if the gemini command is already installed.
if ! command -v gemini >/dev/null 2>&1; then
    echo "Installing @google/gemini-cli via npm..."
    # The -g flag installs the package globally.
    npm install -g @google/gemini-cli
else
    echo "@google/gemini-cli is already installed."
    return 0
    # Optional: You could add a command here to check the version.
    # echo "Current version: $(gemini --version)"
fi