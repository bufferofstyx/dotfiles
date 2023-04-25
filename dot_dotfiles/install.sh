#!/bin/sh

if [ -z "$USER" ]; then
    USER=$(id -un)
fi

funcion create_directory_if_not_exists {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Directory $1 created."
    else
        echo "Directory $1 already exists."
    fi
}

echo ""
echo "====================================================================="
echo " Setting up codespaces environment"
echo ""
echo " USER        $USER"
echo " HOME        $HOME"
echo "====================================================================="

cd $HOME

create_directory_if_not_exists "$HOME/bin"

# Make passwordless sudo work
export SUDO_ASKPASS=/bin/true

# Istall fzf
FZF_VERSION=0.39.0
curl -L https://github.com/junegunn/fzf/releases/download/${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz | tar xzC $HOME/bin

# Install neovim
NVIM_VERSION=0.9.0
sudo apt-get install -y libfuse2
curl -L -o $HOME/bin/nvim https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim.appimage
chmod a+x $HOME/bin/nvim
