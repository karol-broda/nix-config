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
<<<<<<< HEAD
=======
    transmission_4
>>>>>>> da0a81a (add lazygit and transmission)
  ];
}
