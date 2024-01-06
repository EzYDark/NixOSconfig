{ ... }:

{
  networking.hostName = "ezy-laptop"; # Set the hostname to "ezy-laptop".
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = false;
  };
}
