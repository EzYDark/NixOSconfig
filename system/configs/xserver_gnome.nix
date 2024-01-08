{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "cz"; # Czech and English keyboard layouts
    # desktopManager.gnome.enable = true;
    # displayManager.gdm = {
    #   enable = true;
    #   wayland = true; # Enable Wayland for GDM
    # };
    videoDrivers = [ "amdgpu" ];
    displayManager = {
      defaultSession = "none+awesome";
      startx.enable = true;
    };
    windowManager.awesome = {
      enable = true;
    };
    desktopManager.gnome.enable = false;
    libinput.enable = true; # Enable libinput for touchpad support
  };

  boot.kernelPackages = pkgs.linuxPackages_5_15;
}
