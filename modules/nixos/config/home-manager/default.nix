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
  cfg = config.${namespace}.config.home-manager;
in {
  options.${namespace}.config.home-manager = with types; {
    enable = mkBoolOpt false "Whether or not to enable custom Home-Manager configuration.";
  };

  config = mkIf cfg.enable {
    home-manager = {
      useUserPackages = true;
      backupFileExtension = "backup";
    };
  };
}