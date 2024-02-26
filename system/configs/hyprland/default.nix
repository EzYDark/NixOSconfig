{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    xkb.layout = "cz";
    # displayManager = {
    #   sddm.enable = true;
    #   sddm.theme = "${import ./sddm_theme.nix { inherit pkgs; }}";
    # };
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Activate system module for Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable to support opening default applications with xdg-open from containers and FHS apps etc.
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal
      ];
    };
  };

  programs.dconf.enable = true;

  # Thunar File Manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services = {
    gvfs.enable =
      true; # Mount, trash, and other functionalities
    tumbler.enable =
      true; # Thumbnail support for images
    gnome.gnome-keyring.enable =
      true; # Keyring for managing secrets
  };

  # Enable fonts
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "Meslo LG M Regular Nerd Font Complete Mono"
        ];
      };
    };
    packages = with pkgs;
      [
        (nerdfonts.override {
          fonts = [ "Meslo" "JetBrainsMono" ];
        })
      ];
  };

  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    gnumake

    wl-clipboard
    polkit_gnome
    pamixer
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    xdg-utils
  ];
}
