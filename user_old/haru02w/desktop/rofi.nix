{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ bc ];
  home.file.".config/rofi/nm.sh" = let
    script = pkgs.writeShellScriptBin "nm-rofi.sh" ''
          # Starts a scan of available broadcasting SSIDs
          # nmcli dev wifi rescan

          DIR="$( cd "$( dirname "$\{BASH_SOURCE[0]\}" )" && pwd )"

          FIELDS=SSID,SECURITY
          POSITION=0
          YOFF=0
          XOFF=0
          FONT="FiraCode Nerd Font 12"

          if [ -r "$DIR/config" ]; then
              source "$DIR/config"
          elif [ -r "$HOME/.config/rofi/wifi" ]; then
              source "$HOME/.config/rofi/wifi"
          else
              echo "WARNING: config file not found! Using default values."
          fi

          LIST=$(nmcli --fields "$FIELDS" device wifi list | sed '/^--/d')
          # For some reason rofi always approximates character width 2 short... hmmm
          RWIDTH=$(($(echo "$LIST" | head -n 1 | awk '{print length($0); }')+2))
          # Dynamically change the height of the rofi menu
          LINENUM=$(echo "$LIST" | wc -l)
          # Gives a list of known connections so we can parse it later
          KNOWNCON=$(nmcli connection show)
          # Really janky way of telling if there is currently a connection
          CONSTATE=$(nmcli -fields WIFI g)

          CURRSSID=$(LANGUAGE=C nmcli -t -f active,ssid dev wifi | awk -F: '$1 ~ /^yes/ {print $2}')

          if [[ ! -z $CURRSSID ]]; then
              HIGHLINE=$(echo  "$(echo "$LIST" | awk -F "[  ]{2,}" '{print $1}' | grep -Fxn -m 1 "$CURRSSID" | awk -F ":" '{print $1}') + 1" | bc )
          fi

          # HOPEFULLY you won't need this as often as I do
          # If there are more than 8 SSIDs, the menu will still only have 8 lines
          if [ "$LINENUM" -gt 8 ] && [[ "$CONSTATE" =~ "enabled" ]]; then
              LINENUM=8
          elif [[ "$CONSTATE" =~ "disabled" ]]; then
              LINENUM=1
          fi


          if [[ "$CONSTATE" =~ "enabled" ]]; then
              TOGGLE="toggle off"
          elif [[ "$CONSTATE" =~ "disabled" ]]; then
              TOGGLE="toggle on"
          fi



          CHENTRY=$(echo -e "$TOGGLE\nmanual\n$LIST" | uniq -u | rofi -dmenu -p "Wi-Fi SSID: " -lines "$LINENUM" -a "$HIGHLINE" -location "$POSITION" -yoffset "$YOFF" -xoffset "$XOFF" -font "$FONT" -width -"$RWIDTH")
      #echo "$CHENTRY"
          CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $1}')
      #echo "$CHSSID"

      # If the user inputs "manual" as their SSID in the start window, it will bring them to this screen
          if [ "$CHENTRY" = "manual" ] ; then
              # Manual entry of the SSID and password (if appplicable)
              MSSID=$(echo "enter the SSID of the network (SSID,password)" | rofi -dmenu -p "Manual Entry: " -font "$FONT" -lines 1)
              # Separating the password from the entered string
              MPASS=$(echo "$MSSID" | awk -F "," '{print $2}')

              #echo "$MSSID"
              #echo "$MPASS"

              # If the user entered a manual password, then use the password nmcli command
              if [ "$MPASS" = "" ]; then
                  nmcli dev wifi con "$MSSID"
              else
                  nmcli dev wifi con "$MSSID" password "$MPASS"
              fi

          elif [ "$CHENTRY" = "toggle on" ]; then
              nmcli radio wifi on

          elif [ "$CHENTRY" = "toggle off" ]; then
              nmcli radio wifi off

          else

              # If the connection is already in use, then this will still be able to get the SSID
              if [ "$CHSSID" = "*" ]; then
                  CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $3}')
              fi

              # Parses the list of preconfigured connections to see if it already contains the chosen SSID. This speeds up the connection process
              if [[ $(echo "$KNOWNCON" | grep "$CHSSID") = "$CHSSID" ]]; then
                  nmcli con up "$CHSSID"
              else
                  if [[ "$CHENTRY" =~ "WPA2" ]] || [[ "$CHENTRY" =~ "WEP" ]]; then
                      WIFIPASS=$(echo "if connection is stored, hit enter" | rofi -dmenu -p "password: " -lines 1 -font "$FONT" )
                  fi
                  nmcli dev wifi con "$CHSSID" password "$WIFIPASS"
              fi
          fi
    '';
  in {
    executable = true;
    source = "${script}/bin/nm-rofi.sh";
  };

  home.file.".config/rofi/config.rasi".text = ''
    /**
     *
     * Author : Aditya Shakya (adi1090x)
     * Github : @adi1090x
     * 
     * Rofi Theme File
     * Rofi Version: 1.7.3
     **/

    /*****----- Configuration -----*****/
    configuration {
    	modi:                       "drun";
        show-icons:                 true;
        display-drun:               "drun :";
        display-run:                "";
        display-filebrowser:        "";
        display-window:             "";
    	drun-display-format:        "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
    	window-format:              "{w} · {c} · {t}";
    }

    /*****----- Global Properties -----*****/

    /*****----- Onedark -----*****/
    * {
        font: "FiraCode Nerd Font 12";
        background:     #1E2127FF;
        background-alt: #282B31FF;
        foreground:     #FFFFFFFF;
        selected:       #61AFEFFF;
        active:         #98C379FF;
        urgent:         #E06C75FF;
    }

    * {
        border-colour:               var(selected);
        handle-colour:               var(selected);
        background-colour:           var(background);
        foreground-colour:           var(foreground);
        alternate-background:        var(background-alt);
        normal-background:           var(background);
        normal-foreground:           var(foreground);
        urgent-background:           var(urgent);
        urgent-foreground:           var(background);
        active-background:           var(active);
        active-foreground:           var(background);
        selected-normal-background:  var(selected);
        selected-normal-foreground:  var(background);
        selected-urgent-background:  var(active);
        selected-urgent-foreground:  var(background);
        selected-active-background:  var(urgent);
        selected-active-foreground:  var(background);
        alternate-normal-background: var(background);
        alternate-normal-foreground: var(foreground);
        alternate-urgent-background: var(urgent);
        alternate-urgent-foreground: var(background);
        alternate-active-background: var(active);
        alternate-active-foreground: var(background);
    }

    /*****----- Main Window -----*****/
    window {
        /* properties for window widget */
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  true;
        width:                       1366px;
        height:                      768px;
        x-offset:                    0px;
        y-offset:                    0px;

        /* properties for all widgets */
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        cursor:                      "default";
        background-color:            @background-colour;
    }

    /*****----- Main Box -----*****/
    mainbox {
        enabled:                     true;
        spacing:                     20px;
        margin:                      0px;
        padding:                     35%;
        border:                      0px solid;
        border-radius:               0px 0px 0px 0px;
        border-color:                @border-colour;
        background-color:            transparent;
        children:                    [ "inputbar", "listview" ];
    }

    /*****----- Inputbar -----*****/
    inputbar {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            @background-colour;
        text-color:                  @foreground-colour;
        children:                    [ "prompt", "entry" ];
    }

    prompt {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
    }
    textbox-prompt-colon {
        enabled:                     true;
        expand:                      false;
        str:                         "::";
        background-color:            inherit;
        text-color:                  inherit;
    }
    entry {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
        cursor:                      text;
        placeholder:                 "";
        placeholder-color:           inherit;
    }

    /*****----- Listview -----*****/
    listview {
        enabled:                     true;
        columns:                     1;
        lines:                       12;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   false;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;
        
        spacing:                     10px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
        cursor:                      "default";
    }
    scrollbar {
        handle-width:                5px ;
        handle-color:                @handle-colour;
        border-radius:               0px;
        background-color:            @alternate-background;
    }

    /*****----- Elements -----*****/
    element {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     5px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
        cursor:                      pointer;
    }
    element normal.normal {
        background-color:            var(normal-background);
        text-color:                  var(normal-foreground);
    }
    element normal.urgent {
        background-color:            var(urgent-background);
        text-color:                  var(urgent-foreground);
    }
    element normal.active {
        background-color:            var(active-background);
        text-color:                  var(active-foreground);
    }
    element selected.normal {
        background-color:            var(alternate-background);
        text-color:                  var(foreground-colour);
    }
    element selected.urgent {
        background-color:            var(selected-urgent-background);
        text-color:                  var(selected-urgent-foreground);
    }
    element selected.active {
        background-color:            var(selected-active-background);
        text-color:                  var(selected-active-foreground);
    }
    element alternate.normal {
        background-color:            var(alternate-normal-background);
        text-color:                  var(alternate-normal-foreground);
    }
    element alternate.urgent {
        background-color:            var(alternate-urgent-background);
        text-color:                  var(alternate-urgent-foreground);
    }
    element alternate.active {
        background-color:            var(alternate-active-background);
        text-color:                  var(alternate-active-foreground);
    }
    element-icon {
        background-color:            transparent;
        text-color:                  inherit;
        size:                        24px;
        cursor:                      inherit;
    }
    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        highlight:                   inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }

    /*****----- Mode Switcher -----*****/
    mode-switcher{
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
    }
    button {
        padding:                     10px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            @alternate-background;
        text-color:                  inherit;
        cursor:                      pointer;
    }
    button selected {
        background-color:            var(selected-normal-background);
        text-color:                  var(selected-normal-foreground);
    }

    /*****----- Message -----*****/
    message {
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px 0px 0px 0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
    }
    textbox {
        padding:                     100px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            @alternate-background;
        text-color:                  @foreground-colour;
        vertical-align:              0.5;
        horizontal-align:            0.0;
        highlight:                   none;
        placeholder-color:           @foreground-colour;
        blink:                       true;
        markup:                      true;
    }
    error-message {
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            @background-colour;
        text-color:                  @foreground-colour;
    }
  '';
  home.file.".config/rofi/bt.sh".source = let
    script = pkgs.writeShellScriptBin "bt-rofi.sh" ''
          #!/usr/bin/env bash
      # Author: Nick Clyde (clydedroid)
      #
      # A script that generates a rofi menu that uses bluetoothctl to
      # connect to bluetooth devices and display status info.
      #
      # Inspired by networkmanager-dmenu (https://github.com/firecat53/networkmanager-dmenu)
      # Thanks to x70b1 (https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/system-bluetooth-bluetoothctl)
      #
      # Depends on:
      #   Arch repositories: rofi, bluez-utils (contains bluetoothctl)

      # Constants
      divider="---------"
      goback="Back"

      # Checks if bluetooth controller is powered on
      power_on() {
          if bluetoothctl show | grep -q "Powered: yes"; then
              return 0
          else
              return 1
          fi
      }

      # Toggles power state
      toggle_power() {
          if power_on; then
              bluetoothctl power off
              show_menu
          else
              if rfkill list bluetooth | grep -q 'blocked: yes'; then
                  rfkill unblock bluetooth && sleep 3
              fi
              bluetoothctl power on
              show_menu
          fi
      }

      # Checks if controller is scanning for new devices
      scan_on() {
          if bluetoothctl show | grep -q "Discovering: yes"; then
              echo "Scan: on"
              return 0
          else
              echo "Scan: off"
              return 1
          fi
      }

      # Toggles scanning state
      toggle_scan() {
          if scan_on; then
              kill $(pgrep -f "bluetoothctl scan on")
              bluetoothctl scan off
              show_menu
          else
              bluetoothctl scan on &
              echo "Scanning..."
              sleep 5
              show_menu
          fi
      }

      # Checks if controller is able to pair to devices
      pairable_on() {
          if bluetoothctl show | grep -q "Pairable: yes"; then
              echo "Pairable: on"
              return 0
          else
              echo "Pairable: off"
              return 1
          fi
      }

      # Toggles pairable state
      toggle_pairable() {
          if pairable_on; then
              bluetoothctl pairable off
              show_menu
          else
              bluetoothctl pairable on
              show_menu
          fi
      }

      # Checks if controller is discoverable by other devices
      discoverable_on() {
          if bluetoothctl show | grep -q "Discoverable: yes"; then
              echo "Discoverable: on"
              return 0
          else
              echo "Discoverable: off"
              return 1
          fi
      }

      # Toggles discoverable state
      toggle_discoverable() {
          if discoverable_on; then
              bluetoothctl discoverable off
              show_menu
          else
              bluetoothctl discoverable on
              show_menu
          fi
      }

      # Checks if a device is connected
      device_connected() {
          device_info=$(bluetoothctl info "$1")
          if echo "$device_info" | grep -q "Connected: yes"; then
              return 0
          else
              return 1
          fi
      }

      # Toggles device connection
      toggle_connection() {
          if device_connected "$1"; then
              bluetoothctl disconnect "$1"
              device_menu "$device"
          else
              bluetoothctl connect "$1"
              device_menu "$device"
          fi
      }

      # Checks if a device is paired
      device_paired() {
          device_info=$(bluetoothctl info "$1")
          if echo "$device_info" | grep -q "Paired: yes"; then
              echo "Paired: yes"
              return 0
          else
              echo "Paired: no"
              return 1
          fi
      }

      # Toggles device paired state
      toggle_paired() {
          if device_paired "$1"; then
              bluetoothctl remove "$1"
              device_menu "$device"
          else
              bluetoothctl pair "$1"
              device_menu "$device"
          fi
      }

      # Checks if a device is trusted
      device_trusted() {
          device_info=$(bluetoothctl info "$1")
          if echo "$device_info" | grep -q "Trusted: yes"; then
              echo "Trusted: yes"
              return 0
          else
              echo "Trusted: no"
              return 1
          fi
      }

      # Toggles device connection
      toggle_trust() {
          if device_trusted "$1"; then
              bluetoothctl untrust "$1"
              device_menu "$device"
          else
              bluetoothctl trust "$1"
              device_menu "$device"
          fi
      }

      # Prints a short string with the current bluetooth status
      # Useful for status bars like polybar, etc.
      print_status() {
          if power_on; then
              printf ''

              paired_devices_cmd="devices Paired"
              # Check if an outdated version of bluetoothctl is used to preserve backwards compatibility
              if (( $(echo "$(bluetoothctl version | cut -d ' ' -f 2) < 5.65" | bc -l) )); then
                  paired_devices_cmd="paired-devices"
              fi

              mapfile -t paired_devices < <(bluetoothctl $paired_devices_cmd | grep Device | cut -d ' ' -f 2)
              counter=0

              for device in "$\{paired_devices[@]\}"; do
                  if device_connected "$device"; then
                      device_alias=$(bluetoothctl info "$device" | grep "Alias" | cut -d ' ' -f 2-)

                      if [ $counter -gt 0 ]; then
                          printf ", %s" "$device_alias"
                      else
                          printf " %s" "$device_alias"
                      fi

                      ((counter++))
                  fi
              done
              printf "\n"
          else
              echo ""
          fi
      }

      # A submenu for a specific device that allows connecting, pairing, and trusting
      device_menu() {
          device=$1

          # Get device name and mac address
          device_name=$(echo "$device" | cut -d ' ' -f 3-)
          mac=$(echo "$device" | cut -d ' ' -f 2)

          # Build options
          if device_connected "$mac"; then
              connected="Connected: yes"
          else
              connected="Connected: no"
          fi
          paired=$(device_paired "$mac")
          trusted=$(device_trusted "$mac")
          options="$connected\n$paired\n$trusted\n$divider\n$goback\nExit"

          # Open rofi menu, read chosen option
          chosen="$(echo -e "$options" | $rofi_command "$device_name")"

          # Match chosen option to command
          case "$chosen" in
              "" | "$divider")
                  echo "No option chosen."
                  ;;
              "$connected")
                  toggle_connection "$mac"
                  ;;
              "$paired")
                  toggle_paired "$mac"
                  ;;
              "$trusted")
                  toggle_trust "$mac"
                  ;;
              "$goback")
                  show_menu
                  ;;
          esac
      }

      # Opens a rofi menu with current bluetooth status and options to connect
      show_menu() {
          # Get menu options
          if power_on; then
              power="Power: on"

              # Human-readable names of devices, one per line
              # If scan is off, will only list paired devices
              devices=$(bluetoothctl devices | grep Device | cut -d ' ' -f 3-)

              # Get controller flags
              scan=$(scan_on)
              pairable=$(pairable_on)
              discoverable=$(discoverable_on)

              # Options passed to rofi
              options="$devices\n$divider\n$power\n$scan\n$pairable\n$discoverable\nExit"
          else
              power="Power: off"
              options="$power\nExit"
          fi

          # Open rofi menu, read chosen option
          chosen="$(echo -e "$options" | $rofi_command "Bluetooth")"

          # Match chosen option to command
          case "$chosen" in
              "" | "$divider")
                  echo "No option chosen."
                  ;;
              "$power")
                  toggle_power
                  ;;
              "$scan")
                  toggle_scan
                  ;;
              "$discoverable")
                  toggle_discoverable
                  ;;
              "$pairable")
                  toggle_pairable
                  ;;
              *)
                  device=$(bluetoothctl devices | grep "$chosen")
                  # Open a submenu if a device is selected
                  if [[ $device ]]; then device_menu "$device"; fi
                  ;;
          esac
      }

      # Rofi command to pipe into, can add any options here
      rofi_command="rofi -dmenu $* -p"

      case "$1" in
          --status)
              print_status
              ;;
          *)
              show_menu
              ;;
      esac
    '';
  in "${script}/bin/bt-rofi.sh";
}
