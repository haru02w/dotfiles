{ config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = config.fontProfiles.monospace.family;

    theme = with config.colorScheme.palette;
      let inherit (config.lib.formats.rasi) mkLiteral;
      in {
        # ****----- Onedark -----****
        "*" = {
          background = mkLiteral "#${base00}";
          background-alt = mkLiteral "#${base01}";
          foreground = mkLiteral "#${base05}";
          selected = mkLiteral "#${base02}";
          active = mkLiteral "#${base0D}";
          urgent = mkLiteral "#${base0F}";

          border-colour = mkLiteral "var(selected)";
          handle-colour = mkLiteral "var(selected)";
          background-colour = mkLiteral "var(background)";
          foreground-colour = mkLiteral "var(foreground)";
          alternate-background = mkLiteral "var(background-alt)";
          normal-background = mkLiteral "var(background)";
          normal-foreground = mkLiteral "var(foreground)";
          urgent-background = mkLiteral "var(urgent)";
          urgent-foreground = mkLiteral "var(background)";
          active-background = mkLiteral "var(active)";
          active-foreground = mkLiteral "var(background)";
          selected-normal-background = mkLiteral "var(selected)";
          selected-normal-foreground = mkLiteral "var(background)";
          selected-urgent-background = mkLiteral "var(active)";
          selected-urgent-foreground = mkLiteral "var(background)";
          selected-active-background = mkLiteral "var(urgent)";
          selected-active-foreground = mkLiteral "var(background)";
          alternate-normal-background = mkLiteral "var(background)";
          alternate-normal-foreground = mkLiteral "var(foreground)";
          alternate-urgent-background = mkLiteral "var(urgent)";
          alternate-urgent-foreground = mkLiteral "var(background)";
          alternate-active-background = mkLiteral "var(active)";
          alternate-active-foreground = mkLiteral "var(background)";
        };
        # ****----- Main Window -----****
        window = {
          # properties for window widget
          transparency = "real";
          location = mkLiteral "center";
          anchor = mkLiteral "center";
          fullscreen = true;
          width = mkLiteral "1366px";
          height = mkLiteral "768px";
          x-offset = mkLiteral "0px";
          y-offset = mkLiteral "0px";

          # properties for all widgets
          enabled = true;
          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px";
          border-color = mkLiteral "@border-colour";
          cursor = "default";
          background-color = mkLiteral "@background-colour";
        };

        # ****----- Main Box -----****
        mainbox = {
          enabled = true;
          spacing = mkLiteral "20px";
          margin = mkLiteral "0px";
          padding = mkLiteral "35%";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px 0px 0px 0px";
          border-color = mkLiteral "@border-colour";
          background-color = mkLiteral "transparent";
          children = [ "inputbar" "listview" ];
        };

        # ****----- Inputbar -----****
        inputbar = {
          enabled = true;
          spacing = mkLiteral "10px";
          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          border = mkLiteral "0px";
          border-radius = mkLiteral "0px";
          border-color = mkLiteral "@border-colour";
          background-color = mkLiteral "@background-colour";
          text-color = mkLiteral "@foreground-colour";
          children = [ "prompt" "entry" ];
        };

        prompt = {
          enabled = true;
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        textbox-prompt-colon = {
          enabled = true;
          expand = false;
          str = "::";
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
        };
        entry = {
          enabled = true;
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "inherit";
          cursor = mkLiteral "text";
          placeholder = "";
          placeholder-color = mkLiteral "inherit";
        };

        # ****----- Listview -----****
        listview = {
          enabled = true;
          columns = 1;
          lines = 12;
          cycle = true;
          dynamic = true;
          scrollbar = false;
          layout = mkLiteral "vertical";
          reverse = false;
          fixed-height = true;
          fixed-columns = true;

          spacing = mkLiteral "10px";
          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px";
          border-color = mkLiteral "@border-colour";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground-colour";
          cursor = "default";
        };
        scrollbar = {
          handle-width = mkLiteral "5px";
          handle-color = mkLiteral "@handle-colour";
          border-radius = mkLiteral "0px";
          background-color = mkLiteral "@alternate-background";
        };

        # ****----- Elements -----****
        element = {
          enabled = true;
          spacing = mkLiteral "10px";
          margin = mkLiteral "0px";
          padding = mkLiteral "5px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px";
          border-color = mkLiteral "@border-colour";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground-colour";
          cursor = mkLiteral "pointer";
        };
        "element normal.normal" = {
          background-color = mkLiteral "var(normal-background)";
          text-color = mkLiteral "var(normal-foreground)";
        };
        "element normal.urgent" = {
          background-color = mkLiteral "var(urgent-background)";
          text-color = mkLiteral "var(urgent-foreground)";
        };
        "element normal.active" = {
          background-color = mkLiteral "var(active-background)";
          text-color = mkLiteral "var(active-foreground)";
        };
        "element selected.normal" = {
          background-color = mkLiteral "var(alternate-background)";
          text-color = mkLiteral "var(foreground-colour)";
        };
        "element selected.urgent" = {
          background-color = mkLiteral "var(selected-urgent-background)";
          text-color = mkLiteral "var(selected-urgent-foreground)";
        };
        "element selected.active" = {
          background-color = mkLiteral "var(selected-active-background)";
          text-color = mkLiteral "var(selected-active-foreground)";
        };
        "element alternate.normal" = {
          background-color = mkLiteral "var(alternate-normal-background)";
          text-color = mkLiteral "var(alternate-normal-foreground)";
        };
        "element alternate.urgent" = {
          background-color = mkLiteral "var(alternate-urgent-background)";
          text-color = mkLiteral "var(alternate-urgent-foreground)";
        };
        "element alternate.active" = {
          background-color = mkLiteral "var(alternate-active-background)";
          text-color = mkLiteral "var(alternate-active-foreground)";
        };
        element-icon = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          size = mkLiteral "24px";
          cursor = mkLiteral "inherit";
        };
        element-text = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
          highlight = mkLiteral "inherit";
          cursor = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = 0;
        };

        # ****----- Mode Switcher -----****
        mode-switcher = {
          enabled = true;
          spacing = mkLiteral "10px";
          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px";
          border-color = mkLiteral "@border-colour";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground-colour";
        };
        button = {
          padding = mkLiteral "10px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px";
          border-color = mkLiteral "@border-colour";
          background-color = mkLiteral "@alternate-background";
          text-color = mkLiteral "inherit";
          cursor = mkLiteral "pointer";
        };
        "button selected" = {
          background-color = mkLiteral "var(selected-normal-background)";
          text-color = mkLiteral "var(selected-normal-foreground)";
        };

        # ****----- Message -----****
        message = {
          enabled = true;
          margin = mkLiteral "0px";
          padding = mkLiteral "0px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px 0px 0px 0px";
          border-color = mkLiteral "@border-colour";
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "@foreground-colour";
        };
        textbox = {
          padding = mkLiteral "100px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px";
          border-color = mkLiteral "@border-colour";
          background-color = mkLiteral "@alternate-background";
          text-color = mkLiteral "@foreground-colour";
          vertical-align = mkLiteral "0.5";
          horizontal-align = 0;
          highlight = mkLiteral "none";
          placeholder-color = mkLiteral "@foreground-colour";
          blink = true;
          markup = true;
        };
        error-message = {
          padding = mkLiteral "0px";
          border = mkLiteral "0px solid";
          border-radius = mkLiteral "0px";
          border-color = mkLiteral "@border-colour";
          background-color = mkLiteral "@background-colour";
          text-color = mkLiteral "@foreground-colour";
        };
      };
  };
  home.packages = with pkgs; [ rofi-bluetooth networkmanager_dmenu ];
  xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = rofi -dmenu -i
    active_chars = 󱘖
    # highlight = <True or False> # (Default: False) use highlighting instead of active_chars (only applicable to Rofi / Wofi)
    # highlight_fg = <Color> # (Default: None) foreground color of active connection (only applicable to Wofi)
    # highlight_bg = <Color> # (Default: None) background color of active connection (only applicable to Wofi)
    # highlight_bold = <True or False> # (Default: True) make active connection bold (only applicable to Wofi)
    # compact = <True or False> # (Default: False). Remove extra spacing from display
    compact = True
    # pinentry = <Pinentry command>  # (Default: None) e.g. `pinentry-gtk`
    # wifi_chars = <string of 4 unicode characters representing 1-4 bars strength>
    wifi_chars = ▂▄▆█
    # wifi_icons = <characters representing signal strength as an icon>
    wifi_icons = 󰤯󰤟󰤢󰤥󰤨
    # format = <Python style format string for the access point entries>
    # format = {name}  {sec}  {bars}
    # # Available variables are:
    # #  * {name} - Access point name
    # #  * {sec} - Security type
    # #  * {signal} - Signal strength on a scale of 0-100
    # #  * {bars} - Bar-based display of signal strength (see wifi_chars)
    # #  * {icon} - Icon-based display of signal strength (see wifi_icons)
    # #  * {max_len_name} and {max_len_sec} are the maximum lengths of {name} / {sec}
    # #    respectively and may be useful for formatting.
    # (Default: False) list saved connections
    list_saved = True 

    [dmenu_passphrase]
    # # Uses the -password flag for Rofi, -x for bemenu. For dmenu, sets -nb and
    # # -nf to the same color or uses -P if the dmenu password patch is applied
    # # https://tools.suckless.org/dmenu/patches/password/
    obscure = True
    # obscure_color = #222222

    [pinentry]
    # description = <Pinentry description> (Default: Get network password)
    # prompt = <Pinentry prompt> (Default: Password:)

    [editor]
    # terminal = footclient
    # gui_if_available = False

    [nmdm]
    # (seconds to wait after a wifi rescan before redisplaying the results)
    rescan_delay = 10
  '';
}
