# ref: https://github.com/eza-community/eza/blob/main/INSTALL.md
# Install eza via cargo
if ! command -v cargo >/dev/null 2>&1; then
    echo "Cargo is not installed. Please install cargo first."
    return 1
fi

if ! command -v eza >/dev/null 2>&1; then
    echo "Installing eza via cargo..."
    cargo install eza
    # 安装成功后将eza添加到PATH（如果安装在~/.cargo/bin）
    export PATH="$HOME/.cargo/bin:$PATH"
else
    echo "eza is already installed"
    return 0
fi 