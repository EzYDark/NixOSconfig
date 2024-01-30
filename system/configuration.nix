{ ... }:
{
  #############################################
  # System configuration (uncategorized)
  #############################################


  # Set the system's timezone to Prague.
  time.timeZone = "Europe/Prague";


  # Set the system's locale to English.
  i18n.defaultLocale = "en_US.UTF-8";


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment = {
    variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      QT_QPA_PLATFORM = "wayland";
    };
  };
  

  # Enable to support opening default applications with xdg-open from containers and FHS apps
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
    mime.enable = true;
  };
  environment.homeBinInPath = true; # Add ~/bin to $PATH


  system.stateVersion = "23.11";
}