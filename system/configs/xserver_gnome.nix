{ pkgs, ... }:

{
  imports = [
    ./gnome_monitor_config.nix
  ];

  services.xserver = {
    enable = true;
    xkb.layout = "cz"; # Czech and English keyboard layouts
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true; # Enable Wayland for GDM
    };
  };
  programs.xwayland.enable = true;


  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
  services.gnome.gnome-browser-connector.enable = true;

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  environment.systemPackages = with pkgs; [
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.media-controls

    gnomeExtensions.appindicator
  ];


  # Dynamic triple buffering (https://nixos.wiki/wiki/GNOME)
  nixpkgs.overlays = [
    (final: prev: {
      gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
        mutter = gnomePrev.mutter.overrideAttrs ( old: {
          src = pkgs.fetchgit {
            url = "https://gitlab.gnome.org/vanvugt/mutter.git";
            # GNOME 45: triple-buffering-v4-45
            rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
            sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
          };
        } );
      });
    })
  ];

  # https://discourse.nixos.org/t/gdm-monitor-configuration/6356
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
      <!-- this should all be copied from your ~/.config/monitors.xml -->
      <monitors version="2">
        <configuration>
            <!-- REDACTED -->
        </configuration>
      </monitors>
    ''}"
  ];

  nixpkgs.config.allowAliases = false;
}