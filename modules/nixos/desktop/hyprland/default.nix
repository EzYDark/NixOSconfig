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
  cfg = config.${namespace}.desktop.hyprland;
in {
  options.${namespace}.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable Hyprland desktop system-wide.";
  };

  config = mkIf cfg.enable {

    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      kitty
    ];

    # Are these meeded?
    programs.dconf.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;
  };
}