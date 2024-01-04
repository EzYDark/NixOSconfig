{ config, lib, pkgs, ... }:

{
  networking.hostName = "ezy-laptop"; # Set the hostname to "ezy-laptop".
  networking.networkmanager.enable = true;
}
