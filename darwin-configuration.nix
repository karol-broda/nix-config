{
  imports = [
    ./modules/nixpkgs/system-apps.nix
    ./modules/nixpkgs/user-apps.nix
    ./modules/homebrew/casks.nix
    ./modules/homebrew/appstore.nix
    ./modules/darwin/dock.nix
    ./modules/darwin/tid-sudo.nix
  ];

  system.stateVersion = 5;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    darwin.apple_sdk = {
      path = builtins.exec ["xcrun" "--show-sdk-path"];
      version = builtins.exec ["xcrun" "--sdk" "macosx" "--show-sdk-version"];
    };
  };

  services.nix-daemon.enable = true;

  security = {
    pam = {
      enableSudoTouchIdAuth = true;
    };
  };

  homebrew = {
    enable = true;
  };
}
