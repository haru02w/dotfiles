{ pkgs, ... }: {
  home.packages = [ pkgs.playerctl ];
  services.playerctld.enable = true;
  services.mpris-proxy.enable = true;
}
