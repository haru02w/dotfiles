{ den, ... }:
{
  den.aspects.xdg-portal.nixos.xdg.portal = {
    enable = true;
    config.common.default = "wlr";
    wlr.enable = true;
  };
}
