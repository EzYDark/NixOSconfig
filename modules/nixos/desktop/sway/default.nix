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
  cfg = config.${namespace}.desktop.sway;
in {
  options.${namespace}.desktop.sway = with types; {
    enable = mkBoolOpt false "Whether or not to enable Sway desktop";
  };

  config = mkIf cfg.enable {
    
    eznix = {
      desktop = {
        greetd = enabled;
      };
    };

    environment.systemPackages = with pkgs; [
      grim # screenshot functionality
      slurp # screenshot functionality
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    ];

    programs.light.enable = true;

    # Enable the gnome-keyring secrets vault. 
    # Will be exposed through DBus to programs willing to store secrets.
    services.gnome.gnome-keyring.enable = true;

    # enable Sway window manager
    programs.sway = {
      enable = false;
      wrapperFeatures.gtk = true;
    };

    programs.dconf.enable = true;

    security.polkit.enable = true;
  };
}