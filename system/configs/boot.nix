{ pkgs, ... }:
{
  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };

    initrd = {
      enable = true;
      systemd.enable = true;
      systemd.emergencyAccess = true;
      supportedFilesystems = [ "btrfs" ];
    };

    supportedFilesystems = [ "btrfs" ];

    # Remove the temporary files on boot.
    tmp.cleanOnBoot = true;
    
    kernelPackages = pkgs.linuxPackages_latest;
  };
}