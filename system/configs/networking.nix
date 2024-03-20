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

  # mDNS service to publish my hostname as domain on LAN (ping ezy-laptop.local) ??
  # TODO: Set custom domain/hostname??
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    ipv4 = true;
    openFirewall = true;
    reflector = true;
    publish = { # Is this all needed ??
      enable = true;
      userServices = true;
      domain = true;
      addresses = true;
      workstation = true;
      hinfo = true;
    };
  };

  # P2P VPN network
  services.zerotierone = { enable = true; };

  programs.ssh.startAgent = true;
}
