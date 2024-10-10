{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.desktop.kde;
in {
  options.${namespace}.desktop.kde = with types; {
    enable = mkBoolOpt false "Whether or not to enable KDE desktop";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    services.desktopManager.plasma6.enable = true;
    services.displayManager.defaultSession = "plasma";

    # Enable QT applications to have a look similar to the GNOME desktop, using a dark theme
    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };

    programs.dconf.enable = true;

    hardware.opengl = {
      enable = true;
      driSupport32Bit = true;
    };
  };
}