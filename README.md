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

## Sign Arch systemd-bootloader using [sbctl](https://github.com/Foxboron/sbctl) for SecureBoot support
1. First of all enable ```secure boot``` in your BIOS and set it to ```setup mode```

2. Install sbctl, 
```
sudo pacman -S sbctl
```
3. Get root privilage, 
```
sudo -i
```
4. Check if Setup Mode is enabled, 
```
sbctl status
```
5. Create keys, 
```
sbctl create-keys
```
6. Enroll Microsoft keys,
```
sbctl enroll-keys -m
```
7. Verify if vendor keys have successfully been enrolled, 
```
sbctl status
```
8. Sign systemd EFI,
```
sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
```
09. Sign all required files automatically,
```
sbctl verify | sed 's/✗ /sbctl sign -s /e'
```
10. Verify if all required files has been signed,
```
sbctl verify
```
11. Reinstall Bootloader,
```
bootctl install
```
To sign systemd-boot for distributions other than Arch, modify step 2 according to the information provided on sbctl's GitHub.

The systemd-boot configuration file is located at, ```/boot/loader/loader.conf```