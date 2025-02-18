{
  pkgs,
  lib,
  ...
}: {
  # Enable Docker with docker-compose
  virtualisation.docker = {
    enable = true;
    extraPackages = [pkgs.docker-compose];
  };
}
