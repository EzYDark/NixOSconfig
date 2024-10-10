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
  cfg = config.${namespace}.programs.fish;
in {
  options.${namespace}.programs.fish = with types; {
    enable = mkBoolOpt false "Whether or not to enable Fish shell.";
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
  };
}