# https://rustup.rs/
# Install Rust and Cargo
local os=$(detect_os)

if command -v cargo >/dev/null 2>&1; then
    echo "Cargo is already installed ($(cargo --version))"
    return 0
fi

case $os in
    "macos"|"ubuntu")
        echo "Installing Rust and Cargo via rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

        # Source cargo environment
        if [ -f "$HOME/.cargo/env" ]; then
            source "$HOME/.cargo/env"
        fi

        if command -v cargo >/dev/null 2>&1; then
            echo "Cargo installed successfully: $(cargo --version)"
        else
            echo "Error: Cargo installation failed"
            return 1
        fi
        ;;
    *)
        echo "Unsupported OS for Cargo installation: $os"
        return 1
        ;;
esac
