#!/bin/sh
echo "[5] configure time"
ln -sf /usr/share/zoneinfo/America/Lima /etc/localtime

hwclock --systohc
locale-gen

echo "[6] localization"

echo "es_PE.UTF-8 UTF-8">>/etc/locale.gen
echo "en_US.UTF-8 UTF-8">>/etc/locale.gen

echo "LANG=en_US.UTF-8">>/etc/locale.conf

echo "[7] keybard config"

echo "KEYMAP=la-latin1">>/etc/vconsole.conf

echo "[7] network config"
echo "archsito" >> /etc/hostname





