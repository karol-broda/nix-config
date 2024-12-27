{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    tmux
    zsh
    git
    fzf
    bat
    fd
    ripgrep
    jq
    direnv
    httpie
    fnm
    python3
    nodejs
    awscli2
    tree
    colima
    docker
    docker-compose
    qemu
    deno
    gh
    starship
    lazygit
    uv
    ollama
    mas
    poetry
    libpqxx
    postgresql
    flutter
    lazysql
    just
    zellij
    kubectl
    minikube
    tesseract
    kubernetes-helm
    nmap
    silicon
    rustup
    hcloud
    powershell
    rogue
    pgcli
    fontconfig
  ];
}

