{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WDC_PC_SN530_SDBPNPZ-512G-1027_20245T494806";
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
                mountOptions = [
                  "defaults"
                  "umask=0077"
                ];
              };
            };
            root = {
              size = "100%";
              content = {
	              type = "btrfs";
	              extraArgs = [ "-f" ]; # Override existing partition
	              subvolumes = {
	                "@root" = {
	                  mountOptions = [
	                    "defaults"
	                    "compress=zstd"
	                  ];
	                  mountpoint = "/";
	                };
	                "@nix" = {
	                  mountOptions = [
	                    "defaults"
	                    "compress=zstd"
	                  ];
	                  mountpoint = "/nix";
	                };
	                "@" = {
	                  mountOptions = [
	                    "defaults"
	                    "compress=zstd"
	                  ];
	                  mountpoint = "/persist";
	                };
	                "@home" = {
	                  mountOptions = [
	                    "defaults"
	                    "compress=zstd"
	                  ];
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
}

