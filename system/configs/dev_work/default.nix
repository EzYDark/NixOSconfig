{ pkgs, ...}:
{
  imports = [
    ./vscode.nix
  ];

  programs = {
    git = {
      enable = true;
    };
    npm = {
      enable = true;
    };
  };
  
  environment.systemPackages = with pkgs; [
    git
    nil
    bun
    rustup
    figma-linux
    telegram-desktop
  ];
}