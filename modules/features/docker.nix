{
  den.aspects.docker.nixos = {pkgs, ...}: {
    virtualisation.docker = {
      enable = true;
      extraPackages = [pkgs.docker-compose];
    };
  };
}
