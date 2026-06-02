{
  inputs,
  lib,
  ...
}:
{
  flake-file = {
    inputs.niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixConfig = {
      extra-substituters = [
        "https://niri.cachix.org"
      ];
      extra-trusted-public-keys = [
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
  };
  den.aspects.niri = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.niri-flake.nixosModules.niri ];
        programs.niri.enable = true;
        services.displayManager.defaultSession = lib.mkForce "niri";

        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [
            xdg-desktop-portal-gnome
            xdg-desktop-portal-gtk
          ];
          config.niri = {
            default = [
              "gnome"
              "gtk"
            ];
            "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          };
        };

        services.gnome.gnome-keyring.enable = true;
      };
    homeManager =
      {
        osConfig ? null,
        pkgs,
        ...
      }:
      {
        imports = lib.optional (
          !(osConfig.programs.niri.enable or false)
        ) inputs.niri-flake.homeModules.niri;

        home.packages = with pkgs; [
          wl-clipboard
          wlsunset
          brightnessctl
          playerctl
          grim
          slurp
          wireplumber
          xdg-utils
          xwayland-satellite
        ];

        programs.niri.settings = {
          prefer-no-csd = true;

          input = {
            keyboard.numlock = true;
            touchpad = {
              tap = true;
              natural-scroll = true;
              dwt = true;
              drag = true;
              drag-lock = true;
            };
            mouse.accel-profile = "flat";
            warp-mouse-to-focus.enable = true;
            focus-follows-mouse.enable = true;
          };

          gestures.hot-corners.enable = false;

          outputs."eDP-1".scale = 1.25;

          workspaces = {
            "1" = { };
            "2" = { };
            "3" = { };
            "4" = { };
            "5" = { };
            "6" = { };
            "7" = { };
            "8" = { };
            "9" = { };
          };

          layout = {
            background-color = "#161616"; # bridges startup gap before noctalia paints wallpaper
            gaps = 8;
            center-focused-column = "never";
            preset-column-widths = [
              { proportion = 1.0 / 3.0; }
              { proportion = 1.0 / 2.0; }
              { proportion = 2.0 / 3.0; }
            ];
            default-column-width.proportion = 1.0 / 2.0;
            focus-ring = {
              enable = true;
              width = 2;
              # TODO: stylix
              # active.color = "#7fc8ff";
              # inactive.color = "#505050";
            };
            border.enable = false;
            struts = {
              left = 0;
              right = 0;
              top = 0;
              bottom = 0;
            };
          };

          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

          hotkey-overlay.skip-at-startup = true;

          environment = {
            NIXOS_OZONE_WL = "1";
          };

          spawn-at-startup = [
            { command = [ "noctalia-shell" ]; }
          ];

          animations.enable = true;

          window-rules = [
            {
              geometry-corner-radius =
                let
                  r = 8.0;
                in
                {
                  top-left = r;
                  top-right = r;
                  bottom-left = r;
                  bottom-right = r;
                };
              clip-to-geometry = true;
            }
          ];

          binds =
            let
              sh = cmd: { spawn-sh = cmd; };
              run = cmd: { spawn = [ cmd ]; };
            in
            {
              # Apps
              "Mod+Return".action = run "ghostty";
              "Mod+D".action = sh "noctalia-shell ipc call launcher toggle";
              # TODO: set yazi as default file-manager
              "Mod+E".action = sh "xdg-open ~";

              # Voxtype push-to-talk (compositor bind consumes the key so it
              # never leaks to the focused app; built-in evdev hotkey is off).
              "Ctrl+F12".action = sh "voxtype record toggle";

              # Session
              "Mod+Shift+E".action.quit = [ ];
              "Mod+Shift+P".action.power-off-monitors = [ ];
              "Super+Alt+L".action = sh "noctalia-shell ipc call lockScreen lock";

              # Window management
              "Mod+Q".action.close-window = [ ];
              "Mod+Shift+F".action.fullscreen-window = [ ];
              "Mod+V".action.toggle-window-floating = [ ];
              "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];
              "Mod+M".action.maximize-column = [ ];
              "Mod+C".action.center-column = [ ];
              "Mod+W".action.toggle-column-tabbed-display = [ ];
              "Mod+Tab".action.toggle-overview = [ ];

              # Focus
              "Mod+H".action.focus-column-left = [ ];
              "Mod+L".action.focus-column-right = [ ];
              "Mod+J".action.focus-window-down = [ ];
              "Mod+K".action.focus-window-up = [ ];
              "Mod+Left".action.focus-column-left = [ ];
              "Mod+Right".action.focus-column-right = [ ];
              "Mod+Down".action.focus-window-down = [ ];
              "Mod+Up".action.focus-window-up = [ ];
              "Mod+Home".action.focus-column-first = [ ];
              "Mod+End".action.focus-column-last = [ ];
              "Mod+Ctrl+H".action.focus-monitor-left = [ ];
              "Mod+Ctrl+L".action.focus-monitor-right = [ ];

              # Move
              "Mod+Shift+H".action.move-column-left = [ ];
              "Mod+Shift+L".action.move-column-right = [ ];
              "Mod+Shift+J".action.move-window-down = [ ];
              "Mod+Shift+K".action.move-window-up = [ ];
              "Mod+Shift+Home".action.move-column-to-first = [ ];
              "Mod+Shift+End".action.move-column-to-last = [ ];
              "Mod+Ctrl+Shift+H".action.move-column-to-monitor-left = [ ];
              "Mod+Ctrl+Shift+L".action.move-column-to-monitor-right = [ ];

              # Resize
              "Mod+R".action.switch-preset-column-width = [ ];
              "Mod+Shift+R".action.switch-preset-column-width-back = [ ];
              "Mod+F".action.maximize-column = [ ];
              "Mod+Minus".action.set-column-width = "-10%";
              "Mod+Equal".action.set-column-width = "+10%";
              "Mod+Shift+Minus".action.set-window-height = "-10%";
              "Mod+Shift+Equal".action.set-window-height = "+10%";
              "Mod+Ctrl+R".action.reset-window-height = [ ];

              # Consume/expel
              "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
              "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
              "Mod+I".action.consume-window-into-column = [ ];
              "Mod+O".action.expel-window-from-column = [ ];

              # Workspaces
              "Mod+U".action.focus-workspace-down = [ ];
              "Mod+P".action.focus-workspace-up = [ ];
              "Mod+Ctrl+U".action.move-column-to-workspace-down = [ ];
              "Mod+Ctrl+P".action.move-column-to-workspace-up = [ ];
              "Mod+1".action.focus-workspace = 1;
              "Mod+2".action.focus-workspace = 2;
              "Mod+3".action.focus-workspace = 3;
              "Mod+4".action.focus-workspace = 4;
              "Mod+5".action.focus-workspace = 5;
              "Mod+6".action.focus-workspace = 6;
              "Mod+7".action.focus-workspace = 7;
              "Mod+8".action.focus-workspace = 8;
              "Mod+9".action.focus-workspace = 9;
              "Mod+Shift+1".action.move-column-to-workspace = 1;
              "Mod+Shift+2".action.move-column-to-workspace = 2;
              "Mod+Shift+3".action.move-column-to-workspace = 3;
              "Mod+Shift+4".action.move-column-to-workspace = 4;
              "Mod+Shift+5".action.move-column-to-workspace = 5;
              "Mod+Shift+6".action.move-column-to-workspace = 6;
              "Mod+Shift+7".action.move-column-to-workspace = 7;
              "Mod+Shift+8".action.move-column-to-workspace = 8;
              "Mod+Shift+9".action.move-column-to-workspace = 9;

              # Scroll
              "Mod+WheelScrollDown" = {
                cooldown-ms = 150;
                action.focus-workspace-down = [ ];
              };
              "Mod+WheelScrollUp" = {
                cooldown-ms = 150;
                action.focus-workspace-up = [ ];
              };
              "Mod+WheelScrollRight".action.focus-column-right = [ ];
              "Mod+WheelScrollLeft".action.focus-column-left = [ ];
              "Mod+Shift+WheelScrollDown" = {
                cooldown-ms = 150;
                action.move-column-to-workspace-down = [ ];
              };
              "Mod+Shift+WheelScrollUp" = {
                cooldown-ms = 150;
                action.move-column-to-workspace-up = [ ];
              };
              "Mod+Ctrl+WheelScrollDown".action.focus-column-right = [ ];
              "Mod+Ctrl+WheelScrollUp".action.focus-column-left = [ ];

              # Screenshots
              "Print".action.screenshot = [ ];
              "Ctrl+Print".action.screenshot-screen = [ ];
              "Alt+Print".action.screenshot-window = [ ];

              # Hotkey overlay
              "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];

              # Media
              "XF86AudioRaiseVolume" = {
                allow-when-locked = true;
                action.spawn = [
                  "wpctl"
                  "set-volume"
                  "@DEFAULT_AUDIO_SINK@"
                  "0.05+"
                ];
              };
              "XF86AudioLowerVolume" = {
                allow-when-locked = true;
                action.spawn = [
                  "wpctl"
                  "set-volume"
                  "@DEFAULT_AUDIO_SINK@"
                  "0.05-"
                ];
              };
              "XF86AudioMute" = {
                allow-when-locked = true;
                action.spawn = [
                  "wpctl"
                  "set-mute"
                  "@DEFAULT_AUDIO_SINK@"
                  "toggle"
                ];
              };
              "XF86AudioMicMute" = {
                allow-when-locked = true;
                action.spawn = [
                  "wpctl"
                  "set-mute"
                  "@DEFAULT_AUDIO_SOURCE@"
                  "toggle"
                ];
              };
              "XF86AudioPlay".action.spawn = [
                "playerctl"
                "play-pause"
              ];
              "XF86AudioPrev".action.spawn = [
                "playerctl"
                "previous"
              ];
              "XF86AudioNext".action.spawn = [
                "playerctl"
                "next"
              ];

              "XF86MonBrightnessUp" = {
                allow-when-locked = true;
                action.spawn = [
                  "brightnessctl"
                  "set"
                  "5%+"
                ];
              };
              "XF86MonBrightnessDown" = {
                allow-when-locked = true;
                action.spawn = [
                  "brightnessctl"
                  "set"
                  "5%-"
                ];
              };
            };
        };
      };
  };
}
