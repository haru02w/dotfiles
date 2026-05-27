{ den, ... }:
{
  den.aspects.kanshi.homeManager.services.kanshi = {
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
            criteria = "*";
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
            criteria = "*";
            mode = "1920x1080@60";
            status = "enable";
          }
        ];
      }
    ];
  };
}
