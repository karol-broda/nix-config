{
  imports = [
    ./modules/nixpkgs/system-apps.nix
    ./modules/nixpkgs/user-apps.nix
    ./modules/homebrew/casks.nix
    ./modules/homebrew/appstore.nix
    ./modules/darwin/dock.nix
    ./modules/darwin/finder.nix
    ./modules/darwin/apps/ui-identity.nix
  ];

  system.stateVersion = 5;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
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

  system.activationScripts.setVSCodeDefaults = ''
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  '';
}
