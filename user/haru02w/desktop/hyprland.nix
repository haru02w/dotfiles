{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    exec-once = "${pkgs.waybar}/bin/waybar";

    monitor = ",preferred,auto,1.15";

    input = {
      kb_layout = "us";
      kb_options = "compose:ralt, altwin:swap_lalt_lwin";

      follow_mouse = 1;
      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.3;
        drag_lock = true;
      };

      sensitivity = 0.2;
    };

    general = {
      gaps_in = 4;
      gaps_out = 4;
      border_size = 2;

      layout = "dwindle";
      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false;
    };

    decoration = {
      rounding = 10;
      #blur = false;
      drop_shadow = false;
    };

    animations = {
      enabled = true;

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [ 
        "windows, 1, 5, myBezier"
        "windowsOut, 1, 5, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 4, default"
        "workspaces, 1, 4, default"
      ];
    };
    dwindle = {
      no_gaps_when_only = true;
      pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true; # you probably want this
      force_split = 2;
    };

    gestures.workspace_swipe = true;

    misc = {
      vfr = true;
      force_default_wallpaper = -1;
    };

    binde = [
        "$mod CTRL, H, resizeactive, -40 0"
        "$mod CTRL, J, resizeactive, 0 40"
        "$mod CTRL, K, resizeactive, 0 -40"
        "$mod CTRL, L, resizeactive, 40 0"
    ];

    bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
    ];

    bind =
      [
        "$mod, Return, exec, ${pkgs.alacritty}/bin/alacritty" #pkgs.
        "$mod, W, killactive"
        "$mod SHIFT, Q, exit"
        "$mod, V, togglefloating"
        "$mod, R, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun" #pkgs.
        "$mod, D, exec, ${pkgs.rofi-wayland}/bin/rofi -show run" #pkgs.
        "$mod, P, pseudo" # dwindle

        "$mod SHIFT, Space, togglesplit"
        "$mod CTRL, Space, workspaceopt, allfloat"

        "$mod, H, movefocus, l"
        "$mod, J, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, d"

        "$mod, period, focusmonitor, +1"
        "$mod, comma, focusmonitor, -1"

        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"

        "$mod SHIFT, comma, movewindow, mon:-1"
        "$mod SHIFT, period, movewindow, mon:+1"


        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
  };
}
