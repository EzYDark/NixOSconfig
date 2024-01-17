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
    libinput.enable = true; # Enable libinput for touchpad support
  };
  programs.xwayland.enable = true;


  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
  services.gnome.gnome-browser-connector.enable = true;


  environment.systemPackages = with pkgs; [
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.appindicator
  ];
}