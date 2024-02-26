{ ... }: {
  # Disable the SSH server.
  services.openssh = { enable = false; };
}
