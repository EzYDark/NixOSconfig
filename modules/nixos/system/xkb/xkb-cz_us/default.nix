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
  cfg = config.${namespace}.system.xkb.xkb-cz_us;
in {
  options.${namespace}.system.xkb.xkb-cz_us = with types; {
    enable = mkBoolOpt false "Whether or not to enable custom xkb-cz_us.";
  };

  config = mkIf cfg.enable {
    services.xserver.xkb = {
      layout = "cz";
    };
  };
}