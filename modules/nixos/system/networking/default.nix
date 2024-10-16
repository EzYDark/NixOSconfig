{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.networking;
in {
  options.${namespace}.system.networking = with types; {
    enable = mkBoolOpt false "Whether or not to enable Networking";
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      firewall.enable = false; # TEMP disabling
    };

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
    
    networking.nameservers = [ "1.1.1.2" "1.0.0.2" ];
  };
}