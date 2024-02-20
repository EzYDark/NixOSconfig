{ pkgs, ... }:
{
  hardware.xone.enable = true;

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_6.xone
  ];
}