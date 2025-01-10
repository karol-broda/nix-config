{
  config,
  pkgs,
  lib,
  ...
}: {
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
      discord
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
      monitorcontrol
      ghostty
    ];

    environment.systemPackages = config.userApps;
  };
}
