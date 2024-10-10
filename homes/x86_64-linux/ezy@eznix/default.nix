{
  config,
  lib,
  osConfig,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  snowfallorg.user.enable = true;
  eznix = { 
    desktop = {
      sway = enabled;
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
    vscode-fhs
    xfce.thunar
    rofi-wayland
    kitty
    autotiling
    polkit_gnome
    xdg-desktop-portal-wlr
    pkgs.greetd.tuigreet
    bluez
  ];

  
  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "24.05");
}