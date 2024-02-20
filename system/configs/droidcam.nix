{ ... }:
{
  programs = {
    droidcam.enable = true;
  };

  boot.initrd.kernelModules = [ "v4l2loopback" ];
}