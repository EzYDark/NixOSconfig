{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    inputs.distrobox.legacyPackages."x86_64-linux".distrobox
  ];

  virtualisation = {
    oci-containers.backend = "podman";
    podman = {
      enable = true;
      dockerSocket.enable = true;
      enableNvidia = true;
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}