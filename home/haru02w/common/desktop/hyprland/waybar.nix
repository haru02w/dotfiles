{ config, ... }: {
  programs.waybar = with config.colorScheme.palette; {
    enable = true;
    systemd.enable = true;
    style = ''
      window#waybar {
        background-color: transparent;
        font-family: "${config.fontProfiles.regular.family}";
      }

      tooltip {
        background-color: #${base00};
      }

      tooltip label {
        color: #${base05}
      }

      #custom-nix {
        margin-top: 8px;
        margin-left: 8px;
        border-radius: 8px;
        border: 1.5px solid #${base04};
        background-color: #${base00};
        color: #${base0D};
        font-size: 18px;
        padding: 8px 22px 6px 14px;
      }

      #workspaces {
        margin-top: 8px;
        margin-left: 8px;
        border-radius: 8px;
        border: 1.5px solid #${base04};
        background-color: #${base00};
        padding: 4px;
        font-size: 14px;    
      }

      #workspaces button {
        color: #${base07};
        padding: 5px 11px 2px 9px;
      }

      #workspaces button:hover {
        background: #${base03};
      }

      #workspaces button.active{
        border-radius: 12px;
        background-color: #${base0C};
      }
            #clock {
        margin-top: 8px;
        margin-left: 8px;
        border-radius: 8px;
        border: 1.5px solid #${base04};
        background-color: #${base00};
        padding: 6px 8px 4px 8px;
        color: #${base09};
        font-size: 12px;
        font-weight: bold;
      }

      #tray {
        font-size: 20px;
        margin-top: 8px;
        margin-right: 8px;
        border-radius: 8px;
        border: 1.5px solid #${base04};
        padding: 8px 12px 6px 13px;
        background-color: #${base00};
        color: #${base00};
      }

      #cpu{
        margin-top: 8px;
        margin-right: 0px;
        border-radius: 8px 0px 0px 8px;
        border-width: 1.5px 0px 1.5px 1.5px;
        border-style: solid;
        border-color: #${base04};
        background-color: #${base00};
        padding: 8px 10px 6px 16px;
        color: #${base0B};
        font-size: 15px;
      }

      #memory {
        margin-top: 8px;
        border-radius: 0px;
        border-width: 1.5px 0px 1.5px 0px;
        border-style: solid;
        border-color: #${base04};
        background-color: #${base00};
        padding: 8px 10px 6px 10px;
        color: #${base0B};
        font-size: 15px;
      }

      #pulseaudio{
        margin-top: 8px;
        border-radius: 0px;
        border-width: 1.5px 0px 1.5px 0px;
        border-style: solid;
        border-color: #${base04};
        padding: 8px 16px 6px 10px;
        background-color: #${base00};
        color: #${base0A};
        font-size: 16px;
      }

      #network{
        margin-top: 8px;
        margin-right: 8px;
        border-radius: 0px 8px 8px 0px;
        border-width: 1.5px 1.5px 1.5px 0px;
        border-style: solid;
        border-color: #${base04};
        background-color: #${base00};
        padding: 8px 16px 6px 10px;
        font-size: 16px;
        color: #${base0E};
      }

      #custom-power {
        margin-top: 8px;
        margin-right: 8px;
        border-radius: 8px;
        border: 1.5px solid #${base04};
        color: #${base08}; 
        padding: 6px 19px 6px 15px;
        background-color: #${base00};
        font-size: 15px;
      }
    '';
    settings.mainBar = {
      layer = "top";
      position = "right";

      modules-left = [ "custom/nix" "hyprland/workspaces" ];

      modules-center = [ "clock" ];

      modules-right =
        [ "tray" "cpu" "memory" "pulseaudio" "network" "custom/power" ];

      "custom/nix" = { format = ""; };

      "hyprland/workspaces" = {
        all-outputs = true;
        format = "{icon}";
        format-icons = {
          "1" = "1";
          "2" = "2";
          "3" = "3";
          "4" = "4";
          "5" = "5";
          "6" = "6";
          "7" = "7";
          "8" = "8";
          "9" = "9";
          "10" = "10";
          "11" = "1";
          "12" = "2";
          "13" = "3";
          "14" = "4";
          "15" = "5";
          "16" = "6";
          "17" = "7";
          "18" = "8";
          "19" = "9";
          "20" = "10";
        };
      };

      "clock" = {
        format =
          "{:  <span color='#${base07}'>%H:%M</span>      <span color='#${config.colorScheme.palette.base07}'>%a, %b %d</span>}";
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          format = {
            today = "<span color='#${base0E}'><b><u>{}</u></b></span>";
          };
          mode = "month";
          on-scroll = 1;
        };
      };

      "cpu" = {
        format = "󰍛  {icon}";
        format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
      };

      "memory" = {
        format = "  {icon}";
        format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
      };

      "pulseaudio" = {
        format = "{icon}";
        format-icons = [ "" "" "󰕾" "" ];
        format-muted = "󰸈";
        tooltip = true;
        tooltip-format = "{volume}%";
      };

      "network" = {
        format = "󰈀";
        format-disconnected = "󰖪";
        format-ethernet = "󰈀";
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        format-wifi = "{icon}";
        on-click = "$HOME/.config/rofi/nm.sh";
        tooltip = true;
        tooltip-format = ''
          {essid}
          {signalStrength} UP:{bandwidthUpBytes} DOWN:{bandwidthDownBytes}'';
      };

      "custom/power" = {
        format = "⏻";
        on-click = "systemctl suspend";
      };

    };
  };
}
