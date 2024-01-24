{ pkgs, inputs, ... }:

{
  imports = [
    ./configs/boot.nix
    ./configs/experimental_flake.nix
    ./hardware-configuration.nix
    ./configs/disk_partitions.nix
    ./configuration.nix

    ./configs/users_groups.nix

    ./configs/dev_work

    ./configs/sound_pipewire.nix
    ./configs/zram.nix
    ./configs/power_management.nix
    ./configs/openssh.nix
    ./configs/nix_config.nix
    ./configs/networking.nix
    ./configs/xserver_gnome.nix
    ./configs/opengl.nix
    ./configs/kvm_vfio.nix         #!!! 1) Select this or
    # ./configs/gpu_nvidia.nix     #!!! 2) This one only!
    ./configs/droidcam.nix
    ./configs/containers.nix
    ./configs/xone.nix
    ./configs/firefox.nix
    ./configs/zsh.nix
    ./configs/libinput.nix
  ];


  # System-wide apps
  programs = {
    
  };

  # System-wide packages
  environment.systemPackages = [
    pkgs.steam
    pkgs.fragments
    pkgs.parsec-bin
    pkgs.gedit
    pkgs.blackbox-terminal

    pkgs.osu-lazer-bin

    pkgs.gnome-extension-manager
    
    inputs.vesktop.legacyPackages."x86_64-linux".vesktop
  ];
}