# https://nix-community.github.io/home-manager/options.xhtml
# https://mipmip.github.io/home-manager-option-search/

{ pkgs, ... }:

{
  imports = [
    ./configs/librewolf.nix
  
    #./configs/gaming
  ];

  # User info
  home.username = "ezy";
  home.homeDirectory = "/home/ezy";
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Enable Fractional scaling of displays (Gnome)
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  dconf.settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,close";



  # User-wide packages
  home.packages = with pkgs; [
    
  ];
}
