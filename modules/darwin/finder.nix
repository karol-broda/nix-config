{ config, lib, ... }:

with lib;

let
  homeDir = "/Users/${config.system.user.name}"; 
in {
  config = {
    system.defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
      };

      "com.apple.finder" = {
        NewWindowTarget = "PfHm";
        NewWindowTargetPath = "file://${homeDir}";
        FXPreferredViewStyle = "Nlsv";
      };
    };
  };
}

