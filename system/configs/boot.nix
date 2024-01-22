{ pkgs, ... }:
{
  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };

    # Remove the temporary files on boot.
    tmp.cleanOnBoot = true;
    
    kernelPackages = pkgs.linuxPackages_6_6;
  };
}