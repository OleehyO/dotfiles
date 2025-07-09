echo "Starting initial setup for $(detect_os)..."

# 首先更新包管理器
update

# 安装各个工具
local install_dir="$HOME/dotfile/.config/zsh/install"

if [[ -f "$install_dir/install_ohmyzsh.zsh" ]]; then
    echo "Installing Oh My Zsh..."
    source "$install_dir/install_ohmyzsh.zsh"
fi

if [[ -f "$install_dir/install_tzdata.zsh" ]]; then
    echo "Installing tzdata and setting timezone..."
    source "$install_dir/install_tzdata.zsh"
fi

if [[ -f "$install_dir/install_tmux.zsh" ]]; then
    echo "Installing tmux..."
    source "$install_dir/install_tmux.zsh"
fi

if [[ -f "$install_dir/install_eza.zsh" ]]; then
    echo "Installing eza..."
    source "$install_dir/install_eza.zsh"
fi

if [[ -f "$install_dir/install_bat.zsh" ]]; then
    echo "Installing bat..."
    source "$install_dir/install_bat.zsh"
fi

if [[ -f "$install_dir/install_z.zsh" ]]; then
    echo "Installing z..."
    source "$install_dir/install_z.zsh"
fi

if [[ -f "$install_dir/install_tldr.zsh" ]]; then
    echo "Installing tldr..."
    source "$install_dir/install_tldr.zsh"
fi

if [[ -f "$install_dir/install_fzf.zsh" ]]; then
    echo "Installing fzf..."
    source "$install_dir/install_fzf.zsh"
fi

if [[ -f "$install_dir/install_ripgrep.zsh" ]]; then
    echo "Installing ripgrep..."
    source "$install_dir/install_ripgrep.zsh"
fi

if [[ -f "$install_dir/install_fd.zsh" ]]; then
    echo "Installing fd..."
    source "$install_dir/install_fd.zsh"
fi

if [[ -f "$install_dir/install_nvim.zsh" ]]; then
    echo "Installing Neovim..."
    source "$install_dir/install_nvim.zsh"
fi

if [[ -f "$install_dir/install_tpm.zsh" ]]; then
    echo "Installing tpm..."
    source "$install_dir/install_tpm.zsh"
fi

if [[ -f "$install_dir/install_uv.zsh" ]]; then
    echo "Installing uv..."
    source "$install_dir/install_uv.zsh"
fi

if [[ -f "$install_dir/install_zip.zsh" ]]; then
    echo "Installing zip..."
    source "$install_dir/install_zip.zsh"
fi

if [[ -f "$install_dir/install_node.zsh" ]]; then
    echo "Installing Node.js..."
    source "$install_dir/install_node.zsh"
fi

echo "Initial setup completed!"
echo "Please restart your shell or run 'source ~/.zshrc' to apply changes."