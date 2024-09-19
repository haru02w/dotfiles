{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.presets.desktop-v1.rofi;
in {
  options.modules.presets.desktop-v1.rofi.enable =
    mkEnableOption "desktop-v1 rofi";

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
    home.packages = with pkgs; [rofi-bluetooth networkmanager_dmenu];
    xdg.configFile."networkmanager-dmenu/config.ini".text = ''
      [dmenu]
      dmenu_command = rofi -dmenu -i
      active_chars = '󱘖'
      # highlight = <True or False> # (Default: False) use highlighting instead of active_chars (only applicable to Rofi / Wofi)
      # highlight_fg = <Color> # (Default: None) foreground color of active connection (only applicable to Wofi)
      # highlight_bg = <Color> # (Default: None) background color of active connection (only applicable to Wofi)
      # highlight_bold = <True or False> # (Default: True) make active connection bold (only applicable to Wofi)
      # compact = <True or False> # (Default: False). Remove extra spacing from display
      compact = True
      # pinentry = <Pinentry command>  # (Default: None) e.g. `pinentry-gtk`
      # wifi_chars = <string of 4 unicode characters representing 1-4 bars strength>
      # wifi_chars = ▂▄▆█
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
  };
}
