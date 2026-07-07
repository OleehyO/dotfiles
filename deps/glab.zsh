#!/usr/bin/env zsh

# Install GitLab CLI: https://docs.gitlab.com/cli/

export PATH="$HOME/.local/bin:$PATH"

if command -v glab >/dev/null 2>&1; then
    echo "glab is already installed: $(glab --version)"
    return 0
fi

install_glab_linux() {
    local machine arch
    machine="$(uname -m)"

    case "$machine" in
        x86_64|amd64)
            arch="amd64"
            ;;
        arm64|aarch64)
            arch="arm64"
            ;;
        *)
            echo "Unsupported Linux architecture for glab: $machine"
            return 1
            ;;
    esac

    for dep in curl grep sed sha256sum tar; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            echo "$dep is required to install glab"
            return 1
        fi
    done

    local install_bin
    install_bin="$(whence -p install)"
    if [[ -z "$install_bin" ]]; then
        echo "install is required to install glab"
        return 1
    fi

    local api_url release_json version archive asset_url checksums_url
    api_url="https://gitlab.com/api/v4/projects/gitlab-org%2Fcli/releases/permalink/latest"

    echo "Resolving latest glab release..."
    release_json="$(curl -fsSL "$api_url")" || return 1
    version="$(printf '%s' "$release_json" | sed -n 's/.*"tag_name":"v\([^"]*\)".*/\1/p' | head -n 1)"

    if [[ -z "$version" ]]; then
        echo "Failed to resolve the latest glab version"
        return 1
    fi

    archive="glab_${version}_linux_${arch}.tar.gz"
    asset_url="https://gitlab.com/gitlab-org/cli/-/releases/v${version}/downloads/${archive}"
    checksums_url="https://gitlab.com/gitlab-org/cli/-/releases/v${version}/downloads/checksums.txt"

    local tmpdir
    tmpdir="$(mktemp -d)" || return 1

    echo "Downloading glab ${version} for linux_${arch}..."
    curl -fsSLo "$tmpdir/$archive" "$asset_url" || {
        rm -rf "$tmpdir"
        return 1
    }

    curl -fsSLo "$tmpdir/checksums.txt" "$checksums_url" || {
        rm -rf "$tmpdir"
        return 1
    }

    local checksum_line
    checksum_line="$(grep -F "$archive" "$tmpdir/checksums.txt" | head -n 1)"
    if [[ -z "$checksum_line" ]]; then
        echo "Failed to find checksum for $archive"
        rm -rf "$tmpdir"
        return 1
    fi

    (
        cd "$tmpdir" || exit 1
        printf '%s\n' "$checksum_line" | sha256sum -c -
    ) || {
        rm -rf "$tmpdir"
        return 1
    }

    tar -xzf "$tmpdir/$archive" -C "$tmpdir" || {
        rm -rf "$tmpdir"
        return 1
    }

    mkdir -p "$HOME/.local/bin"
    "$install_bin" -m 0755 "$tmpdir/bin/glab" "$HOME/.local/bin/glab" || {
        rm -rf "$tmpdir"
        return 1
    }

    rm -rf "$tmpdir"
}

install_glab_macos() {
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew is required to install glab on macOS"
        return 1
    fi

    echo "Installing glab via Homebrew..."
    brew install glab
}

local os
os="$(detect_os)"

case "$os" in
    "macos")
        install_glab_macos || return 1
        ;;
    "ubuntu"|"linux")
        install_glab_linux || return 1
        ;;
    *)
        echo "Unsupported OS for glab installation: $os"
        return 1
        ;;
esac

if command -v glab >/dev/null 2>&1; then
    echo "glab installed successfully: $(glab --version)"
    echo "Run 'glab auth login' before using GitLab API commands."
    return 0
fi

echo "glab installation completed, but the glab executable was not found"
return 1
