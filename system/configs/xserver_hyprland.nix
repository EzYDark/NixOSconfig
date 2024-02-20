{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "cz";
    displayManager = {
      sddm.enable = true;
      sddm.theme = "${import ./themes/sddm_theme.nix { inherit pkgs; }}";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}