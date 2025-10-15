{ pkgs, ... }:

let
  USER = "raf";
  DARWIN_STATE_VERSION = 5;
in
{
  imports = [
    ./src/aerospace.nix
    ./src/brew.nix
    ./src/environment.nix
    ./src/fonts.nix
    ./src/system.nix
  ];

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
    knownUsers = [
      USER
      "root"
    ];
    users = {
      root = {
        shell = pkgs.fish;
        uid = 0;
      };
      ${USER} = {
        name = USER;
        home = "/Users/${USER}";
        shell = pkgs.fish;
        uid = 501;
        packages = with pkgs; [
          adbfs-rootless
          android-tools
          bandwhich
          hyperfine
          sacad
          spotdl
          sptlrx
          substudy
          yt-dlp-light
          zathura
        ];
      };
    };
  };

  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    casks = [
      "android-file-transfer"
      "darktable"
      "handbrake-app"
      "kid3"
      "makemkv"
      "musicbrainz-picard"
      "qobuz-downloader"
      "rockboxutility"
      "soulseek"
      "spotify"
      "transmission"
      "wechat"
      "whatsapp"
    ];
  };
}
