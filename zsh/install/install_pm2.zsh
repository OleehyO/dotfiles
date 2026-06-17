#!/usr/bin/env zsh

# Install pm2 globally via npm.

if ! command -v npm >/dev/null 2>&1; then
    echo "npm is not installed. Please run the Node.js installation step first."
    return 1
fi

if command -v pm2 >/dev/null 2>&1; then
    echo "pm2 is already installed: $(pm2 --version 2>/dev/null)"
    return 0
fi

echo "Installing pm2 via npm..."
npm install -g pm2

if [[ $? -ne 0 ]]; then
    echo "pm2 installation failed"
    return 1
fi

if command -v pm2 >/dev/null 2>&1; then
    echo "pm2 installed successfully: $(pm2 --version 2>/dev/null)"
    return 0
fi

echo "pm2 installation completed, but the pm2 executable was not found"
return 1
