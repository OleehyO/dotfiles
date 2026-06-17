#!/bin/sh
set -eu

PRIVATE_DIR=$(cd "$(dirname "$0")" && pwd)

link_private_file() {
    src="$1"
    dst="$2"

    mkdir -p "$(dirname "$dst")"
    rm -f "$dst"
    ln -s "$src" "$dst"
}

link_private_file "$PRIVATE_DIR/rclone.conf" "$HOME/.config/rclone/rclone.conf"
link_private_file "$PRIVATE_DIR/.aws.config" "$HOME/.aws/config"
link_private_file "$PRIVATE_DIR/megfile.conf" "$HOME/.config/megfile/megfile.conf"
