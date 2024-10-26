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
  cfg = config.${namespace}.programs.gamescope;
in {
  options.${namespace}.programs.gamescope = with types; {
    enable = mkBoolOpt false "Whether or not to enable Gamescope.";
  };

  config = mkIf cfg.enable {
    
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

  };
}