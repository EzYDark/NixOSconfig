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
  cfg = config.${namespace}.desktop.greetd;
in {
  options.${namespace}.desktop.greetd = with types; {
    enable = mkBoolOpt false "Whether or not to enable Greetd";
  };

  config = mkIf cfg.enable {

    security.pam.services.greetd = {
      enableGnomeKeyring = true;
      gnupg.enable = true;
      kwallet.enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.greetd.tuigreet} --asterisks --user-menu -g 'Welcome to NixOS ${config.system.nixos.release}' --time --remember --cmd sway";
          user = "greeter";
        };
      };
    };

  };
}