{
  options,
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.config.nix;
in {
  options.${namespace}.config.nix = with types; {
    enable = mkBoolOpt false "Whether or not to enable custom Nix configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # nix-fast-build
      nixfmt-rfc-style
    ];

    nix = let
      users = [ "ezy" ];
    in {
      package = pkgs.nixVersions.latest;
      settings = {
        sandbox = true;
        auto-optimise-store = true;
        experimental-features =
          [ "nix-command" "flakes" ];

        trusted-users = users;
        allowed-users = users;
        substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://cache.garnix.io"
        ];

        trusted-public-keys = [
          # the default public key of cache.nixos.org, it's built-in, no need to add it here
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        ];
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      optimise = { automatic = true; };

      # flake-utils-plus options
      generateRegistryFromInputs = true;
      generateNixPathFromInputs = true;
      linkInputs = true;
    };
  };
}