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
  cfg = config.${namespace}.system.lid-suspend;
in {
  options.${namespace}.system.lid-suspend = with types; {
    enable = mkBoolOpt false "Whether or not to enable suspend (sleep) on closed lid.";
  };

  config = mkIf cfg.enable {
    
    systemd.sleep.extraConfig = ''
      AllowSuspend=yes
      AllowHibernation=yes
      AllowHybridSleep=yes
      AllowSuspendThenHibernate=yes
    '';

    services.acpid = {
      enable = true;
      lidEventCommands =
        ''
          export PATH=$PATH:/run/current-system/sw/bin

          lid_state=$(cat /proc/acpi/button/lid/LID/state | awk '{print $NF}')
          if [ $lid_state = "closed" ]; then
            ${pkgs.systemd}/bin/systemctl suspend
          fi
        '';
    };
  };
}