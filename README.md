# AnythingLinux
A place for linux related useful items

## Enable [Zram](https://wiki.archlinux.org/title/Zram)

The commands below will download the installation script from the repository to your home directory, install the required tools, optimize swapping parameters to recommended values, and enable Zram on your device.

### [Arch Linux](https://archlinux.org)
```
curl -o ~/Zram-install-Arch.sh https://raw.githubusercontent.com/SeriousHoax/AnythingLinux/refs/heads/master/Zram-install-Arch.sh && chmod +x ~/Zram-install-Arch.sh && ~/Zram-install-Arch.sh && rm ~/Zram-install-Arch.sh
```

### [Ubuntu](https://ubuntu.com/)
```
curl -o ~/Zram-install-Ubuntu.sh https://raw.githubusercontent.com/SeriousHoax/AnythingLinux/refs/heads/master/Zram-install-Ubuntu.sh && chmod +x ~/Zram-install-Ubuntu.sh && ~/Zram-install-openSUSE.sh && rm ~/Zram-install-Ubuntu.sh
```

### [openSUSE Tumbleweed](https://www.opensuse.org)
```
curl -o ~/Zram-install-openSUSE.sh https://raw.githubusercontent.com/SeriousHoax/AnythingLinux/refs/heads/master/Zram-install-openSUSE.sh && chmod +x ~/Zram-install-openSUSE.sh && ~/Zram-install-openSUSE.sh && rm ~/Zram-install-openSUSE.sh
```

---

## Sign Arch systemd-bootloader using [sbctl](https://github.com/Foxboron/sbctl) for SecureBoot support

To sign systemd-boot for distributions other than Arch, modify step 2 according to the information provided on sbctl's GitHub. The systemd-boot configuration file is located at `/boot/loader/loader.conf`

1. First of all enable `secure boot` in your BIOS and set it to `setup mode`

2. Install sbctl:
```
sudo pacman -S sbctl
```

3. Get root privilege:
```
sudo -i
```

4. Check if Setup Mode is enabled:
```
sbctl status
```

5. Create keys:
```
sbctl create-keys
```

6. Enroll Microsoft keys:
```
sbctl enroll-keys -m
```

7. Verify if vendor keys have successfully been enrolled:
```
sbctl status
```

8. Sign systemd EFI:
```
sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
```

9. Sign all required files automatically:
```
sbctl verify | sed -E 's|^.* (/.+) is not signed$|sbctl sign -s "\1"|e'
```

10. Verify if all required files have been signed:
```
sbctl verify
```

11. Reinstall Bootloader:
```
bootctl install
```

---

## Enable [syntax highlighting](https://en.wikipedia.org/wiki/Syntax_highlighting) for [nano](https://www.nano-editor.org)
Copy and paste the code into your Terminal. It will download the `nano-syntax-highlighting.sh` script from this repository to your home directory, download all the required files from [nano-syntax-highlighting](https://github.com/galenguyer/nano-syntax-highlighting) and configure them on your system.

```
curl -o ~/nano-syntax-highlighting.sh https://raw.githubusercontent.com/SeriousHoax/AnythingLinux/refs/heads/master/nano-syntax-highlighting.sh && chmod +x ~/nano-syntax-highlighting.sh && ~/nano-syntax-highlighting.sh && rm ~/nano-syntax-highlighting.sh
```