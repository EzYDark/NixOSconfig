{ pkgs, ... }:
{
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

  # Automatic battery threshold set (for Huawei Matebook)
  environment.systemPackages = [
    pkgs.inotify-tools
  ];
  systemd.services."bat-threshold" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "auto-cpufreq.service" ];
    serviceConfig = {
      User="root";
      Group="root";
      Restart="on-failure";
    };
    script = ''
      while true; do
          if ! grep -q "0 100" /sys/devices/platform/huawei-wmi/charge_control_thresholds; then
              echo 0x462848011503 | tee /sys/kernel/debug/huawei-wmi/arg && \
              cat /sys/kernel/debug/huawei-wmi/call && \
              cat /sys/kernel/debug/huawei-wmi/call && \

              echo 40 55 | tee /sys/devices/platform/huawei-wmi/charge_control_thresholds && \
              cat /sys/devices/platform/huawei-wmi/charge_control_thresholds
          fi
          /run/current-system/sw/bin/inotifywait -e modify /sys/devices/platform/huawei-wmi/charge_control_thresholds
      done
    '';
  };
}