{ pkgs, ... }:

{
  imports = [
    ./configs/disk_partitions.nix
    ./configs/boot.nix
    ./hardware-configuration.nix

    ./configs/impermanence.nix
    # ./configs/opt-in_state.nix

    ./configuration.nix

    ./configs/users_groups

    ./configs/dev_work

    ./configs/sound_pipewire.nix
    ./configs/zram.nix
    ./configs/power_management.nix
    ./configs/nix_config.nix
    ./configs/networking.nix
    ./configs/hyprland
    ./configs/opengl.nix
    ./configs/kvm_vfio.nix # !! Choose this or
    # ./configs/gpu_nvidia.nix # !! this one only!
    ./configs/droidcam.nix
    ./configs/containers.nix
    ./configs/xone.nix
    ./configs/fish_shell.nix
    ./configs/keyd.nix
    ./configs/discord.nix
  ];

  # System-wide apps
  programs = { };

  # System-wide packages
  environment.systemPackages = [
    pkgs.steam
    pkgs.fragments
    pkgs.parsec-bin
    pkgs.stremio
    pkgs.wget
    pkgs.caprine-bin
    pkgs.spotify
    pkgs.vivaldi
    #pkgs.obsidian
    pkgs.protonvpn-gui
    pkgs.easyeffects
    pkgs.gnome.gnome-sound-recorder
    pkgs.osu-lazer-bin
    pkgs.killall
    pkgs.temurin-bin # latest JDK
    pkgs.telegram-desktop
    pkgs.satty
    pkgs.fusuma
    pkgs.ydotool
    pkgs.playerctl
    pkgs.upscayl
    pkgs.firefox-devedition
    pkgs.geckodriver
    pkgs.mitmproxy
    pkgs.microsoft-edge
    #pkgs.cloudflare-warp
    pkgs.dua
  ];
}
