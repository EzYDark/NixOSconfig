{ ... }: {
  users.users = {
    ezy = {
      isNormalUser = true;
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
      ];
    };

    root = { password = "1234"; };
  };
}
