# AnythingLinux
A place for linux related useful items
## Enabling Zram on openSUSE
Copy the code below and paste it into your Terminal. It will download the `Zram-install-openSUSE.sh` script from the repository to your `home` directory, install the required tool for configuration, optimize the swapping parameters to the recommended values, and enable it on your device
```
curl -o ~/Zram-install-openSUSE.sh https://raw.githubusercontent.com/SeriousHoax/AnythingLinux/refs/heads/main/Zram-install-openSUSE.sh && chmod +x ~/Zram-install-openSUSE.sh && ~/Zram-install-openSUSE.sh
```
## Enabling Zram on Arch Linux
Same as above except this will use the `Zram-install-Arch.sh` script
```
curl -o ~/Zram-install-Arch.sh https://raw.githubusercontent.com/SeriousHoax/AnythingLinux/refs/heads/main/Zram-install-Arch.sh && chmod +x ~/Zram-install-Arch.sh && ~/Zram-install-Arch.sh
```
