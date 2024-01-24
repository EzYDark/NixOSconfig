{ ... }:

{
  systemd.services."gdm-monitors" = {
    # TODO: Not working - Fix forcing login screen to the external/primary monitor
    # enable = true;
    # before = [ "gdm.service" ];
    # after = [ "gdm.service" ];
    # wantedBy = [ "multi-user.target" ];
    # serviceConfig = {
    #   User="root";
    #   Group="root";
    #   Restart="on-failure";
    # };
    # script = ''
    #   cp /etc/nixos/_configs/monitors.xml /run/gdm/.config/monitors.xml -fu
    #   chown gdm:gdm /run/gdm/.config/monitors.xml
    #   cat /run/gdm/.config/monitors.xml

    #   cp /etc/nixos/_configs/monitors.xml /home/ezy/.config/monitors.xml -fu
    # '';
  };
}