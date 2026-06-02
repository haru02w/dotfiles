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
  };
  den.aspects.mango = {
    nixos =
      { ... }:
      {
        imports = [ inputs.mango.nixosModules.mango ];
        # programs.mango.enable also wires up xdg-desktop-portal (wlr) and
        # gnome-keyring as the Secret portal, so no extra portal config needed here.
        programs.mango.enable = true;
        services.displayManager.defaultSession = lib.mkForce "mango";
      };
    homeManager =
      { pkgs, ... }:
      {
        # mango's nixos and home-manager modules are disjoint (programs.mango vs
        # wayland.windowManager.mango), so always import the HM module and enable
        # it here — config is only generated when enable = true.
        imports = [ inputs.mango.hmModules.mango ];

        home.packages = with pkgs; [
          wl-clipboard
          wlsunset
          brightnessctl
          playerctl
          grim
          slurp
          wireplumber
          xdg-utils
        ];

        wayland.windowManager.mango = {
          enable = true;

          # runs at compositor startup (no shebang needed)
          autostart_sh = ''
            noctalia-shell &
          '';

          settings = {
            # Input
            repeat_rate = 25;
            repeat_delay = 600;
            numlockon = 1;
            xkb_rules_layout = "us";
            tap_to_click = 1;
            tap_and_drag = 1;
            drag_lock = 1;
            trackpad_natural_scrolling = 1;
            disable_while_typing = 1;
            sloppyfocus = 1;

            # Layout
            new_is_master = 1;
            smartgaps = 0;
            gappih = 8;
            gappiv = 8;
            gappoh = 8;
            gappov = 8;
            borderpx = 2;

            env = [
              "NIXOS_OZONE_WL,1"
            ];

            bind = [
              # Apps
              "SUPER,Return,spawn,ghostty"
              "SUPER,d,spawn,noctalia-shell ipc call launcher toggle"
              "SUPER,e,spawn,xdg-open ~"

              # Session
              "SUPER+SHIFT,e,quit"
              "SUPER+ALT,l,spawn,noctalia-shell ipc call lockScreen lock"

              # Window management
              "SUPER,q,killclient,"
              "SUPER+SHIFT,f,togglefullscreen,"
              "SUPER,v,togglefloating,"
              "SUPER,Tab,focusstack,next"

              # Focus
              "SUPER,h,focusdir,left"
              "SUPER,l,focusdir,right"
              "SUPER,j,focusdir,down"
              "SUPER,k,focusdir,up"

              # Move
              "SUPER+SHIFT,h,exchange_client,left"
              "SUPER+SHIFT,l,exchange_client,right"
              "SUPER+SHIFT,j,exchange_client,down"
              "SUPER+SHIFT,k,exchange_client,up"

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
              "SUPER,r,reload_config"

              # Media
              "l,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"
              "l,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"
              "l,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
              "l,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
              "XF86AudioPlay,spawn,playerctl play-pause"
              "XF86AudioPrev,spawn,playerctl previous"
              "XF86AudioNext,spawn,playerctl next"
              "l,XF86MonBrightnessUp,spawn,brightnessctl set 5%+"
              "l,XF86MonBrightnessDown,spawn,brightnessctl set 5%-"
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
