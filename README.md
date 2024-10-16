# Inspirated from:
- https://github.com/wueestry/nixos-config
- https://github.com/alyraffauf/nixcfg

# How To Setup

- INSTALL AND USE NIXOS IN WSL!

## Pre-setup for WSL (on Windows)
1. Find path to USB disk
```sh
wmic diskdrive list brief
```

2. Mount USB disk to WSL:
```sh
sudo wsl --mount \\.\PHYSICALDRIVE0 --bare
```

## Installing (in WSL)
1. Check and find a disk to install on:
```sh
    lsblk
```

2. Run this command combining Disko installer and Nix installer (check correct flake config folder path and disk path!):
```sh
    sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko#disko-install' -- --flake '/mnt/c/Users/ezy/Desktop/_NixOS#eznix' --disk main /dev/sdc
```

## Make blank snapshot before starting
1. Install Btrfs tools in WSL
```sh
nix-env -iA nixos.btrfs-progs
```

2. Mount the USB disk
```sh
mkdir /mnt/usb
sudo mount /dev/sdc2 /mnt/usb
```

3. Make the blank snapshot
```sh
sudo btrfs subvolume snapshot -r /mnt/usb/@root /mnt/usb/@snapshots/.blank-@root
```




---

# TODO:
- Only able to set one default shell and other tools using session variables.