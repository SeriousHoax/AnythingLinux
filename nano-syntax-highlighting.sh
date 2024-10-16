#!/bin/bash

# Author: SeriousHoax
# GitHub: https://github.com/SeriousHoax

# https://wiki.archlinux.org/title/Nano

# https://github.com/galenguyer/nano-syntax-highlighting

sudo mkdir -p /usr/share/nano-syntax-highlighting && \
echo -e "\e[32mCreated directory /usr/share/nano-syntax-highlighting\e[0m" && \
sudo wget -O /usr/share/nano-syntax-highlighting/nano-syntax-highlighting.zip https://github.com/galenguyer/nano-syntax-highlighting/archive/refs/heads/master.zip && \
echo -e "\e[32mDownloaded nano-syntax-highlighting.zip\e[0m" && \
sudo unzip /usr/share/nano-syntax-highlighting/nano-syntax-highlighting.zip -d /usr/share/nano-syntax-highlighting && \
echo -e "\e[32mUnzipped the files\e[0m" && \
sudo mv /usr/share/nano-syntax-highlighting/nano-syntax-highlighting-master/* /usr/share/nano-syntax-highlighting/ && \
echo -e "\e[32mMoved files to /usr/share/nano-syntax-highlighting\e[0m" && \
sudo rm -r /usr/share/nano-syntax-highlighting/nano-syntax-highlighting-master /usr/share/nano-syntax-highlighting/tool/ /usr/share/nano-syntax-highlighting/nano-syntax-highlighting.zip && \
echo -e "\e[32mDeleted the zip file and unnecessary folders\e[0m" && \
mkdir -p ~/.config/nano && \
echo -e "\e[32mCreated ~/.config/nano directory\e[0m" && \
sudo cp /etc/nanorc ~/.config/nano/nanorc && \
echo -e "\e[32mCopied /etc/nanorc to ~/.config/nano/nanorc\e[0m" && \
echo -e 'include "/usr/share/nano/*.nanorc"\ninclude "/usr/share/nano/extra/*.nanorc"\ninclude "/usr/share/nano-syntax-highlighting/*.nanorc"' | sudo tee -a ~/.config/nano/nanorc > /dev/null && \
echo -e "\e[32mAppended syntax highlighting configuration to ~/.config/nano/nanorc\e[0m" && \
sudo cp ~/.config/nano/nanorc /root/.nanorc && \
echo -e "\e[32mCopied ~/.config/nano/nanorc to /root/.nanorc to make syntax-highlighting work with sudo\e[0m"
