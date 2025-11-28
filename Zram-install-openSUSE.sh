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
    fi
done

# Explicitly handle /swap directory cleanup
if [ -d "/swap" ]; then
    # Check if /swap is a mountpoint and unmount it if so
    if mountpoint -q /swap; then
        echo "/swap is a mountpoint. Unmounting..."
        sudo umount /swap 2>/dev/null
        # Remove /swap mount entry from fstab
        sudo sed -i '\|/swap[[:space:]]|d' /etc/fstab
    fi
    # Try to remove the directory
    sudo rm -rf /swap
    
    # Verify removal
    if [ ! -d "/swap" ]; then
        echo "/swap directory removed."
    else
        echo "Note: /swap could not be removed (it might be a Btrfs subvolume or non-empty)."
    fi
fi

# Disable any active swap partitions
for swap_dev in $(swapon --show=NAME --noheadings); do
    if [[ "$swap_dev" == /dev/* ]]; then
        echo "Disabling swap partition $swap_dev..."
        sudo swapoff "$swap_dev"
        sudo sed -i "\|$swap_dev|d" /etc/fstab
    fi
done

# Install zram-generator
sudo zypper --non-interactive in zram-generator || {
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