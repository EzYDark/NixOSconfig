{
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  imports = [
    ./hardware.nix
    ./users_groups.nix
  ];

  networking.hostName = "eznix";

  eznix = {
    config.home-manager = enabled;
    config.nix = enabled;
    desktop = {
      greetd = enabled;
      hyprland = enabled;
    };
    hardware = {
      # kvm = enabled;
      nvidia-gpu = enabled;
      firmware = enabled;
      audio = enabled;
      uinput = enabled;
      xone = enabled;
    };
    programs = {
      defaultShell.fish = enabled;
      keyd = enabled;
      steam = enabled;
      gamemode = enabled;
      gamescope = enabled;
    };
    system = {
      power-management = enabled;
      lid-suspend = enabled;
      boot.systemd-boot = enabled;
      disko.btrfs = enabled;
      locale = enabled;
      xkb.xkb-cz_us = enabled;
      networking = enabled;
      upower = enabled;
    };
  };

  environment.systemPackages = with pkgs; [
    winetricks
  ];


  system.stateVersion = "24.05";
}