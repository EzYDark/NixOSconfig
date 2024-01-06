{ ... }:
{
  # Set the system's timezone to Prague.
  time.timeZone = "Europe/Prague";

  # Set the system's locale to English.
  i18n.defaultLocale = "en_US.UTF-8";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  system.stateVersion = "23.11";
}