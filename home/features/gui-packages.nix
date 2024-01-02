{pkgs, ...}:
{
  imports = [ ./firefox.nix ];
  home.packages = with pkgs; [
    vieb
    discord
    webcord
  ];
}
