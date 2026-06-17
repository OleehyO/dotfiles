# Install or upgrade Git
# Ensures Git version >= 2.29 (required by git-branchless)
local os=$(detect_os)

# Check if git is installed
if ! command -v git >/dev/null 2>&1; then
    echo "Git is not installed. Installing..."
    case $os in
        "macos")
            brew install git
            ;;
        "ubuntu")
            sudo apt install -y git
            ;;
        *)
            echo "Unsupported OS for Git installation: $os"
            return 1
            ;;
    esac
fi

# Check Git version
local git_version=$(git --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
local major=$(echo $git_version | cut -d. -f1)
local minor=$(echo $git_version | cut -d. -f2)

echo "Current Git version: $git_version"

# Check if version >= 2.29
if [ "$major" -lt 2 ] || ([ "$major" -eq 2 ] && [ "$minor" -lt 29 ]); then
    echo "Git version $git_version is older than 2.29. Upgrading..."

    case $os in
        "macos")
            echo "Upgrading Git via Homebrew..."
            brew upgrade git
            ;;
        "ubuntu")
            echo "Upgrading Git via APT..."
            sudo apt update
            sudo apt install -y git
            ;;
        *)
            echo "Unsupported OS for Git upgrade: $os"
            return 1
            ;;
    esac

    # Verify upgrade
    local new_version=$(git --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    echo "Git upgraded to version: $new_version"
else
    echo "Git version $git_version meets requirements (>= 2.29)"
fi
