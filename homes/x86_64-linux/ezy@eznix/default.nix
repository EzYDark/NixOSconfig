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
  # eznix = { };

  wayland.windowManager.sway = {
    enable = true;
    extraConfig = ''
      input * {
        xkb_layout "cz,us"
      }
    '';
  };
  

  
  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "24.05");
}