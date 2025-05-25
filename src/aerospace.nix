{ pkgs, ... }:

{
  services = {
    aerospace = {
      enable = true;
      settings = {
        default-root-container-layout = "tiles";
        gaps = {
          inner.horizontal = 20;
          inner.vertical = 20;
          outer.top = 10;
          outer.right = 20;
          outer.bottom = 20;
          outer.left = 20;
        };

        mode.main.binding = {
          alt-cmd-ctrl-enter = "exec-and-forget ${pkgs.kitty}/bin/kitty -1 ${pkgs.tmux}/bin/tmux new-session -A -c ~/ -s main >/dev/null 2>&1";
          alt-cmd-ctrl-m = "macos-native-fullscreen";
          alt-cmd-ctrl-q = "close";

          alt-cmd-ctrl-semicolon = "layout tiles";
          alt-cmd-ctrl-quote = "layout accordion";

          alt-cmd-ctrl-left = "focus left";
          alt-cmd-ctrl-down = "focus down";
          alt-cmd-ctrl-up = "focus up";
          alt-cmd-ctrl-right = "focus right";

          shift-alt-cmd-ctrl-left = "move left";
          shift-alt-cmd-ctrl-down = "move down";
          shift-alt-cmd-ctrl-up = "move up";
          shift-alt-cmd-ctrl-right = "move right";

          alt-cmd-ctrl-1 = "workspace 1";
          alt-cmd-ctrl-2 = "workspace 2";
          alt-cmd-ctrl-3 = "workspace 3";
          alt-cmd-ctrl-4 = "workspace 4";
          alt-cmd-ctrl-5 = "workspace 5";
          alt-cmd-ctrl-6 = "workspace 6";
          alt-cmd-ctrl-7 = "workspace 7";
          alt-cmd-ctrl-8 = "workspace 8";
          alt-cmd-ctrl-9 = "workspace 9";
          alt-cmd-ctrl-0 = "workspace 10";

          shift-alt-cmd-ctrl-1 = "move-node-to-workspace 1";
          shift-alt-cmd-ctrl-2 = "move-node-to-workspace 2";
          shift-alt-cmd-ctrl-3 = "move-node-to-workspace 3";
          shift-alt-cmd-ctrl-4 = "move-node-to-workspace 4";
          shift-alt-cmd-ctrl-5 = "move-node-to-workspace 5";
          shift-alt-cmd-ctrl-6 = "move-node-to-workspace 6";
          shift-alt-cmd-ctrl-7 = "move-node-to-workspace 7";
          shift-alt-cmd-ctrl-8 = "move-node-to-workspace 8";
          shift-alt-cmd-ctrl-9 = "move-node-to-workspace 9";
          shift-alt-cmd-ctrl-0 = "move-node-to-workspace 10";
        };
      };
    };

    jankyborders = {
      enable = true;
      order = "above";
      hidpi = true;
      active_color = "0xFFFFFFFF";
      inactive_color = "0xFF262626";
      width = 3.0;
    };
  };

  launchd.daemons = {
    wallpaper = {
      script = ''
        osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"/System/Library/Desktop Pictures/Solid Colors/Black.png\" as POSIX file"
      '';
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
      };
    };
  };
}
