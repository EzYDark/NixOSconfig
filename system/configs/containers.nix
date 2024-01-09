{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.distrobox
  ];

  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
    enableNvidia = true;
    dockerCompat = true;
  };
}