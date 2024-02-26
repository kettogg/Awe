{
  description = "Rei's flakes!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nur.url = github:nix-community/NUR;
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-f2k, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        komari = nixpkgs.lib.nixosSystem {
          modules = [
	    home-manager.nixosModule
            ./hosts/komari/configuration.nix
	    {
              nixpkgs.overlays = [
                nixpkgs-f2k.overlays.window-managers
              ];
            }
          ];
        };
      };
      homeConfigurations = {
        re1san = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home/re1san/home.nix
	    {
              nixpkgs.overlays = [
                nixpkgs-f2k.overlays.window-managers
              ];
            }
          ];
        };
      };
    };
}
