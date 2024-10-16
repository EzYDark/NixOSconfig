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
  cfg = config.${namespace}.system.disko.btrfs;
in {
  options.${namespace}.system.disko.btrfs = with types; {
    enable = mkBoolOpt false "Whether or not to enable Disko Btrfs config.";
  };

  config = mkIf cfg.enable {
    disko.devices = {
      disk = {
        main = {
          type = "disk";
          # device = "/dev/disk/by-id/nvme-WDC_PC_SN530_SDBPNPZ-512G-1027_20245T494806"; # TODO: Make it dynamic for all disks
          device = "/dev/disk/by-id/ata-WDC_PC_SN530_SDBPNPZ-512G-1027_20245T494806";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                name = "ESP";
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-f" # Override existing partition
                  ];
                  subvolumes = {
                    "@root" = {
                      mountOptions = [ "compress=zstd" "noatime" ];
                      mountpoint = "/";
                    };
                    "@nix" = {
                      mountOptions = [ "compress=zstd" "noatime" ];
                      mountpoint = "/nix";
                    };
                    "@home" = {
                      mountOptions = [ "compress=zstd" "noatime" ];
                      mountpoint = "/home";
                    };
                    "@snapshots" = {
                      mountOptions = [ "compress=zstd" "noatime" ];
                      mountpoint = "/.snapshots";
                    };
                    "@swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "16G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };

    fileSystems."/nix".neededForBoot = true;
    fileSystems."/home".neededForBoot = true;
    fileSystems."/.snapshots".neededForBoot = true;
  };
}