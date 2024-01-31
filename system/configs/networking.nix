{ ... }:

{
  networking = {
    hostName = "ezy-laptop"; # Hostname of the system
    networkmanager.enable = true;
    firewall.enable = false;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
