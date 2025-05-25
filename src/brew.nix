{ ... }:

{
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    casks = [
      "android-studio"
      "betterdisplay"
      "cursorcerer"
      "docker"
      "homerow"
      "jordanbaird-ice"
      "karabiner-elements"
      "macdroid"
      "microsoft-office"
      "qobuz-downloader"
      "showmeyourhotkeys"
      "soulseek"
      "spotify"
      "transmission"
      "whatsapp"
      "zen"
    ];
    brews = [
      "detox"
    ];
  };

  launchd.daemons = {
    showmeyourhotkeys = {
      script = "open -a ShowMeYourHotKeys";
      serviceConfig = {
        KeepAlive = false;
        RunAtLoad = true;
      };
    };
  };
}
