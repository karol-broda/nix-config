{ config, pkgs, ... }:

{
  imports = [
    ./modules/nixpkgs/system-apps.nix
    ./modules/nixpkgs/user-apps.nix
    ./modules/homebrew/casks.nix
    ./modules/darwin/dock.nix
    ./modules/darwin/tid-sudo.nix
  ];

  system.stateVersion = 5;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  services.nix-daemon.enable = true;

  homebrew = {
    enable = true;
  };
}

