#!/bin/bash
#
echo "INSTALL KITTY TERMINAL-----------------------------------------------"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s "$(pwd)/kitty.conf" ~/.config/kitty/kitty.conf 

