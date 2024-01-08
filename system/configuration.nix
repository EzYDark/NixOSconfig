
#############################
# Uncategorized configuration
#############################

{ pkgs, hyprland, ... }:

{
  # System-wide apps
  programs = {
    hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.system}.hyprland;
    };
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    
  ];
  
}
