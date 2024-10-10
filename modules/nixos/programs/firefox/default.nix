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
  cfg = config.${namespace}.programs.firefox;
in {
  options.${namespace}.programs.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable Firefox web browser.";
  };

  config = mkIf cfg.enable {
    programs.firefox.enable = true;
  };
}