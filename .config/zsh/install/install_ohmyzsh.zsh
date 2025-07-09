# --- Oh My Zsh Installation ---
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Installing Oh My Zsh..."
    # Use non-interactive installation
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo "Oh My Zsh installed successfully!"
        echo "Note: You may want to:"
        echo "1. Set ZSH_THEME in your ~/.zshrc"
        echo "2. Configure plugins in your ~/.zshrc"
        echo "3. Restart your shell or run 'source ~/.zshrc'"
    else
        echo "Failed to install Oh My Zsh"
        return 1
    fi
else
    echo "Oh My Zsh is already installed"
fi

# --- fzf-tab Plugin Installation ---
# This part runs regardless of whether Oh My Zsh was just installed or already existed.
FZF_TAB_PATH="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab"

if [[ ! -d "$FZF_TAB_PATH" ]]; then
    echo "Installing fzf-tab plugin..."
    git clone https://github.com/Aloxaf/fzf-tab "$FZF_TAB_PATH"
    echo "fzf-tab plugin installed successfully! Please add 'fzf-tab' to the plugins list in your ~/.zshrc"
else
    echo "fzf-tab plugin is already installed"
fi

# --- zsh-vi-mode Plugin Installation ---
ZSH_VI_MODE_PATH="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode"

if [[ ! -d "$ZSH_VI_MODE_PATH" ]]; then
    echo "Installing zsh-vi-mode plugin..."
    git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_VI_MODE_PATH"
    echo "zsh-vi-mode plugin installed successfully! Please add 'zsh-vi-mode' to the plugins list in your ~/.zshrc"
else
    echo "zsh-vi-mode plugin is already installed"
fi
