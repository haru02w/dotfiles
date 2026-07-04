{
  inputs,
  lib,
  ...
}:
{
  flake-file = {
    inputs.mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    inputs.wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  den.aspects.mango = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.mango.nixosModules.mango ];
        # programs.mango.enable also wires up xdg-desktop-portal (wlr) and gnome-keyring Secret portal.
        programs.mango.enable = true;
        programs.mango.package = pkgs.mango;
        services.displayManager.defaultSession = lib.mkForce "mango";
      };
    homeManager =
      {
        osConfig ? null,
        pkgs,
        ...
      }:
      let
        xkb = osConfig.services.xserver.xkb or { };
        # No arg -> full, "region" -> frozen drag-select, "window" -> focused.
        screenshot = pkgs.writeShellScript "mango-screenshot" ''
          mkdir -p "$HOME/Pictures/Screenshots"
          f="$HOME/Pictures/Screenshots/Screenshot from $(date "+%Y-%m-%d %H-%M-%S").png"
          shot() { grim "$@" - | tee "$f" | wl-copy -t image/png; }
          case "$1" in
            __grab) g=$(slurp) && [ -n "$g" ] && shot -g "$g"; ${pkgs.procps}/bin/pkill -x wayfreeze ;;
            region) ${pkgs.wayfreeze}/bin/wayfreeze --hide-cursor --after-freeze-cmd "$0 __grab" ;;
            window) g=$(mmsg get focusing-client | jq -r '"\(.x),\(.y) \(.width)x\(.height)"') && [ -n "$g" ] && shot -g "$g" ;;
            *) shot ;;
          esac
        '';
      in
      {
        # mango's nixos and HM modules are disjoint; import the HM module here, config gated on enable.
        imports = [
          inputs.mango.hmModules.mango
          inputs.wayland-pipewire-idle-inhibit.homeModules.default
        ];

        # Emit a wayland idle-inhibitor while PipeWire plays media, so noctalia won't lock during video.
        services.wayland-pipewire-idle-inhibit = {
          enable = true;
          systemdTarget = "graphical-session.target";
          settings.idle_inhibitor = "wayland";
        };

        home.packages = with pkgs; [
          wl-clipboard
          wlsunset
          brightnessctl
          playerctl
          grim
          slurp
          jq
          wireplumber
          xdg-utils
        ];

        wayland.windowManager.mango = {
          enable = true;
          package = pkgs.mango;

          # wl-clip-persist keeps the selection alive after the source window closes (wlroots frees it on exit).
          autostart_sh = ''
            ${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular &
            noctalia &
          '';

          settings = {
            # Input
            numlockon = 1;
            # mango ignores XKB_DEFAULT_OPTIONS; pull xkb from locale.nix so Mod follows the alt/super swap.
            xkb_rules_layout = xkb.layout or "us";
            xkb_rules_options = xkb.options or "";
            trackpad_natural_scrolling = 1;
            mouse_accel_profile = 2;
            mouse_accel_speed = 0.0;
            trackpad_accel_profile = 2;
            trackpad_accel_speed = 0.0;

            # eDP-1 at origin (scale 1.25); Samsung centered above it at x:-192,y:-1080 (negative coords ok, no XWayland).
            monitorrule = [
              "make:Samsung Electric Company,model:C27F390,serial:HX5NA00324,x:-192,y:-1080"
              "name:^eDP-1$,x:0,y:0,scale:1.25"
            ];

            # General Layout
            # gappih = 8;
            # gappiv = 8;
            # gappoh = 8;
            # gappov = 8;
            # borderpx = 2;
            border_radius = 6;
            no_radius_when_single = 1;
            no_border_when_single = 1;
            focus_cross_monitor = 1;
            enable_floating_snap = 1;
            enable_hotarea = 0;

            # Master Layout
            new_is_master = 1;
            smartgaps = 1;
            # Scroll Layout
            scroller_default_proportion = 0.5;

            # Animations (defaults are 350-800ms, too slow)
            animation_type_open = "zoom";
            animation_type_close = "zoom";
            tag_animation_direction = 0; # vertical
            animation_duration_move = 200;
            animation_duration_open = 200;
            animation_duration_tag = 200;
            animation_duration_close = 200;

            env = [
              "NIXOS_OZONE_WL,1"
            ];

            bind = [
              # Apps
              "SUPER,Return,spawn,ghostty"
              "SUPER,d,spawn,noctalia msg panel-toggle launcher"
              "SUPER,c,spawn,noctalia msg panel-toggle launcher /clip"
              "SUPER,e,spawn,xdg-open ~"

              # Voxtype push-to-talk (ignore if non existent)
              "CTRL,slash,spawn,voxtype record toggle"

              # Session
              "SUPER+SHIFT,e,quit"
              "SUPER+ALT,l,spawn,noctalia msg session lock"

              # Window management
              "SUPER,q,killclient,"
              "SUPER,f,togglemaximizescreen,"
              "SUPER+SHIFT,f,togglefullscreen,"
              "SUPER,v,togglefloating,"
              "SUPER,Tab,toggleoverview,"
              "SUPER,n,switch_layout,"
              "SUPER,s,setlayout,scroller"
              "SUPER,m,setlayout,tile"
              "SUPER+SHIFT,c,centerwin,"
              "SUPER,i,minimized,"
              "SUPER+SHIFT,I,restore_minimized"
              "SUPER,z,toggle_scratchpad"

              # Focus
              "SUPER,h,focusdir,left"
              "SUPER,l,focusdir,right"
              "SUPER,j,focusdir,down"
              "SUPER,k,focusdir,up"
              "SUPER,Left,focusdir,left"
              "SUPER,Right,focusdir,right"
              "SUPER,Down,focusdir,down"
              "SUPER,Up,focusdir,up"

              # Focus monitor
              "SUPER+CTRL,h,focusmon,left"
              "SUPER+CTRL,l,focusmon,right"
              "SUPER+CTRL,j,focusmon,down"
              "SUPER+CTRL,k,focusmon,up"

              # Move
              "SUPER+SHIFT,h,exchange_client,left"
              "SUPER+SHIFT,l,exchange_client,right"
              "SUPER+SHIFT,j,exchange_client,down"
              "SUPER+SHIFT,k,exchange_client,up"

              # Move to monitor
              "SUPER+CTRL+SHIFT,h,tagmon,left"
              "SUPER+CTRL+SHIFT,l,tagmon,right"
              "SUPER+CTRL+SHIFT,j,tagmon,down"
              "SUPER+CTRL+SHIFT,k,tagmon,up"

              # Resize (niri's keys: Mod -/= width, Mod+Shift -/= height; px deltas)
              "SUPER,minus,resizewin,-50,0"
              "SUPER,equal,resizewin,+50,0"
              "SUPER+SHIFT,minus,resizewin,0,-50"
              "SUPER+SHIFT,equal,resizewin,0,+50"

              # Scroller stack ([ ] = left/right, { } = up/down)
              "SUPER,bracketleft,scroller_stack,left"
              "SUPER,bracketright,scroller_stack,right"
              "SUPER+SHIFT,bracketleft,scroller_stack,up"
              "SUPER+SHIFT,bracketright,scroller_stack,down"
              "SUPER+ALT,j,focusstack,next"
              "SUPER+ALT,k,focusstack,prev"

              # Workspaces (tags)
              "SUPER,1,view,1"
              "SUPER,2,view,2"
              "SUPER,3,view,3"
              "SUPER,4,view,4"
              "SUPER,5,view,5"
              "SUPER,6,view,6"
              "SUPER,7,view,7"
              "SUPER,8,view,8"
              "SUPER,9,view,9"
              "SUPER+SHIFT,1,tag,1"
              "SUPER+SHIFT,2,tag,2"
              "SUPER+SHIFT,3,tag,3"
              "SUPER+SHIFT,4,tag,4"
              "SUPER+SHIFT,5,tag,5"
              "SUPER+SHIFT,6,tag,6"
              "SUPER+SHIFT,7,tag,7"
              "SUPER+SHIFT,8,tag,8"
              "SUPER+SHIFT,9,tag,9"

              # System
              "SUPER+SHIFT,r,reload_config"

              # Screenshots (mango has no built-in tool; grim/slurp + mmsg)
              "NONE,Print,spawn,${screenshot} region"
              "CTRL,Print,spawn,${screenshot}"
              "ALT,Print,spawn,${screenshot} window"

              # Media playback
              "NONE,XF86AudioPlay,spawn,playerctl play-pause"
              "NONE,XF86AudioPrev,spawn,playerctl previous"
              "NONE,XF86AudioNext,spawn,playerctl next"
            ];

            # Lock-allowed binds (`bindl` = bind that fires while screen locked)
            bindl = [
              "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"
              "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"
              "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
              "NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
              "NONE,XF86MonBrightnessUp,spawn,brightnessctl set 5%+"
              "NONE,XF86MonBrightnessDown,spawn,brightnessctl set 5%-"
              "NONE,XF86KbdBrightnessUp,spawn,asusctl leds next"
              "NONE,XF86KbdBrightnessDown,spawn,asusctl leds prev"
              "NONE,XF86Launch4,spawn,asusctl profile next"
            ];

            # Mouse binds
            mousebind = [
              "SUPER,btn_left,moveresize,curmove"
              "SUPER,btn_right,moveresize,curresize"
            ];
          };
        };
      };
  };
}
