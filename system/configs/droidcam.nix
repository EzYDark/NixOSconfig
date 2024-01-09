{ pkgs, ... }:
{
  programs = {
    droidcam.enable = true;
  };

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_xanmod_latest.v4l2loopback
  ];

  boot.kernelModules = [ "v4l2loopback" ];
}