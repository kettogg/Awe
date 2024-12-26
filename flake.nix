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

  outputs = { self, nixpkgs, home-manager, nixpkgs-f2k, ... } @ inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        komari = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
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
        ketto = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs outputs self;
          };
          modules = [
            ./home/ketto/home.nix
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
