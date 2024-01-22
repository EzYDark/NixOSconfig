# https://nix-community.github.io/home-manager/options.xhtml
# https://mipmip.github.io/home-manager-option-search/

{ pkgs, ... }:

{
  imports = [
    ./configs/librewolf.nix
    ./configs/ssh.nix
  
    #./configs/gaming
  ];

  # User info
  home.username = "ezy";
  home.homeDirectory = "/home/ezy";
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  

  dconf = {
    enable = true;
    settings = {
      # Enable Fractional scaling of displays (Gnome)
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
      
      # Add minimize button to the windows
      "org/gnome/desktop/wm/preferences".button-layout = ":minimize,close";

      # Switch to new window instead of just "...is ready to use" notification
      "org/gnome/desktop/wm/preferences".focus-new-windows = "smart";

      "org/gnome/desktop/wm/keybindings".switch-windows = [ "<Alt>Tab" ];
    };
  };


  # User-wide packages
  home.packages = with pkgs; [
    
  ];
}
