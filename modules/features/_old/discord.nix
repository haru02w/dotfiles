{ den, ... }:
{
  den.aspects.discord.homeManager =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        discord
        vesktop
      ];
    };
}
