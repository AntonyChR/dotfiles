#!/bin/sh

read -p "efi partition: " EFI_PART 
read -p "swap partition: " SWAP_PART 
read -p "root partition: " ROOT_PART


echo "[1] formating partitions"

mkfs.ext4 "$ROOT_PART"

mkswap "$SWAP_PART"

mkfs.fat -F 32 "$EFI_PART"

echo "[2] mount file systems"

mount "$ROOT_PART" /mnt

mkdir -p /mnt/boot/efi

mount "$EFI_PART" /mnt/boot/efi

swapon "$SWAP_PART"

echo "[3] Install essential packages "

pacstrap -K /mnt base linux linux-firmware

echo "Generate fstab"
genfstab -U /mnt >> /mnt/etc/fstab

