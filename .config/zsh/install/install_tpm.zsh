# Install TPM (Tmux Plugin Manager)
local tpm_dir="$HOME/.tmux/plugins/tpm"

if [[ ! -d "$tpm_dir" ]]; then
    echo "Installing TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    echo "TPM installed successfully!"
    echo "Add the following line to your ~/.tmux.conf:"
    echo "run '~/.tmux/plugins/tpm/tpm'"
    echo "Then press prefix + I in tmux to install plugins"
else
    echo "TPM is already installed"
fi 