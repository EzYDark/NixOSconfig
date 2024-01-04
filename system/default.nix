{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix

    ./configs/disko.nix

    ./configs/gnome.nix
    ./configs/networking.nix
    ./configs/pipewire.nix
    ./configs/zram.nix
  ];
}