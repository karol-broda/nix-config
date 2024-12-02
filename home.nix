{ config, pkgs, ... }:

let
  userAppsModule = import ./modules/nixpkgs/user-apps.nix { inherit pkgs config; };
in
{
  home.username = "karolbroda";
  home.homeDirectory = "/Users/karolbroda";
  home.stateVersion = "23.11";

  home.packages = userAppsModule.userApps;

  programs.kitty = {
    enable = true;
    font = "JetBrains Mono 12";
  };

  programs.fzf = {
    enable = true;
    keybindings = {
      enable = true;
    };
    completion = {
      enable = true;
    };
  };

}
