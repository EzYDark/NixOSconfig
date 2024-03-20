{ pkgs, ... }: {
  imports = [ ./vscode.nix ];

  programs = { git.enable = true; };

  environment.systemPackages = [
    pkgs.nil
    pkgs.nixfmt

    pkgs.rust-analyzer
    pkgs.rustup
    pkgs.sccache

    pkgs.figma-linux

    pkgs.go
    pkgs.gopls

    pkgs.tailwindcss
    pkgs.bun
    pkgs.nodejs_21

    pkgs.just
  ];
}
