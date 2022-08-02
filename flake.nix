{
  description = "Dom's Polar Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    daedalus.url = "git+https://gitlab.homotopic.tech/nix/daedalus-flake";
  };

  outputs = { home-manager, nixpkgs, flake-utils,  daedalus, ... }: {
    nixosConfigurations = {
       polar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
	        daedalus.nixosModules.x86_64-linux.daedalus
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
        ];
      };
    };
  };
}