#!/bin/sh
set -eu

DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)
CONFIG_DIR="$DOTFILES_DIR/configs"
BACKUP_SUFFIX="backup.$(date +%Y%m%d%H%M%S)"

link_config() {
    src="$1"
    dst="$2"

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -e "$dst" ]; then
        mv "$dst" "$dst.$BACKUP_SUFFIX"
    fi

    ln -s "$src" "$dst"
}

link_config "$CONFIG_DIR/.bashrc" "$HOME/.bashrc"
link_config "$CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc"
link_config "$CONFIG_DIR/.tmux.conf" "$HOME/.tmux.conf"
link_config "$CONFIG_DIR/nvim" "$HOME/.config/nvim"
link_config "$DOTFILES_DIR/private/.aws.config" "$HOME/.aws/config"
link_config "$DOTFILES_DIR/private/rclone.conf" "$HOME/.config/rclone/rclone.conf"
link_config "$DOTFILES_DIR/private/megfile.conf" "$HOME/.config/megfile/megfile.conf"
