#!/bin/bash
bash_config_file="$(pwd)/bash/config.sh"

if [ -f ~/.bashrc ]; then
    echo "source $bash_config_file" >> ~/.bashrc
    echo "bashConfig file linked to .bashrc"
else
    echo "Error: .bashrc file not found"
fi

source ~/.bashrc


