# https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html
# https://grahamc.com/blog/erase-your-darlings/
# https://github.com/nix-community/impermanence?tab=readme-ov-file

{ ... }: {
  environment.persistence."/persist" = {
    hideMounts = true;

    directories = [
      "/etc/nixos"

      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];

    users.ezy = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
      ];
      # files = [ "" ];
    };

    files = [
      # "/etc/machine-id"
      {
        file = "/etc/nix/id_rsa";
        parentDirectory = {
          mode = "u=rwx,g=,o=";
        };
      }
    ];
  };
}
