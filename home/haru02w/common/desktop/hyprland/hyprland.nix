{ inputs, lib, pkgs, config, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    plugins = with inputs;
      [
        split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      ];
  };
  wayland.windowManager.hyprland.settings = let
    laptop-monitor-name = "eDP-1";
    laptop-monitor = "${laptop-monitor-name},1920x1080@60,auto,1.2";
  in {
    exec-once = "${config.programs.waybar.package}/bin/waybar";
    monitor = [ laptop-monitor ",preferred,auto,1" ];

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
    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
    };

    dwindle = {
      no_gaps_when_only = true;
      pseudotile =
        true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true; # you probably want this
      force_split = 2;
    };

    misc = {
      vfr = true;
      vrr = 2;
      # disable_hyprland_logo = true;
      # disable_splash_rendering = true;
      force_default_wallpaper = 2;
      key_press_enables_dpms = true;
      mouse_move_enables_dpms = true;
    };

    general = {
      gaps_in = 3;
      gaps_out = 3;
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
    # keybinds
    "$mod" = "SUPER";
    binde = [
      ("$mod, Return, exec, ${pkgs.foot}/bin/footclient ${
          lib.optionalString (lib.elem pkgs.tmux config.home.packages)
          "${pkgs.tmux}/bin/tmux"
        }")

      "$mod, W, killactive"
      "$mod CTRL, H, resizeactive, -40 0"
      "$mod CTRL, J, resizeactive, 0 40"
      "$mod CTRL, K, resizeactive, 0 -40"
      "$mod CTRL, L, resizeactive, 40 0"
    ];
    bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
    bindle = [
      ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.0"
      ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- -l 1.0"
      ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s +2%"
      ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 2%-"
    ];
    bind = [
      # WARN: fan profiles
      ", XF86Launch4, exec, ${pkgs.asusctl}/bin/asusctl profile -n; ${pkgs.procps}/bin/pkill -RTMIN+8 waybar"
      ", XF86KbdBrightnessUp, exec, ${pkgs.asusctl}/bin/asusctl -n"
      ", XF86KbdBrightnessDown, exec, ${pkgs.asusctl}/bin/asusctl -p"

      "$mod SHIFT, Q, exit"
      "$mod, Q, exec, ${pkgs.procps}/bin/pkill -9 waybar"
      "$mod, V, togglefloating"
      "$mod, D, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun -show-icons" # pkgs.
      "$mod, R, exec, ${pkgs.rofi-wayland}/bin/rofi -show run" # pkgs.
      "$mod, P, pseudo" # dwindle

      "$mod SHIFT, Space, togglesplit"
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, d"

      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, J, movewindow, d"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, L, movewindow, r"

      "$mod, bracketleft, focusmonitor, -1"
      "$mod, bracketright, focusmonitor, +1"

      "$mod SHIFT, bracketleft, movewindow, mon:-1"
      "$mod SHIFT, bracketright, movewindow, mon:+1"

      "$mod, mouse_down, split-workspace, e+1"
      "$mod, mouse_up, split-workspace, e-1"

      ", Print, exec, ${pkgs.grimblast}/bin/grimblast copysave area ~/.screenshots/$(date +'%s.png')"

      "$mod, 1, split-workspace, 1"
      "$mod, 2, split-workspace, 2"
      "$mod, 3, split-workspace, 3"
      "$mod, 4, split-workspace, 4"
      "$mod, 5, split-workspace, 5"
      "$mod, 6, split-workspace, 6"
      "$mod, 7, split-workspace, 7"
      "$mod, 8, split-workspace, 8"
      "$mod, 9, split-workspace, 9"
      "$mod, 0, split-workspace, 10"

      "$mod SHIFT, 1, split-movetoworkspace, 1"
      "$mod SHIFT, 2, split-movetoworkspace, 2"
      "$mod SHIFT, 3, split-movetoworkspace, 3"
      "$mod SHIFT, 4, split-movetoworkspace, 4"
      "$mod SHIFT, 5, split-movetoworkspace, 5"
      "$mod SHIFT, 6, split-movetoworkspace, 6"
      "$mod SHIFT, 7, split-movetoworkspace, 7"
      "$mod SHIFT, 8, split-movetoworkspace, 8"
      "$mod SHIFT, 9, split-movetoworkspace, 9"
      "$mod SHIFT, 0, split-movetoworkspace, 10"
    ];
    bindl = [
      ",switch:off:Lid Switch, exec, hyprctl keyword monitor '${laptop-monitor}'"
      ",switch:on:Lid Switch, exec, hyprctl keyword monitor '${laptop-monitor-name}, disable'"
    ];
  };
}
