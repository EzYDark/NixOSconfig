# https://github.com/nix-community/disko/tree/master/example

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device =
          "/dev/disk/by-id/nvme-WDC_PC_SN530_SDBPNPZ-512G-1027_20245T494806"; # TODO: Make it dynamic for all disks
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
                  "-f"
                ]; # Override existing partition
                subvolumes = {
                  "@root" = {
                    mountOptions =
                      [ "compress=zstd" ];
                    mountpoint = "/";
                  };
                  "@nix" = {
                    mountOptions =
                      [ "compress=zstd" ];
                    mountpoint = "/nix";
                  };
                  "@persist" = {
                    mountOptions =
                      [ "compress=zstd" ];
                    mountpoint = "/persist";
                  };
                  "@persist_snapshots" = {
                    mountOptions =
                      [ "compress=zstd" ];
                    mountpoint =
                      "/persist/_snapshots";
                  };
                  "@persist_home" = {
                    mountOptions =
                      [ "compress=zstd" ];
                    mountpoint = "/persist/home";
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;
  # fileSystems."/persist/_snapshots".neededForBoot = true;
  fileSystems."/persist/home".neededForBoot =
    true;
}

