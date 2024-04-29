{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    style = ''
      window#waybar {
          background-color: #141b1e;
          font-family: "FiraCode Nerd Font";
      }

      #workspaces {
        margin: 10px;
        margin-top: 4px;
        padding: 7px 0px 7px 0px;
        /* padding-top: 4px; */
        /* padding-bottom: 4px; */
        /* padding-left: 4px; */
        border-radius: 50px;
        background-color: #232a2d;
        font-size: 20px;    
      }

      #workspaces button {
        color: #dadada;
         padding: 2px 7px;
      }

      #workspaces button:hover {
        background: #232a2d;
      }

      #workspaces button.active{
        color: #00ffff;
      }

      #custom-power {
          color: #141b1e;
          background-color: #e57474; 
          font-size: 15px;
          border-radius: 10px;
          padding: 10px 0px;
          margin: 0px 10px;
          margin-bottom: 5px;
      }

      #clock {
          color: #dadada;
          font-size: 1.2em;
          margin-bottom: 8px;
      }

      #custom-arch{
          color: #141b1e;
          background-color: #0088cc;
          font-size: 18px;
          border-radius: 10px;
          padding: 10px 0;
          margin: 0 10px;
          margin-bottom: 5px;
          margin-top: 8px;
      }

      #custom-separator {
          color: #dadada; 
      }

      #memory {
          color: #dadada;
          padding: 10px 0px 10px;
          font-size: 17px;
      }
      #cpu{
          color: #dadada;
          padding: 10px 0px 10px;
          font-size: 17px;
      }

      #custom-wofi {
          border-radius: 50px;
          margin: 10px;
          font-size:18px;
          padding: 7px;
          background-color: #232a2d;
          color: #dadada;
      }

      #battery  {
          border-radius: 50px;
          margin: 10px;
          font-size:18px;
          padding: 7px;
          background-color: #232a2d;
          color: #dadada;
      }
      #backlight {
          border-radius: 50px;
          margin: 10px;
          font-size:18px;
          padding: 7px;
          background-color: #232a2d;
          color: #dadada;
      }
      #battery.warning {
      	color: #ffcc00
      }
      #battery.critical{
      	color: #ffcc00
      }

      #pulseaudio{
          border-radius: 50px;
          margin: 10px;
          font-size: 20px;
          padding: 7px;
          background-color: #232a2d;
          color: #dadada;
      }
      #network{
          border-radius: 50px;
          margin: 10px;
          font-size: 18px;
          padding: 7px;
          background-color: #232a2d;
          color: #dadada;
      }
      #bluetooth{
          border-radius: 50px;
          margin: 10px;
          font-size: 18px;
          padding: 7px;
          background-color: #232a2d;
          color: #dadada;
      }
      #custom-fanprofiles{
          border-radius: 50px;
          margin: 10px;
          font-size: 18px;
          padding: 7px;
          background-color: #232a2d;
          color: #dadada;
      }
    '';

    settings.mainBar = {
      layer = "top";
      position = "right";
      width = 64;
      modules-left = [
        "custom/arch"
        "custom/fanprofiles"
        "cpu"
        "memory"
        "custom/separator"
        "tray"
      ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [
        "network"
        "bluetooth"
        "backlight"
        "pulseaudio"
        "battery"
        "custom/separator"
        "clock"
        "custom/power"
      ];
      "hyprland/workspaces" = {
        all-outputs = false;
        format = "{icon}";
        sort-by-number = true;
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
      "custom/power" = {
        format = "⏻";
        on-click = "systemctl suspend";
      };
      "clock" = {
        format = ''
          {:%H
          %M}'';
        tooltip-format = "<tt>{calendar}</tt>";
        calendar = {
          mode = "month";
          on-scroll = 1;
          format = { today = "<span color='#ff6699'><b><u>{}</u></b></span>"; };
        };
      };
      "custom/arch" = {
        format = "";
        on-click = "${pkgs.rofi-wayland}/bin/rofi -show drun";
      };
      "custom/fanprofiles" = {
        interval = "once";
        signal = 8;
        format = "{}";
        exec-on-event = false;
        on-click =
          "${pkgs.asusctl}/bin/asusctl profile -n; ${pkgs.procps}/bin/pkill -RTMIN+8 waybar";
        exec = "~/.config/waybar/fanprofiles.sh"; # WARN
        escape = true;
      };
      "custom/separator" = { format = "──────"; };
      "cpu" = {
        format = "󰍛 {icon}";
        format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
      };
      "memory" = {
        format = " {icon}";
        format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
      };
      "backlight" = {
        format = "{icon}";
        format-icons = [ "󰃚" "󰃛" "󰃜" "󰃞" "󰃝" "󰃟" "󰃠" ];
        tooltip = true;
        tooltip-format = "{percent}%";
      };
      "pulseaudio" = {
        format = "{icon}";
        format-icons = [ "" "" "󰕾" "" ];
        format-muted = "󰸈";
        tooltip = true;
        tooltip-format = "{volume}%";
      };
      "battery" = {
        format = "{icon} ";
        format-Charging = "ﮣ";
        full-at = 80;
        tooltip = true;
        tooltip-format = "{capacity}%";
        states = {
          warning = 30;
          critical = 15;
        };
        format-icons = [ "" "" "" "" "" ];
      };
      "network" = {
        format = "󰈁";
        format-ethernet = "󰈁";
        format-wifi = "{icon}";
        format-disconnected = "󰖪";
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        tooltip = true;
        tooltip-format = ''
          {essid}
          {signalStrength} UP:{bandwidthUpBytes} DOWN:{bandwidthDownBytes}'';
        on-click = "$HOME/.config/rofi/nm.sh";
      };
      "bluetooth" = {
        format = "";
        format-on = "󰂯";
        format-off = "󰂲";
        format-disabled = "󰂲";
        format-connected = "󰂱";
        on-click = "$HOME/.config/rofi/bt.sh";
      };
    };
  };

  home.file.".config/waybar/fanprofiles.sh".source =
    let
      script = pkgs.writeShellScriptBin "fanprofiles.sh" ''
        RETURN=$(${pkgs.asusctl}/bin/asusctl profile -p)

        if [[ $RETURN = *"Performance"* ]]
        then
            echo "󰑮"
        elif [[ $RETURN = *"Balanced"* ]]
        then
            echo "󰜎"
        elif [[ $RETURN = *"Quiet"* ]]
        then
            echo ""
        fi
      '';
    in
    "${script}/bin/fanprofiles.sh";
  # WARN dmenu-bluetooth not installed
  # WARN ~/.config/waybar/fanprofiles.sh not in place
}
