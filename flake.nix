{
  description = "my very not so fun nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, spicetify-nix, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      darwinConfigurations = {
        "Karols-MacBook-Pro" = darwin.lib.darwinSystem {
          system = system;
          modules = [
            ./darwin-configuration.nix
            ./modules/darwin/apps/ui-identity.nix
          ];
        };
      };

      homeConfigurations = {
        karolbroda = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = system;
            config = {
              allowUnfree = true;
            };
          };
          modules = [
            spicetify-nix.homeManagerModules.default
            ./home.nix
          ];
          extraSpecialArgs = {
            inputs = {
              inherit spicetify-nix;
            };
          };
        };
      };
    };
}

