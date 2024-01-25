{ pkgs, ... }:
{
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = false;

    users = { 
      ezy = {
        isNormalUser = true;
        password = "1234";
        group = "ezy";
        shell = pkgs.fish;
        extraGroups = [ "networkmanager" "wheel" "huawei-wmi" ];
      };
    };

    groups = {
      ezy = {
        members = [ "ezy" ];
      };
    };
  };
}