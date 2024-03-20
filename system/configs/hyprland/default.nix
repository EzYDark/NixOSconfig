{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    xkb.layout = "cz";
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${import ./sddm_theme.nix {
        inherit pkgs;
      }}";
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
      ];
    };
    mime.enable = true;
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

  security.polkit.enable = true;

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
