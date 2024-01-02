{pkgs, ...}:
{
  imports = [ ./firefox.nix ];
  home.packages = with pkgs; [
    firefox
    discord
    webcord
  ];
}
