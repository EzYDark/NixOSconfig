{ pkgs, ... }: {
  imports = [ ./groups.nix ./users.nix ];

  users = {
    # defaultUserShell = pkgs.fish;
    mutableUsers = false;
  };
}
