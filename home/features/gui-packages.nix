{pkgs, ...}:
{
  imports = [ ./firefox.nix ];
  home.packages = [
    pkgs.unstable.vieb
    pkgs.discord
    pkgs.webcord
  ];
}
