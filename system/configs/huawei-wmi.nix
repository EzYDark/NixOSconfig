{ pkgs, ... }:
{
  boot.initrd.kernelModules = [ "huawei_wmi" ];
  environment.systemPackages = with pkgs; [
    gnomeExtensions.huawei-wmi-controls
  ];

  # TODO: Set battery min-max thresholds
}