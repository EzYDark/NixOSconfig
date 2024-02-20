{ pkgs, pkgs-unstable, ... }:
{
  environment.systemPackages = [
    pkgs-unstable.vscode-fhs
  ];

}