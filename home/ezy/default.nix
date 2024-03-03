# https://nix-community.github.io/home-manager/options.xhtml (latest/unstable)
# https://mipmip.github.io/home-manager-option-search/ (latest/unstable)
# https://home-manager.dev/manual/23.11/options.xhtml (23.11 version of home-manager)

{ pkgs, ... }:

{
  imports = [
    ./configs/ssh_git.nix
    ./configs/hyprland.nix

    ./configs/alactritty.nix
    ./configs/bat.nix
    ./configs/themes.nix

    #./configs/gaming
  ];

  # User info
  home.username = "ezy";
  home.homeDirectory = "/home/ezy";
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  services.mako = {
    enable = true;
    backgroundColor = "#1d2021";
    borderColor = "#427b58";
    borderRadius = 5;
    borderSize = 2;
    textColor = "#a89984";
    layer = "overlay";
  };

  home.sessionVariables = { EDITOR = "nano"; };

  programs = { lf.enable = true; };

  # User-wide packages
  home.packages = with pkgs; [
    btop
    grim
    slurp
    aircrack-ng
    gping
    gh
    nmap
    mpv
    virt-manager
    unzip
    p7zip
    imv
    networkmanagerapplet
    iwgtk
    wirelesstools
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags
        ++ [ "-Dexperimental=true" ];
    }))
    mako
    libnotify
    hyprpaper
    rofi-wayland
    neofetch
    brightnessctl
    zathura
    htop
    eww
    lxmenu-data
    shared-mime-info
    cmatrix
  ];
}
