{ den, ... }:
{
  den.aspects.mako.homeManager.services.mako = {
    enable = true;
    settings = {
      ignore-timeout = true;
      default-timeout = 5000;
    };
  };
}
