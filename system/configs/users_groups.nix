{ ... }:
{
  users = {
    defaultUserShell = "pkgs.zsh";
    mutableUsers = false;

    users = { 
      ezy = {
        isNormalUser = true;
        password = "1234";
        group = "ezy";
        shell = "pkgs.zsh";
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