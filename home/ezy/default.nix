# https://nix-community.github.io/home-manager/options.html
# https://mipmip.github.io/home-manager-option-search/

{ pkgs, ... }:

{
  home.username = "ezy";
  home.homeDirectory = "/home/ezy";

  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # User-wide apps
  programs = {
    librewolf.enable = true;
  };

  # User-wide packages
  home.packages = with pkgs; [
    vscode-fhs
    nil
    steam
    fragments
    gnome-extension-manager
    # gnomeExtensions.huawei-wmi-controls
  ];

  # Enable Fractional scaling of displays (Gnome)
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };
}
