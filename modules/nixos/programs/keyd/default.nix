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
  cfg = config.${namespace}.programs.keyd;
in {
  options.${namespace}.programs.keyd = with types; {
    enable = mkBoolOpt false "Whether or not to enable Keyd config.";
  };

  config = mkIf cfg.enable {
    services.keyd = {
      enable = true;
      keyboards = {
        "default" = {
          ids = [ "*" ];
          settings = {
            main = {
              leftalt =
                "overload(prev, layer(control))";
              leftcontrol = "layer(alt)";
            };
            "prev:C" = {
              tab =
                "swap2(prev2, macro(leftcontrol+leftalt+leftshift+f12))";
            };
            "prev2" = {
              tab =
                "swap2(prev2, macro(leftcontrol+leftalt+leftshift+f11))";
            };
          };
        };
      };
    };

    environment.systemPackages = with pkgs;
      [ keyd ];

    systemd.services."keyd" = {
      serviceConfig = {
        # User = "root";
        # Group = "root";
        #Restart = "on-failure";
        Environment = [
          "DISPLAY=:0"
        ];
        CapabilityBoundingSet =
          lib.mkForce "CAP_SETGID CAP_SYS_NICE";
      };
    };
  };
}