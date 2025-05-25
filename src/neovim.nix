{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    go
    php
    cargo
    luarocks
    php84Packages.composer
    julia-bin
    nodejs-slim
    python3Minimal
    leiningen
    python3Packages.pip
  ];
}
