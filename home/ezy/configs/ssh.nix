{ pkgs, lib, ... }: {
  # TODO: Make the SSH key (~/.ssh/ezKey) into this Nix configuration so it is still reproducible (using Impermanence?)
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
          extraOptions = {
            AddKeysToAgent = "yes";
          };
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
        commit = { gpgSign = true; };
        gpg = { format = "ssh"; };
      };
    };

    gpg.enable = true;
  };

  services.ssh-agent.enable = true;

  # Little hack to fix permissions and updating of ~/.ssh/config after creating it with home-manager
  home.file.".ssh/config" = {
    target = ".ssh/config_source";
  };
  home.activation = {
    sshConfigChmod =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -f $HOME/.ssh/config_source ]; then
          $DRY_RUN_CMD /run/current-system/sw/bin/inotifywait $VERBOSE_ARG -t 10 -e create $HOME/.ssh/config_source
        fi
        if [ ! -f $HOME/.ssh/config ]; then
          $DRY_RUN_CMD cp $HOME/.ssh/config_source $HOME/.ssh/config
          $DRY_RUN_CMD chmod 600 $HOME/.ssh/config
        else
          if ! diff $HOME/.ssh/config $HOME/.ssh/config_source; then
            $DRY_RUN_CMD rm $HOME/.ssh/config
            $DRY_RUN_CMD cp $HOME/.ssh/config_source $HOME/.ssh/config
            $DRY_RUN_CMD chmod 600 $HOME/.ssh/config
          fi
        fi
      '';
  };
}
