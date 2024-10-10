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
  cfg = config.${namespace}.system.boot.systemd-boot;
in {
  options.${namespace}.system.boot.systemd-boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable systemd-booting.";
  };

  config = mkIf cfg.enable {
    # Use the systemd-boot EFI boot loader.
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          editor = false;
        };
        efi.canTouchEfiVariables = true;
        timeout = 10;
      };

      supportedFilesystems = [ "btrfs" ];

      initrd = {
        enable = true;
        systemd.enable = true;
        systemd.emergencyAccess = true;
        supportedFilesystems = [ "btrfs" ];
      };

      tmp.cleanOnBoot = true;

      # kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}