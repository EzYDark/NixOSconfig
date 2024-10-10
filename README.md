# Inspirated from:
- https://github.com/wueestry/nixos-config


# How To Setup

## Pre-setup for WSL on Windows
1. Find path to USB disk
```sh
wmic diskdrive list brief
```

2. Mount USB disk to WSL:
```sh
sudo wsl --mount \\.\PHYSICALDRIVE0 --bare
```

## Installing
1. Check and find a disk to install on:
```sh
    lsblk
```

2. Run this command combining Disko installer and Nix installer:
```sh
    sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko#disko-install' -- --flake '/mnt/c/Users/ezy/Desktop/nixos#eznix' --disk main /dev/sdc
```