# https://search.nixos.org/options
# https://github.com/ryan4yin/nix-config/tree/i3-kickstarter
# https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-with-flakes-enabled
# https://github.com/tazjin/nix-1p
# https://github.com/enchanted-coder/nix-config

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Newer unreleased version of distrobox (1.6.0.1)
    distrobox.url = "github:pongo1231/nixpkgs/distrobox-1.6.0";

    vesktop.url = "github:Airradda/nixpkgs/master";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, disko, distrobox, vesktop, ... }: 
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      ezy-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };

        modules = [
          ./system

          disko.nixosModules.disko

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs;
            home-manager.users = {
              ezy = import ./home/ezy;
            };
          }
        ];
      };
    };
  };
}

