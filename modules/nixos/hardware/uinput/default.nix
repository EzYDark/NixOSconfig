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
  cfg = config.${namespace}.system.uinput;
in {
  options.${namespace}.system.uinput = with types; {
    enable = mkBoolOpt false "Whether or not to enable UInput.";
  };

  config = mkIf cfg.enable {
    
    hardware.uinput.enable = true;

  };
}