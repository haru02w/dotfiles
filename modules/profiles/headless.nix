{den, ...}: {
  den.aspects.headless = {
    includes = [
      den.aspects.base
      den.aspects.git
      den.aspects.zsh
      den.aspects.direnv
      den.aspects.docker
      den.aspects.openssh
      den.aspects.nix-ld
      den.aspects.stylix
    ];

    nixos = _: {};
    homeManager = _: {};
  };
}
