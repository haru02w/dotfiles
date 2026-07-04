{ inputs, ... }:
{
  flake-file = {
    inputs.noctalia-shell.url = "github:noctalia-dev/noctalia-shell";
    nixConfig = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };
  };

  den.aspects.noctalia.homeManager =
    { pkgs, ... }:
    {
      imports = [ inputs.noctalia-shell.homeModules.default ];

      programs.noctalia = {
        enable = true;
        settings.widget.date.format = "{:%d\n%b}"; # stack day/month; horizontal "04 Jul" widened the vertical bar
        settings.widget.network.show_label = false; # icon only, no SSID text
        settings.bar.main = {
          position = "right";
          margin_ends = 0; # default 180 pads both ends inward, clumping widgets to center
          # Widget ordering — reorder freely. Valid ids: active_window,
          # audio_visualizer, battery, bluetooth, brightness, caffeine,
          # clipboard, clock, control-center, custom_button, keyboard_layout,
          # launcher, lock_keys, media, network, nightlight, notifications,
          # power_profile, screenshot, session, settings, spacer, sysmon,
          # taskbar, tray, volume, wallpaper, weather, workspaces.
          start = [
            "control-center"
            "session"
            "launcher"
            "power_profile"
            "media"
            "notifications"
            "tray"
          ];
          center = [
            "workspaces"
          ];
          end = [
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "battery"
            "clock"
            "date"
          ];
        };
      };

      home.packages = with pkgs; [
        brightnessctl
        imagemagick
        python3
        cliphist
        wl-clipboard
        wlsunset
        grim
        slurp
      ];
    };
}
