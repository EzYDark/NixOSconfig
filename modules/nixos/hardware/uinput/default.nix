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
  cfg = config.${namespace}.hardware.uinput;
in {
  options.${namespace}.hardware.uinput = with types; {
    enable = mkBoolOpt false "Whether or not to enable UInput.";
  };

  config = mkIf cfg.enable {
    
    hardware.uinput.enable = true;

  };
}