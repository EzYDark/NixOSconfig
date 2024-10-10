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
  cfg = config.${namespace}.programs.vscode;
in {
  options.${namespace}.programs.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable VSCode.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.vscode-fhs ];
  };
}