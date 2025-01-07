{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    casks = [
      "tor-browser"
      "zen-browser"
      "windscribe"
      "1password"
      "blender"
      "firefox"
      "whisky"
      "whatsapp"
      "microsoft-auto-update"
      "microsoft-outlook"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-teams"
      "microsoft-word"
      "adobe-acrobat-pro"
      "the-unarchiver"
      "raspberry-pi-imager"
      "angry-ip-scanner"
      "balenaetcher"
      "dymo-label"
      "android-studio"
      "epic-games"
      "adobe-creative-cloud"
    ];
  };
}

