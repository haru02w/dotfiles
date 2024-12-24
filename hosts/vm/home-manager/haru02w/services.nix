{
  pkgs,
  config,
  lib,
  ...
}: {
  # Media Player buttons functionallity (playerctl)
  services.playerctld.enable = true;
  services.mpris-proxy.enable = true;

  # Enable automounting in /run/media/$USER/
  # OBS: The following option at nixos config must be enabled
  # 'services.udisks2.enable = true'
  services.udiskie = {
    enable = true;
    tray = "auto";
    notify = true;
    automount = true;
    settings = {
      device_config = [
        {
          id_label = "VTOYEFI";
          ignore = true;
        }
      ];
    };
  };

  # Swaylock and SwayIdle
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      indicator = true;
      indicator-radius = 128;

      daemonize = true;
      font-size = 48;

      clock = true;
      datestr = "%a, %B %e";
      timestr = "%H:%M %p";

      fade-in = 1;
      effect-blur = "15x15";
      effect-vignette = "1:1";
    };
  };
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${lib.getExe config.programs.swaylock.package} -efF";
      }
    ];
    timeouts = [
      {
        timeout = 900;
        command = "${lib.getExe config.wayland.windowManager.sway.package} -efF";
      }
      {
        timeout = 960;
        command = "${lib.getExe' config.wayland.windowManager.sway.package "swaymsg"} 'output * dpms off'";
        resumeCommand = "${lib.getExe' config.wayland.windowManager.sway.package "swaymsg"} 'output * dpms on'";
      }
    ];
  };

  # Sway
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  home.packages = with pkgs; [swaysome];
  wayland.windowManager.sway = {
    enable = true;
    # package = pkgs.swayfx;
    # checkConfig = false;
    extraOptions = ["--unsupported-gpu"];
    systemd.enable = true;
    extraConfig = ''
      hide_edge_borders --i3 smart_no_gaps
    '';
    config = {
      bars = [];
      focus = {
        wrapping = "yes";
        mouseWarping = "container";
        followMouse = "yes";
      };

      window = {
        border = 1;
        titlebar = false;
        # hideEdgeBorders = "smart"; # WARN: on extraConfig
      };

      defaultWorkspace = "workspace number 1";

      terminal = "${lib.getExe' config.programs.foot.package "footclient"}";
      menu = "${lib.getExe config.programs.rofi.package} -show drun -show-icons";
      modifier = "Mod4";
      floating.modifier = "Mod4";
      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
          drag_lock = "enabled";
          scroll_factor = "0.3";
        };
      };
      startup = [
        {
          command = "${pkgs.swaysome}/bin/swaysome init 1";
          always = true;
        }
      ];
      bindkeysToCode = true;
      keybindings = let
        inherit (config.wayland.windowManager.sway.config) modifier;
        inherit (config.wayland.windowManager.sway.config) left down up right;
        from0to9 = attr:
          builtins.listToAttrs (builtins.genList (i: attr (toString i)) 10);
      in
        lib.mkOptionDefault (
          # Change focus between workspaces
          from0to9 (i: lib.nameValuePair "${modifier}+${i}" "exec '${pkgs.swaysome}/bin/swaysome focus ${i}'")
          //
          # Move containers between workspaces
          from0to9 (i: lib.nameValuePair "${modifier}+Shift+${i}" "exec '${pkgs.swaysome}/bin/swaysome move ${i}'")
          # Focus workspace groups
          // from0to9 (i: lib.nameValuePair "${modifier}+Alt+${i}" "exec '${pkgs.swaysome}/bin/swaysome focus-group ${i}'")
          # Move containers to other workspace groups
          // from0to9 (i: lib.nameValuePair "${modifier}+Alt+Shift+${i}" "exec '${pkgs.swaysome}/bin/swaysome move-to-group ${i}'")
          // {
            "${modifier}+o" = "exec '${pkgs.swaysome}/bin/swaysome next-output'";
            "${modifier}+Shift+o" = "exec '${pkgs.swaysome}/bin/swaysome prev-output'";

            "${modifier}+Alt+o" = "exec '${pkgs.swaysome}/bin/swaysome workspace-group-next-output'";
            "${modifier}+Alt+Shift+o" = "exec '${pkgs.swaysome}/bin/swaysome workspace-group-prev-output'";
            # Disable keybindings
            "${modifier}+Shift+q" = null;
            # Enable keybindings

            "${modifier}+q" = "kill";
            "${modifier}+equal" = "focus output up";
            "${modifier}+bracketleft" = "focus output left";
            "${modifier}+bracketright" = "focus output right";
            "${modifier}+apostrophe" = "focus output down";

            "${modifier}+Ctrl+${left}" = "resize shrink width 40 px";
            "${modifier}+Ctrl+${down}" = "resize grow height 40 px";
            "${modifier}+Ctrl+${up}" = "resize shrink height 40 px";
            "${modifier}+Ctrl+${right}" = "resize grow width 40 px";

            "${modifier}+Ctrl+left" = "resize shrink width 40 px";
            "${modifier}+Ctrl+down" = "resize grow height 40 px";
            "${modifier}+Ctrl+up" = "resize shrink height 40 px";
            "${modifier}+Ctrl+right" = "resize grow width 40 px";

            # Media keybindings
            "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
            "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
            "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
            "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
            # Laptop's keybindings
            "Print" = "exec ${pkgs.grimblast}/bin/grimblast copysave area ~/.screenshots/$(date +'%s.png')";
            "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.0";
            "XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- -l 1.0";
            "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s +5%";
            "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
          }
        );
      modes.resize = {};
    };
  };
}
