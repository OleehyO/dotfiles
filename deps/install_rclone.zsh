# Install rclone: https://rclone.org/install/
if ! command -v rclone >/dev/null 2>&1; then
    echo "Installing rclone..."
    sudo -v ; curl https://rclone.org/install.sh | sudo bash
else
    echo "rclone is already installed"
    return 0
fi
