{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    neovim
    spotify
    vscode
    rectangle
    _1password-cli
    discord
    modrinth-app
  ];
}
