#!/bin/bash

# Author: SeriousHoax
# GitHub: https://github.com/SeriousHoax

# https://wiki.archlinux.org/title/Zram

# https://github.com/systemd/zram-generator

# Remove existing swapfiles if present
for swap_path in "/swapfile" "/swap/swapfile"; do
    if [ -f "$swap_path" ]; then
        echo "Disabling and removing $swap_path..."
        sudo swapoff "$swap_path" 2>/dev/null
        sudo sed -i "\|$swap_path|d" /etc/fstab
        sudo rm -f "$swap_path"
        echo "$swap_path removed and fstab entry cleaned."

        # If the file was inside /swap, remove the folder too
        if [[ "$swap_path" == "/swap/swapfile" ]]; then
            sudo rmdir --ignore-fail-on-non-empty /swap 2>/dev/null
            echo "/swap directory removed (if empty)."
        fi
    fi
done

# Disable any active swap partitions
for swap_dev in $(swapon --show=NAME --noheadings); do
    if [[ "$swap_dev" == /dev/* ]]; then
        echo "Disabling swap partition $swap_dev..."
        sudo swapoff "$swap_dev"
        sudo sed -i "\|$swap_dev|d" /etc/fstab
    fi
done

# Install zram-generator
sudo pacman -S zram-generator --noconfirm --needed || {
    echo "Failed to install zram-generator. Exiting."
    exit 1
}

# Create configuration file for zram
echo '[zram0]
zram-size = ram
compression-algorithm = zstd' | sudo tee /etc/systemd/zram-generator.conf

# Create sysctl configuration for additional swapping optimizations
echo 'vm.swappiness = 180
vm.watermark_boost_factor = 0
vm.watermark_scale_factor = 125
vm.page-cluster = 0' | sudo tee /etc/sysctl.d/99-vm-zram-parameters.conf

echo "Applying kernel parameters..."
sudo sysctl --system

# Reload systemd daemon and start zram
sudo systemctl daemon-reload

# Start the zram service
sudo systemctl start systemd-zram-setup@zram0.service

# Check if the zram is working
echo "Check ZRAM status with:"
echo "  zramctl"
echo "  swapon --show"
echo "  systemctl status systemd-zram-setup@zram0.service"