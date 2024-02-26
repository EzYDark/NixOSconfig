{ pkgs, ... }: {
  users.users = {
    ezy = {
      isNormalUser = true;
      password = "1234";
      group = "ezy";
      shell = pkgs.fish;
      extraGroups =
        [ "networkmanager" "wheel" "libvirtd" ];
    };

    root = {
      password = "1234";
      shell = pkgs.fish;
    };
  };
}
