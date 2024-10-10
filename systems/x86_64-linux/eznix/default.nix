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
  ];

  networking.hostName = "eznix";

  users.users = {
    ezy = {
      isNormalUser = true;
      password = "1234";
      group = "ezy";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "keyd"
        "uinput"
        "input"
        "kvm"
        "video"
      ];
    };

    root = { password = "12341234"; };
  };

  users.groups = {
    ezy = { members = [ "ezy" ]; };
    keyd = { members = [ "ezy" ]; };
  };

  environment = {
    variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland,x11";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      NIXOS_OZONE_WL = "1";
      GTK_USE_PORTAL = "1";
      SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
      POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    };
  };

  eznix = {
    # config.home-manager = enabled;
    config.nix = enabled;
    desktop = {
      sway = disabled;
      kde = enabled;
    };
    hardware = {
      audio = enabled;
    };
    programs = {
      firefox = enabled;
      keyd = enabled;
      fish = enabled;
      vscode = enabled;
    };
    system = {
      boot.systemd-boot = enabled;
      disko.btrfs = enabled;
      locale = enabled;
      xkb.xkb-cz_us = enabled;
      networking = enabled;
    };
  };



  system.stateVersion = "24.05";
}