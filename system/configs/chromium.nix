{ pkgs-unstable, ...}:
{
  environment.systemPackages = [
    pkgs-unstable.ungoogled-chromium
  ];
}