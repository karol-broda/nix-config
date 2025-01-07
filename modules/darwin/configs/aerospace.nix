{ config, pkgs, lib, ... }:

with lib;

{
  config = {
    services.aerospace = {
      enable = true;

      settings = {
        start-at-login = true;

        after-startup-command = [
          "exec-and-forget borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=2.5"
        ];

        automatically-unhide-macos-hidden-apps = true;

        on-focus-changed = ["move-mouse window-lazy-center"];
        on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];

        gaps = {
          inner = {
            horizontal = 10;
            vertical = 10;
          };
          outer = {
            left = 10;
            right = 10;
            top = 10;
            bottom = 10;
          };
        };

        mode.main.binding = {
          "alt-h" = "focus left";
          "alt-j" = "focus down";
          "alt-k" = "focus up";
          "alt-l" = "focus right";

          "alt-shift-h" = "move left";
          "alt-shift-j" = "move down";
          "alt-shift-k" = "move up";
          "alt-shift-l" = "move right";

          "alt-shift-minus" = "resize smart -50";
          "alt-shift-equal" = "resize smart +50";

          "alt-1" = "workspace 1";
          "alt-2" = "workspace 2";
          "alt-3" = "workspace 3";
          "alt-4" = "workspace 4";
          "alt-5" = "workspace 5";
          "alt-6" = "workspace 6";
          "alt-7" = "workspace 7";
          "alt-8" = "workspace 8";
          "alt-9" = "workspace 9";
          "alt-0" = "workspace current";

          "alt-m" = "move-workspace-to-monitor next";
          "alt-shift-m" = "move-workspace-to-monitor prev";

          "alt-shift-1" = "move-node-to-workspace 1";
          "alt-shift-2" = "move-node-to-workspace 2";
          "alt-shift-3" = "move-node-to-workspace 3";
          "alt-shift-4" = "move-node-to-workspace 4";
          "alt-shift-5" = "move-node-to-workspace 5";
          "alt-shift-6" = "move-node-to-workspace 6";
          "alt-shift-7" = "move-node-to-workspace 7";
          "alt-shift-8" = "move-node-to-workspace 8";
          "alt-shift-9" = "move-node-to-workspace 9";

          "alt-f" = "fullscreen";
          "alt-shift-f" = "macos-native-fullscreen";
          "alt-minus" = "macos-native-minimize";

          "alt-slash" = "layout tiles horizontal vertical";
          "alt-comma" = "layout accordion horizontal vertical";
          "alt-q" = "close";
        };
      };
    };
  };
}

