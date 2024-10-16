#!/bin/bash

# Author: SeriousHoax
# GitHub: https://github.com/SeriousHoax

# https://wiki.archlinux.org/title/Zram

# https://github.com/systemd/zram-generator

# Install zram-generator
sudo zypper --non-interactive in zram-generator

# Create configuration file for zram
echo '[zram0]
zram-size = ram
compression-algorithm = zstd' | sudo tee /etc/systemd/zram-generator.conf

# Create sysctl configuration for additional swapping optimizations
echo 'vm.swappiness = 180
vm.watermark_boost_factor = 0
vm.watermark_scale_factor = 125
vm.page-cluster = 0' | sudo tee /etc/sysctl.d/99-vm-zram-parameters.conf

# Reload systemd daemon and start zram
sudo systemctl daemon-reload

# Start the zram service
sudo systemctl start systemd-zram-setup@zram0.service

# Check if the zram device is working
echo "check with"
echo "sudo swapon or sudo zramctl"
echo "or sudo systemctl status systemd-zram-setup@zram0.service"
echo "Reboot the system for additional swapping optimizations to take effect"
