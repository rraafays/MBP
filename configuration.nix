{ pkgs, ... }:

let
  USER = "raf";
  DARWIN_STATE_VERSION = 5;
in
{
  networking.hostName = "MBP";

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  system = {
    stateVersion = DARWIN_STATE_VERSION;
    primaryUser = USER;
  };

  programs.fish.enable = true;
  users = {
    knownUsers = [ USER ];
    users.${USER} = {
      name = USER;
      home = "/Users/${USER}";
      shell = pkgs.fish;
      uid = 501;
      packages = with pkgs; [
        adbfs-rootless
        android-tools
        bandwhich
        hyperfine
        mpv
        sacad
        spotdl
        sptlrx
        substudy
        yt-dlp-light
        zathura
      ];
    };
  };
}
