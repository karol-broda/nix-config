{ config, pkgs, lib, ... }:

{
  options = {
    userApps = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "List of user applications to install";
    };
  };

  config = {
    userApps = with pkgs; [
      kitty
      neovim
      vscode
      rectangle
      _1password-cli
      (discord.override {
        withVencord = true;
        withOpenASAR = true;
      })
      modrinth-app
      transmission_4-qt
      audacity
      # balena-cli
      neovide
      openvpn
      wezterm
      aerospace
      jankyborders
      raycast
      config.ubntIdentityEnterprise
    ];

    environment.systemPackages = config.userApps;
  };
}
