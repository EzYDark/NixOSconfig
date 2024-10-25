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
  cfg = config.${namespace}.hardware.xone;
in {
  options.${namespace}.hardware.xone = with types; {
    enable = mkBoolOpt false "Whether or not to enable Xbox controller support.";
  };

  config = mkIf cfg.enable {
    
    hardware.xone.enable = true;

    environment.systemPackages = with pkgs; [
      linuxKernel.packages.linux_xanmod_latest.xone
    ];

  };
}