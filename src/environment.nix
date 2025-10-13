{ pkgs, ... }:

{
  imports = [ ./toolset.nix ];

  environment.systemPackages =
    with pkgs;
    [
      android-file-transfer
      bat
      btop
      cdrtools
      direnv
      du-dust
      duf
      fd
      ffmpeg
      file
      fzf
      gcc
      gh
      git
      killall
      lf
      lsd
      mprocs
      nix-your-shell
      nodejs-slim
      p7zip
      par2cmdline-turbo
      python3
      rates
      rename
      ripgrep
      rsync
      shfmt
      starship
      stylua
      substudy
      tmux
      unrar
      unzip
      uutils-coreutils-noprefix
      wget
      zk
      zoxide
    ];
}
