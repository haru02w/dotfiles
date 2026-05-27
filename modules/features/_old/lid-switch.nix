{ den, ... }:
{
  den.aspects.lid-switch = {
    nixos.services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };

    homeManager =
      {
        config,
        lib,
        ...
      }:
      {
        wayland.windowManager.sway.extraConfig = ''
          bindswitch --locked lid:off exec ${lib.getExe' config.services.kanshi.package "kanshictl"} switch docked
          bindswitch --locked lid:on exec ${lib.getExe' config.services.kanshi.package "kanshictl"} switch docked-lid-closed
        '';
      };
  };
}
