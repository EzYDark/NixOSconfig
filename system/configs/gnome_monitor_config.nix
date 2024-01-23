{ systemd, pkgs, ... }:

let
  monitorsXmlContent = builtins.readFile /home/REPALCE_WITH_USERNAME/.config/monitors.xml;
  monitorsConfig = pkgs.writeText "gdm_monitors.xml" monitorsXmlContent;
in
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}"
  ];