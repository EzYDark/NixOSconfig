{ pkgs, ... }:
{
  # TODO: Make the SSH key (~/.ssh/ezKey) into this Nix configuration so it is still reproducible
  programs = {
    ssh = {
      enable = true;
      package = pkgs.openssh;
      compression = true;
      matchBlocks = {
        "github.com" = {
          user = "git";
          hostname = "github.com";
          identityFile = "~/.ssh/ezKey";
        };
      };
    };

    git = {
      enable = true;
      package = pkgs.git;
      userName = "EzYDark";
      userEmail = "ezydark@protonmail.com";
      extraConfig = {
        user = {
          signingKey = "~/.ssh/ezKey.pub";
        };
        commit = {
          gpgSign = true;
        };
        gpg = {
          format = "ssh";
        };
      };
    };

    gpg.enable = true;
  };

  services.ssh-agent.enable = true;
}