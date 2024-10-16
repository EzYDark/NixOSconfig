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
  cfg = config.${namespace}.system.upower;
in {
  options.${namespace}.system.upower = with types; {
    enable = mkBoolOpt false "Whether or not to enable UPower.";
  };

  config = mkIf cfg.enable {
    
    services.upower = {
      enable = true;
    };

  };
}