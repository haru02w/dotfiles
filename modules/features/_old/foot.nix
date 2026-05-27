{ den, ... }:
{
  den.aspects.foot.homeManager =
    { lib, ... }:
    {
      programs.foot = {
        enable = true;
        server.enable = true;
        settings.main.dpi-aware = lib.mkForce "no";
      };
    };
}
