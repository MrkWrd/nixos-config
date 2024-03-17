{
  description = "A NixOS configurations flake including home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.laptop-17 = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs; };
      modules = [
        ./hosts/laptop-17/configuration.nix
	inputs.home-manager.nixosModules.default
      ];
    };
  };
}
