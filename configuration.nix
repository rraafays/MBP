{ pkgs, ... }:

let
  STATE_VERSION = "24.11";
  USER = "raf";
  DARWIN_STATE_VERSION = 5;

  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${STATE_VERSION}.tar.gz";
in
{
  home-manager.users.${USER}.home.stateVersion = "${STATE_VERSION}";

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
      unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
        inherit pkgs;
      };
    };
  };

  imports = [
    "${home-manager}/nix-darwin"
    ./modules/brew
    ./modules/darwin
    ./modules/environment
    ./modules/fonts
    ./modules/home
    ./modules/neovim
    ./modules/aerospace
  ];

  networking.hostName = "MBP";

  users = {
    knownUsers = [ USER ];
    users.${USER} = {
      name = USER;
      home = "/Users/${USER}";
      shell = pkgs.fish;
      uid = 501;
    };
  };

  system = {
    stateVersion = DARWIN_STATE_VERSION;
    primaryUser = USER;
  };
}
