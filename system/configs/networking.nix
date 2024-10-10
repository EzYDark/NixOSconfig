{ ... }:

{
  networking = {
    hostName = "ezy-laptop"; # Hostname of the system
    networkmanager.enable = true;
    firewall.enable = false;
  };

  programs.nm-applet.enable = true;

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

  services.cloudflared.enable = true;
  networking.nameservers = [ "1.1.1.2" "1.0.0.2" ];

  programs.ssh.startAgent = true;
}
