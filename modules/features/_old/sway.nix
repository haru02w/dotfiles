{ den, ... }:
{
  den.aspects.sway.homeManager =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      from0to9 = attr: builtins.listToAttrs (builtins.genList (i: attr (toString i)) 10);
    in
    {
      home.sessionVariables.NIXOS_OZONE_WL = "1";
      home.packages = with pkgs; [ swaysome ];

      wayland.windowManager.sway = {
        enable = true;
        extraOptions = [ "--unsupported-gpu" ];
        systemd.enable = true;
        extraConfig = ''
          hide_edge_borders --i3 smart_no_gaps
        '';
        config = {
          bars = [ ];
          focus = {
            wrapping = "yes";
            mouseWarping = "container";
            followMouse = "yes";
          };
          window = {
            border = 1;
            titlebar = false;
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
            "*" = {
              xkb_layout = "'us'";
              xkb_options = "'compose:ralt,altwin:swap_lalt_lwin,ctrl:nocaps'";
            };
          };
          startup = [
            {
              command = "${pkgs.swaysome}/bin/swaysome init 1";
              always = true;
            }
          ];
          bindkeysToCode = true;
          keybindings =
            let
              inherit (config.wayland.windowManager.sway.config) modifier;
              inherit (config.wayland.windowManager.sway.config)
                left
                down
                up
                right
                ;
            in
            lib.mkOptionDefault (
              from0to9 (i: lib.nameValuePair "${modifier}+${i}" "exec '${pkgs.swaysome}/bin/swaysome focus ${i}'")
              // from0to9 (
                i: lib.nameValuePair "${modifier}+Shift+${i}" "exec '${pkgs.swaysome}/bin/swaysome move ${i}'"
              )
              // from0to9 (
                i: lib.nameValuePair "${modifier}+Alt+${i}" "exec '${pkgs.swaysome}/bin/swaysome focus-group ${i}'"
              )
              // from0to9 (
                i:
                lib.nameValuePair "${modifier}+Alt+Shift+${i}" "exec '${pkgs.swaysome}/bin/swaysome move-to-group ${i}'"
              )
              // {
                "${modifier}+o" = "exec '${pkgs.swaysome}/bin/swaysome next-output'";
                "${modifier}+Shift+o" = "exec '${pkgs.swaysome}/bin/swaysome prev-output'";

                "${modifier}+Alt+o" = "exec '${pkgs.swaysome}/bin/swaysome workspace-group-next-output'";
                "${modifier}+Alt+Shift+o" = "exec '${pkgs.swaysome}/bin/swaysome workspace-group-prev-output'";

                "${modifier}+Shift+q" = null;
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

                "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
                "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
                "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
                "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

                "Print" =
                  "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot savecopy area ${config.xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR}/$(date +'%s.png')";
                "XF86AudioRaiseVolume" =
                  "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.0";
                "XF86AudioLowerVolume" =
                  "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- -l 1.0";
                "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s +5%";
                "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
              }
            );
          modes.resize = { };
        };
      };

      xdg.userDirs = {
        enable = true;
        createDirectories = true;
        extraConfig.XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/.screenshots";
      };
    };
}
