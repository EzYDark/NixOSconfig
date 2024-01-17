{ pkgs, ...}:
{
  imports = [
    ./vscode.nix
  ];

  programs = {
    git = {
      enable = true;
      config = {
        user = {
          email = "ezydark@protonmail.com";
          name = "EzYDark";
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
  };
  
  environment.systemPackages = with pkgs; [
    nil
    bun
    rustup
    figma-linux
    telegram-desktop
    nodejs_21
  ];
}