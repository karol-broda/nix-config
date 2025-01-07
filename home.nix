{ config, pkgs, inputs, lib, ... }:

let
  userAppsModule = import ./modules/nixpkgs/user-apps.nix {
    inherit pkgs config lib;
  };
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  home.username = "karolbroda";
  home.homeDirectory = "/Users/karolbroda";
  home.stateVersion = "23.11";

  home.packages = userAppsModule.config.userApps;

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts
      shuffle
      popupLyrics
      oneko
      beautifulLyrics
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "macchiato";
  };
}

