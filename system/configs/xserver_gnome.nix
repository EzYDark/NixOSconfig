{ ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "cz, us"; # Czech and English keyboard layouts
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true; # Enable Wayland for GDM
    };
    libinput.enable = true; # Enable libinput for touchpad support
  };
}
