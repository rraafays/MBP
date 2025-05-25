{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      (iosevka-bin.override { variant = "SGr-IosevkaTermCurly"; })
      nerd-fonts.symbols-only
      noto-fonts-emoji
      sarabun-font
      sarasa-gothic
    ];
  };
}
