{ pkgs-unstable, ...}:
{
  # environment.systemPackages = [
  #   pkgs-unstable.ungoogled-chromium;
  # ];

  programs.chromium = {
    enable = true;
  };
}