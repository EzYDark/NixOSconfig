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
  cfg = config.${namespace}.system.power-management;
in {
  options.${namespace}.system.power-management = with types; {
    enable = mkBoolOpt false "Whether or not to enable Power Management.";
  };

  config = mkIf cfg.enable {
    
    powerManagement = {
      enable = true;
      scsiLinkPolicy = "max_performance";
      cpuFreqGovernor = "performance";
    };

    services.auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "performance";
          turbo = "always";
        };
        charger = {
          governor = "performance";
          turbo = "always";
        };
      };
    };

    # Automatic battery threshold set (for Huawei Matebook)
    boot.initrd.kernelModules = [ "huawei_wmi" ];

    environment.systemPackages =
      [ pkgs.inotify-tools ];

    systemd.services."bat-threshold" = {
      enable = true;
      wantedBy = [ "multi-user.target" ];
      after = [ "auto-cpufreq.service" ];
      serviceConfig = {
        User = "root";
        Group = "root";
        Restart = "on-failure";
      };
      script = ''
        # Define the desired threshold
        DESIRED_THRESHOLD="40 55" # Battery threshold between 40-55%

        while true; do
            # Read the current threshold value into a variable
            CURRENT_THRESHOLD=$(cat /sys/devices/platform/huawei-wmi/charge_control_thresholds)

            # Check if the current threshold is not the desired threshold
            if [ "$CURRENT_THRESHOLD" != "$DESIRED_THRESHOLD" ]; then
                # Send the command to the debug interface
                echo 0x462848011503 | tee /sys/kernel/debug/huawei-wmi/arg && \
                cat /sys/kernel/debug/huawei-wmi/call && \
                cat /sys/kernel/debug/huawei-wmi/call && \

                # Set the new thresholds
                echo $DESIRED_THRESHOLD | tee /sys/devices/platform/huawei-wmi/charge_control_thresholds && \
                cat /sys/devices/platform/huawei-wmi/charge_control_thresholds
            fi

            # Wait for changes to the threshold
            /run/current-system/sw/bin/inotifywait -e modify /sys/devices/platform/huawei-wmi/charge_control_thresholds
        done
      '';
    };

  };
}