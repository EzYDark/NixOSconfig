# https://github.com/rvaiya/keyd/blob/master/docs/keyd.scdoc

{ pkgs, lib, ... }: {
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
        "HYPRLAND_INSTANCE_SIGNATURE=v0.32.3_1709166038"
      ];
      CapabilityBoundingSet =
        lib.mkForce "CAP_SETGID CAP_SYS_NICE";
    };
  };
}
