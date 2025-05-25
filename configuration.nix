{ pkgs, ... }:

let
  STATE_VERSION = "25.05";
  USER = "raf";
  DARWIN_STATE_VERSION = 5;
in
{
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  networking.hostName = "MBP";

  programs.fish.enable = true;
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
