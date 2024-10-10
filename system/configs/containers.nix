{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.distrobox pkgs.virtiofsd ];

  virtualisation = {
    oci-containers.backend = "podman";
    podman = {
      enable = true;
      dockerSocket.enable = true;
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  hardware.nvidia-container-toolkit.enable = true;
}
