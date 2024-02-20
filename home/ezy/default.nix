# https://nix-community.github.io/home-manager/options.xhtml
# https://mipmip.github.io/home-manager-option-search/

{ pkgs, ... }:

{
  imports = [
    ./configs/librewolf.nix
    ./configs/ssh.nix

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
 
  home.sessionVariables = {
    EDITOR = "nano";
  };

  programs = {
    lf.enable = true;
  };
  

  # dconf = {
  #   enable = true;
  #   settings = {
  #     # Enable Fractional scaling of displays (Gnome)
  #     "org/gnome/mutter" = {
  #       experimental-features = [ "scale-monitor-framebuffer" ];
  #     };
      
  #     # Add minimize button to the windows
  #     "org/gnome/desktop/wm/preferences".button-layout = ":minimize,close";

  #     # Switch to new window instead of just "...is ready to use" notification
  #     "org/gnome/desktop/wm/preferences".focus-new-windows = "smart";

  #     "org/gnome/desktop/wm/keybindings".switch-windows = [ "<Alt>Tab" ];
  #   };
  # };


  # User-wide packages
  home.packages = with pkgs; [
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
    gnome.file-roller
    imv
    networkmanagerapplet
    iwgtk
    wirelesstools
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
     })
    )
    mako 
    libnotify
    hyprpaper
    rofi-wayland
    neofetch
    brightnessctl
    zathura
    htop
    libreoffice-still
    eww-wayland
    lxmenu-data
    shared-mime-info
    cmatrix
  ];
}
