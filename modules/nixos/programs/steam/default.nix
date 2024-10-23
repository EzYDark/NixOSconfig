{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.programs.steam;
in {
  options.${namespace}.programs.steam = with types; {
    enable = mkBoolOpt false "Whether or not to enable Steam.";
  };

  config = mkIf cfg.enable {
    
    programs.steam = {
      enable = true;
      extest.enable = true;
      protontricks = {
        enable = true;
      };
      gamescopeSession = {
        enable = true; 
      };

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      extraPackages = with pkgs; [
        gamescope
      ];
      localNetworkGameTransfers.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    programs.gamescope = {
      enable = true;
    };

  };
}