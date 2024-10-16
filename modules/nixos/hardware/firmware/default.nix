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
  cfg = config.${namespace}.hardware.firmware;
in {
  options.${namespace}.hardware.firmware = with types; {
    enable = mkBoolOpt false "Whether or not to enable custom Firmware.";
  };

  config = mkIf cfg.enable {
    
    hardware = {
      enableAllFirmware = true;
      enableRedistributableFirmware = true;
    };

  };
}