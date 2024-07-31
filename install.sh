#!/bin/bash

# COLORS
GREEN='\033[32m'
RESET='\033[0m'
RED='\e[31m'

ECHO_RED() {
    echo -e "${RED}$1${RESET}"
}

ECHO_GREEN() {
    echo -e "${GREEN}$1${RESET}"
}

DOWNLOAD_FILE() {
    echo "Downloading $2 from $1"
    if curl -L $1 -o $2; then
        ECHO_GREEN "File downloaded: $2"
    else
        ECHO_RED "Error downloading: $2"
        exit 1
    fi
}

INSTALL_APT_PACKAGE() {
    echo "Install: $1"
    if sudo apt-get install -y $1; then
        ECHO_GREEN "Installed: $1"
    else
        ECHO_RED "Error installing $1."
        exit 1
    fi
}

INSTALL_DEB_PACKAGE() {
    echo "Install: $1"
    if sudo dpkg -i $1; then
        ECHO_GREEN "Installed: $1"
    else
        ECHO_RED "Error installing $1."
        exit 1
    fi
}



echo "INSTALL PACKAGES --------------------------------------------------------"

# Update and upgrade
sudo apt-get update && sudo apt-get upgrade -y || { ECHO_RED "apt-get update/upgrade failed. Exiting."; exit 1; }

# INSTALL PACKAGES USING apt-get
APT_PACKAGES="apt"

if [ -f "$APT_PACKAGES" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        INSTALL_APT_PACKAGE $line
    done < $APT_PACKAGES
else
    ECHO_RED "APT packages file not found. Exiting."
    exit 1
fi


echo "CREATE DIRECTORIES --------------------------------------------------------"

DIRECTORIES="directories"

if [ -f "$DIRECTORIES" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        if [ -n "$line" ]; then
                mkdir -p -v "$line"
        fi
    done < "$DIRECTORIES"
else
    ECHO_RED "Directories file not found. Exiting."
    exit 1
fi

# Check dependencies
command -v curl >/dev/null 2>&1 || { ECHO_RED "curl is required but not installed. Exiting."; exit 1; }
command -v grep >/dev/null 2>&1 || { ECHO_RED "grep is required but not installed. Exiting."; exit 1; }
command -v sed >/dev/null 2>&1 || { ECHO_RED "sed is required but not installed. Exiting."; exit 1; }

# INSTALL PACKAGES FROM GITHUB
GITHUB_PACKAGES="github"

if [ -f "$GITHUB_PACKAGES" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
        releases_url="https://api.github.com/repos/$line/releases"
        #resp=curl -s -L https://api.github.com/repos/Peltoche/lsd/releases | jq '[.[0].assets[] | select(.name | contains("amd64.deb")) | .browser_download_url] | .[0]'
        file_info="$(curl -s -L $releases_url | grep "amd64.deb" | head -n 2)"
        file_url="$(echo $file_info | grep -o 'https://.*\.deb')"
        file_name="$(basename $file_url)"
        DOWNLOAD_FILE $file_url $file_name
        INSTALL_DEB_PACKAGE $file_name
        rm -v $file_name
    done < $GITHUB_PACKAGES
else
    ECHO_RED "GitHub packages file not found. Exiting."
    exit 1
fi

echo "LINK FILES CONFIG --------------------------------------------------------"

# LINK BASH CONFIG TO .bashrc
bash_config_file="$(pwd)/bash/bashConfig"

if [ -f ~/.bashrc ]; then
    echo "source $bash_config_file" >> ~/.bashrc
    ECHO_GREEN "bashConfig file linked to .bashrc"
else
    ECHO_RED "Error: .bashrc file not found"
fi

source ~/.bashrc

go_site="https://go.dev/dl/"

go_file=$(curl $go_site | html2text | grep -o 'go.*\.gz' | grep "linux" )

DOWNLOAD_FILE "$go_site$go_file" $go_file

if [ -f "$go_file" ]; then
    sudo rm -rf /usr/local/go
    sudo tar -xzf "$go_file" -C /usr/local
    rm -v "$go_file"
else
    ECHO_RED "The file $go_file does not exist."
fi

# Verify Golang installation
if command -v go &>/dev/null && [[ "$(go version)" == *"go"* ]]; then
    ECHO_GREEN "Golang was installed successfully in version $(go version)"
else
    ECHO_RED "Error: Golang installation failed"
fi


echo "INSTALL NODEJS ----------------------------------------------------------"

node_site="https://nodejs.org/dist/latest-v20.x/"
node_file=$(curl -L $node_site | html2text | grep 'linux' | grep -v 'arm' | grep -o 'node.*\x64..xz')
DOWNLOAD_FILE "$node_site$node_file" $node_file

if [ -f "$node_file" ]; then
     -xf "$node_file"
    mv -v $(basename $node_file "..xz") "node"
    mv -v node/ ~/
    rm -v $node_file
fi

echo "INSTALL RUST ---------------------------------------------------------"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "INSTALL RUST-ANALYZER ------------------------------------------------"
rustup component add rust-analyzer

echo "INSTALL VSCODE--------------------------------------------------------"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code -y

echo "INSTALL KITTY TERMINAL-----------------------------------------------"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s "$(pwd)/kitty.conf" ~/.config/kitty/kitty.conf 


echo "INSTALL FONTS--------------------------------------------------------"
mkdir -v ~/.fonts
cp ./fonts/* ~/.fonts/
sudo fc-cache -f -v

# Print completion message
ECHO_GREEN "Installation complete!"
echo "Please rest your terminal to apply the changes."
