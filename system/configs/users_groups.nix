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
        extraGroups = [ "networkmanager" "wheel" "huawei-wmi" "libvirtd" ];
      };

      root = {
        password = "1234";
        shell = pkgs.fish;
      };
    };

    groups = {
      ezy = {
        members = [ "ezy" ];
      };
    };
  };
}
