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
  cfg = config.${namespace}.programs.defaultShell.fish;
in {
  options.${namespace}.programs.defaultShell.fish = with types; {
    enable = mkBoolOpt false "Whether or not to enable and set Fish as default system-wide shell.";
  };

  config = mkIf cfg.enable {
    
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish;

  };
}