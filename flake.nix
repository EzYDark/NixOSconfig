# https://search.nixos.org/options
# https://github.com/ryan4yin/nix-config/tree/i3-kickstarter
# https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled
# https://github.com/tazjin/nix-1p
# https://github.com/enchanted-coder/nix-config

{
  inputs = {
    nixpkgs.url =
      "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs_23_11.url =
      "github:nixos/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url =
      "github:nix-community/impermanence";

    # Newer unreleased version of distrobox (1.6.0.1)
    distrobox.url =
      "github:pongo1231/nixpkgs/distrobox-1.6.0";

    vesktop.url =
      "github:Airradda/nixpkgs/master";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs_23_11
    , home-manager, disko, distrobox, vesktop
    , impermanence, ... }:
    let system = "x86_64-linux";
    in {
      nixosConfigurations = {
        ezy-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system inputs;

            pkgs_23_11 = import nixpkgs_23_11 {
              system = system;
              config.allowUnfree = true;
            };
          };

          modules = [
            ./system

            disko.nixosModules.disko

            impermanence.nixosModules.impermanence

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs =
                inputs;
              home-manager.users = {
                ezy = import ./home/ezy;
              };
            }
          ];
        };
      };
    };
}

