{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/nixos/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        re1san = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home/re1san/home.nix
          ];
        };
      };
    };
}
