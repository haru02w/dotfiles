{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v2.sway;
  inherit (lib) getExe;
in {
  options.modules.presets.desktop-v2.sway = {
    enable = mkEnableOption "desktop-v2 sway";
    extraKeybindings = mkOption {
      type = types.attrsOf (types.nullOr types.str);
      example = literalExpression ''
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in {
          "''${modifier}+Return" = "exec ${cfg.config.terminal}";
          "''${modifier}+Shift+q" = "kill";
          "''${modifier}+d" = "exec ${cfg.config.menu}";
        }
      '';
    };
    keymap = with types; {
      layout = mkOption {
        type = str;
        default = "us";
        example = "us";
      };
      variant = mkOption {
        type = str;
        default = "";
      };
      options = mkOption {
        type = str;
        default = "compose:ralt, altwin:swap_lalt_lwin, ctrl:nocaps";
      };
    };
  };

  config = mkIf cfg.enable {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
    wayland.windowManager.sway = {
      enable = true;
      # package = pkgs.swayfx;
      # checkConfig = false;
      extraOptions = ["--unsupported-gpu"];
      systemd.enable = true;
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
          hideEdgeBorders = "smart";
        };
        defaultWorkspace = "workspace number 1";
        workspaceAutoBackAndForth = true;

        terminal = "${getExe config.programs.foot.package}";
        menu = "${getExe config.programs.rofi.package} -show drun -show-icons";
        modifier = "Mod4";
        floating.modifier = "Mod4";
        input = {
          "*" = {
            xkb_layout = "'${cfg.keymap.layout}'";
            xkb_variant = "'${cfg.keymap.variant}'";
            xkb_options = "'${cfg.keymap.options}'";
          };

          "type:touchpad" = {
            natural_scroll = "enabled";
            tap = "enabled";
            drag_lock = "enabled";
            scroll_factor = "0.3";
          };
        };
        bindkeysToCode = true;
        keybindings = let
          inherit (config.wayland.windowManager.sway.config) modifier;
          inherit (config.wayland.windowManager.sway.config) left down up right;
        in
          lib.mkOptionDefault ({
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

              # Laptop's keybindings
              "Print" = "exec ${pkgs.grimblast}/bin/grimblast copysave area ~/.screenshots/$(date +'%s.png')";
              "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+ -l 1.0";
              "XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%- -l 1.0";
              "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
              "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s +5%";
              "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
            }
            // cfg.extraKeybindings);
        modes.resize = {};
      };
    };
  };
}
