{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  users.users = {
    ezy = {
      isNormalUser = true;
      useDefaultShell = true;
      password = "1234";
      group = "ezy";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "keyd"
        "uinput"
        "input"
        "kvm"
        "video"
        "gamemode"
      ];
    };

    root = { password = "1234"; };
  };

  users.groups = {
    ezy = { members = [ "ezy" ]; };
    keyd = { members = [ "ezy" ]; };
    gamemode = { members = [ "ezy" ]; };
  };
}