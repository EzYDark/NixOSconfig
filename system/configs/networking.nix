{ ... }:

{
  networking = {
    hostName =
      "ezy-laptop"; # Hostname of the system
    networkmanager.enable = true;
    firewall.enable = false;
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # DNS service to publish my hostname as domain on LAN (ping ezy-laptop.local) ??
  # TODO: Set custom domain/hostname??
  services.avahi = {
    enable = true;
    publish = { # Is this all needed ??
      enable = true;
      userServices = true;
      addresses = true;
    };
  };

  programs.ssh.startAgent = true;
}
