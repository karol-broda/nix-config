{
  description = "my very not so fun nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in {
      darwinConfigurations = {
        "Karols-MacBook-Pro" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [ ./darwin-configuration.nix ];
        };
      };

      homeConfigurations = {
        myUser = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          system = system;
          modules = [ ./home.nix ];
        };
      };
    };
}

