{den, ...}: {
  den.aspects.base = {
    includes = [
      den.aspects.home-manager-self
      den.aspects.nix-settings
      den.aspects.nix-index
      den.aspects.network
    ];

    nixos = _: {};
    homeManager = _: {};
  };
}
