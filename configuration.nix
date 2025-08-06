{ pkgs, ... }:

let
  USER = "raf";
  DARWIN_STATE_VERSION = 5;
in
{
  imports = [
    ./modules/aerospace
    ./modules/brew
    ./modules/darwin
    ./modules/environment
    ./modules/fonts
    ./modules/neovim
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
          (writeShellScriptBin "su" ''
            #!${stdenv.shell}
            /usr/bin/sudo /usr/bin/su "$@"
          '')
          adbfs-rootless
          android-tools
          bandwhich
          hyperfine
          kitty
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
  };

  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    casks = [
      "android-file-transfer"
      "darktable"
      "kid3"
      "makemkv"
      "musicbrainz-picard"
      "playcover-community"
      "qobuz-downloader"
      "soulseek"
      "spotify"
      "transmission"
      "wechat"
      "whatsapp"
    ];
  };
}
