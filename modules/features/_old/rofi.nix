{ den, ... }:
{
  den.aspects.rofi.homeManager =
    { pkgs, ... }:
    {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi;
      };
    };
}
