{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "cz"; # Czech and English keyboard layouts
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true; # Enable Wayland for GDM
    };
    videoDrivers = [ "amdgpu" ];
    libinput.enable = true; # Enable libinput for touchpad support
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
