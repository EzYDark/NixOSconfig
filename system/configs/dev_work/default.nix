{ pkgs, ... }: {
  imports = [ ./vscode.nix ];

  programs = { git.enable = true; };

  environment.systemPackages = with pkgs; [
    nil
    bun
    rustup
    figma-linux
    telegram-desktop
    nodejs_21
  ];
}
