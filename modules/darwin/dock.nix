{ config, pkgs, lib, ... }:

with lib;

let
  entries = [
    "/System/Applications/Launchpad.app"
    "/Applications/Nix Apps/Kitty.app"
    "/Applications/Firefox.app"
    "/Applications/Nix Apps/Visual Studio Code.app"
    "/Applications/Microsoft Outlook.app"
    "/Applications/WhatsApp.app"
    "/Applications/Microsoft Teams.app"
    "/Applications/1Password.app"
    "/System/Applications/Calendar.app/"
    "/Applications/Whisky.app"
    "/Applications/Nix Apps/Spotify.app"
    "/Applications/Nix Apps/Discord.app"
  ];
  folders = [
    "~/work"
    "~/personal"
  ];
in {
  config = {
    system.defaults.dock = {
      persistent-apps = entries;
      persistent-others = folders;
      orientation = "left";
      tilesize = 40;
      show-recents = true;
    };
  };
}

