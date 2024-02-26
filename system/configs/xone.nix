{ pkgs, ... }: {
  hardware.xone.enable = true;

  environment.systemPackages = with pkgs;
    [
      linuxKernel.packages.linux_xanmod_latest.xone
    ];
}
