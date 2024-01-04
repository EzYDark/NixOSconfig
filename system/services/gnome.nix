{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "cz"; # Czech keyboard layout
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true; # Enable Wayland for GDM
    };
    libinput.enable = true; # Enable libinput for touchpad support
  };
}
