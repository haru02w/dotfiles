{ den, lib, ... }:
{
  den.aspects.joaomillane = {
    includes = [ den.aspects.headless ];

    homeManager = {
      programs.git.settings.user.name = lib.mkForce "joaomillane";
      programs.jujutsu.settings.user.name = lib.mkForce "joaomillane";
    };
  };
}
