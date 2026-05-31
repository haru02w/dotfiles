{ den, ... }:
{
  den.aspects.base = {
    includes = [
      den.aspects.home-manager-self
      den.aspects.nix-settings
      den.aspects.nix-index
      den.aspects.network
      den.aspects.locale
      den.aspects.security
      den.aspects.sops
    ];

    nixos = _: { };
    homeManager = _: { };
  };
}
