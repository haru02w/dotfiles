{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) getExe';
in {
  imports = [./setup];

  modules.programs.sops.enable = true;
  programs.git = {
    enable = true;
    userName = "Haru02w";
    userEmail = "haru02w@protonmail.com";
  };

  modules.presets.desktop-v2 = {
    enable = true;
    sway.extraKeybindings = {
      "XF86Launch4" = "exec '${pkgs.asusctl}/bin/asusctl profile -n; ${pkgs.procps}/bin/pkill -RTMIN+8 waybar'";
      "XF86KbdBrightnessUp" = "exec ${pkgs.asusctl}/bin/asusctl -n";
      "XF86KbdBrightnessDown" = "exec ${pkgs.asusctl}/bin/asusctl -p";
    };
  };
  wayland.windowManager.sway.extraConfig = ''
    bindswitch --locked lid:off exec ${getExe' config.services.kanshi.package "kanshictl"} switch docked
    bindswitch --locked lid:on exec ${getExe' config.services.kanshi.package "kanshictl"} switch docked-lid-closed
  '';
  programs.waybar.settings.mainBar = {
    modules-left = lib.mkBefore ["custom/fanprofiles"];
    "custom/fanprofiles" = {
      interval = "once";
      signal = 8;
      format = "{}";
      exec-on-event = false;
      on-click = "${pkgs.asusctl}/bin/asusctl profile -n; ${pkgs.procps}/bin/pkill -RTMIN+8 waybar";
      exec = let
        script = pkgs.writeShellScriptBin "fanprofiles.sh" ''
          RETURN=$(${pkgs.asusctl}/bin/asusctl profile -p)

          if [[ $RETURN = *"Performance"* ]]
          then
              echo "󱑴"
          elif [[ $RETURN = *"Balanced"* ]]
          then
              echo "󱑳"
          elif [[ $RETURN = *"Quiet"* ]]
          then
              echo "󱑲"
          fi
        '';
      in "${script}/bin/fanprofiles.sh"; # WARN
      escape = true;
    };
  };

  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";

    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 1.5;
            mode = "1920x1080@60";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 1.5;
            mode = "1920x1080@60";
            position = "0,180";
            status = "enable";
          }
          {
            criteria = "HDMI-A-1";
            mode = "1920x1080@60";
            position = "1280,0";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "docked-lid-closed";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "HDMI-A-1";
            mode = "1920x1080@60";
            status = "enable";
          }
        ];
      }
    ];
  };
}
