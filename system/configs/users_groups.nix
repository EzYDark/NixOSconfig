{ ... }:
{
  users.users = { 
    ezy = {
      createHome = true;
      isNormalUser = true;
      password = "1234";
      group = "ezy";
      shell = "/bin/bash";
      uid = 1000;
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  users.groups = {
    ezy = {
      gid = 1000;
    };
  };

  

  users.mutableUsers = false;
}