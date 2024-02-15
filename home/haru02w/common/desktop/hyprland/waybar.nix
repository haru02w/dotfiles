{ config, pkgs, ... }: {
  programs.waybar = with config.colorScheme.palette; {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      layer = "top";
      position = "right";
      modules-left = [ "cpu" "memory" "battery" "custom/separator" "tray" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [
        "network"
        "bluetooth"
        "backlight"
        "pulseaudio"
        "custom/separator"
        "clock"
      ];
      "hyprland/workspaces" = {
        all-outputs = false;
        format = "{id}";
        sort-by-number = true;
      };
      "clock" = {
        format = ''
          {:%H
          %M}'';
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };
      /* "custom/fanprofiles" = {
           interval = "once";
           signal = 8;
           format = "{}";
           exec-on-event = false;
           on-click =
             "${pkgs.asusctl}/bin/asusctl profile -n; ${pkgs.procps}/bin/pkill -RTMIN+8 waybar";
           exec = "~/.config/waybar/fanprofiles.sh"; # WARN: use lib.shellScript
           escape = true;
         };
      */
      "custom/separator" = { format = "───"; };
      "cpu" = {
        format = "󰍛 {icon}";
        format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
      };
      "memory" = {
        format = " {icon}";
        format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        tooltip = true;
        tooltip-format = "{used}/{total}, {percentage}% used";
      };
      "backlight" = {
        format = "{icon}";
        format-icons = [ "" "" "" "" "" "" "" "" "" ];
        tooltip = true;
        tooltip-format = "{percent}%";
      };
      "pulseaudio" = {
        format = "󱄠 {icon}";
        format-bluetooth = "󱄠 {icon}";
        format-muted = "󰸈";
        format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        tooltip = true;
        tooltip-format = "{volume}%";
      };
      "battery" = {
        format = "<span color='#FF0000'>󱐋</span> {icon}";
        format-charging = "<span color='#00FF00'>󱐋</span> {icon}";
        tooltip = true;
        tooltip-format = "{capacity}%";
        states = {
          warning = 30;
          critical = 15;
        };
        format-icons = [ "" "" "" "" "" ];
      };
      "network" = {
        format = "";
        format-ethernet = "󰈁";
        format-wifi = "{icon}";
        format-disconnected = "󰈂";
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        tooltip = true;
        tooltip-format = ''
          {essid}
          {signalStrength} UP:{bandwidthUpBytes} DOWN:{bandwidthDownBytes}'';
        on-click = "${pkgs.networkmanager_dmenu}/bin/networkmanager_dmenu";
      };
      "bluetooth" = {
        format = "";
        format-on = "󰂯";
        format-off = "󰂲";
        format-disabled = "󰂲";
        format-connected = "󰂱";
        on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
      };
    };

    style = ''
      * {
        padding: 0;
      	/* border-radius: .8rem; */
      	font-family: ${config.fontProfiles.regular.family},${config.fontProfiles.monospace.family};
      	font-size: 1.2rem;
      }

      window#waybar {
        padding: 0;
        margin-left: .2rem;
      	background-color: transparent;
        color: #${base05};
      }

      tooltip {
      	background-color: #${base00};
      }

      tooltip label {
      	color: #${base05};
      }

      .modules-left {
      	background-color: #${base00};
      	border-radius: .8rem;
      	padding: .2rem 0;
      	margin-left: .2rem;
      }

      .modules-center {
      	background-color: #${base00};
      	border-radius: .8rem;
      	padding: .2rem 0;
      	margin-left: .2rem;
      }

      .modules-right {
      	background-color: #${base00};
      	border-radius: .8rem;
      	padding: .2rem 0;
      	margin-left: .2rem;
      }

      #workspaces button {
        color: #${base05};
      	border: .1rem solid transparent;
      	padding: 0;
      }

      #workspaces button.active {
      	color: #${base0D};
      }

      #workspaces button:hover {
      	background: transparent;
      	border: .1rem solid #${base0D};
      }

      #cpu,
      #memory,
      #battery,
      #tray,
      #network,
      #bluetooth,
      #backlight,
      #pulseaudio,
      #clock {
      	padding: .1rem;
      }
    '';
  };
}
