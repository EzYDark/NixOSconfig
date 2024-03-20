{ ... }: {
  programs = {
    # Flakes use Git to pull dependencies from data sources 
    git.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features =
        [ "nix-command" "flakes" ];

      trusted-users = [ "ezy" ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        # the default public key of cache.nixos.org, it's built-in, no need to add it here
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = { automatic = true; };

  };

  # Dirty hack to enable "direnv" function using "nix-shell" that does not what for some reason access to "/etc/nix/registry.json" without sudo.
  systemd.services."nix-perm" = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "nix-daemon.service" ];
    serviceConfig = {
      User = "root";
      Group = "root";
      Restart = "on-failure";
    };
    script = ''
      # Define the target file
      TARGET_FILE="/etc/nix/registry.json"

      # Define the desired owner and group
      DESIRED_OWNER="ezy"
      DESIRED_GROUP="ezy"

      # Function to set the owner and group for the target file
      set_owner_and_group() {
          if [ -f "$TARGET_FILE" ]; then
              current_owner=$(stat -c '%U' "$TARGET_FILE")
              current_group=$(stat -c '%G' "$TARGET_FILE")

              if [ "$current_owner" != "$DESIRED_OWNER" ] || [ "$current_group" != "$DESIRED_GROUP" ]; then
                  chown -Rv "$DESIRED_OWNER:$DESIRED_GROUP" "$TARGET_FILE" #!! Has to be "-R" for working symlinks
              fi
          else
              echo "File $TARGET_FILE does not exist."
          fi
      }

      # Call the function to set the owner and group
      set_owner_and_group

      # Set up inotify to watch for changes in the target file
      /run/current-system/sw/bin/inotifywait -m -e modify,move,create,delete "$TARGET_FILE" | while read -r path event file; do
          set_owner_and_group
      done
    '';
  };
}
