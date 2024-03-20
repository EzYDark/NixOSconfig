{ ... }: {
  #############################################
  # System configuration ( or uncategorized)
  #############################################

  # Set the system's timezone to Prague.
  time.timeZone = "Europe/Prague";

  # Set the system's locale to English.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "cz";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Allow unfree packages
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;
  environment = {
    variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      QT_QPA_PLATFORM = "wayland";
    };
  };

  environment.homeBinInPath =
    true; # Add ~/bin to $PATH

  system.stateVersion = "23.11";
}
