{ pkgs, inputs, pkgs-unstable, ... }:

{
  imports = [
    ./configs/disk_partitions.nix
    ./configs/boot.nix
    ./hardware-configuration.nix

    ./configs/impermanence.nix
    # ./configs/opt-in_state.nix

    ./configuration.nix

    ./configs/users_groups.nix

    ./configs/dev_work

    ./configs/sound_pipewire.nix
    ./configs/zram.nix
    ./configs/power_management.nix
    ./configs/openssh.nix
    ./configs/nix_config.nix
    ./configs/networking.nix
    ./configs/xserver_hyprland.nix
    ./configs/opengl.nix
    ./configs/kvm_vfio.nix # !! Choose this or
    # ./configs/gpu_nvidia.nix     #!! this one only!
    ./configs/droidcam.nix
    ./configs/containers.nix
    ./configs/xone.nix
    ./configs/firefox.nix
    ./configs/chromium.nix
    ./configs/fish_shell.nix
  ];

  # System-wide apps
  programs = { nix-ld.enable = true; };

  # System-wide packages
  environment.systemPackages = [
    pkgs.steam
    pkgs.fragments
    pkgs.parsec-bin
    pkgs-unstable.stremio
    pkgs.spotifyd
    pkgs.virtiofsd
    pkgs.appimage-run
    pkgs.wget
    pkgs.caprine-bin
    pkgs-unstable.spotify-player
    pkgs-unstable.spotify
    pkgs-unstable.kitty
    pkgs.nixfmt

    pkgs.osu-lazer-bin

    inputs.vesktop.legacyPackages."x86_64-linux".vesktop
  ];
}
