{ ... }:
{
  #############################################
  # System configuration ( or uncategorized)
  #############################################


  # Set the system's timezone to Prague.
  time.timeZone = "Europe/Prague";


  # Set the system's locale to English.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "cz";
    # useXkbConfig = true; # use xkbOptions in tty.
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment = {
    variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      QT_QPA_PLATFORM = "wayland";
      NIXOS_OZONE_WL = "1";
      # If cursor becomes invisible on Hyprland
      # WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
  

  # Enable to support opening default applications with xdg-open from containers and FHS apps
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
    mime.enable = true;
  };
  environment.homeBinInPath = true; # Add ~/bin to $PATH


  # HYPRLAND uncategorized configs
  programs.dconf.enable = true;

  # Thunar File Manager 
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
   thunar-archive-plugin
   thunar-volman
  ];

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Enable fonts
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
      };
    };
    packages = with pkgs; [ (nerdfonts.override { fonts = [ "Meslo" "JetBrainsMono" ]; }) ];
  };

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    pamixer
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
  ];

  system.stateVersion = "23.11";
}