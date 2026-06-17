# Install tzdata and set timezone
local os=$(detect_os)

case $os in
    "ubuntu")
        # Install tzdata package
        if ! dpkg -l | grep -q tzdata; then
            echo "Installing tzdata via APT..."
            sudo apt install -y tzdata
        else
            echo "tzdata is already installed"
            return 0
        fi
        
        # Set timezone to Asia/Shanghai
        echo "Setting timezone to Asia/Shanghai..."
        sudo timedatectl set-timezone Asia/Shanghai
        
        # Verify the timezone setting
        echo "Current timezone: $(timedatectl show --property=Timezone --value)"
        ;;
    *)
        echo "tzdata installation is only supported for Ubuntu"
        return 0
        ;;
esac 