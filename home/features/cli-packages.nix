{ pkgs, ...}:
{
  home.packages = with pkgs;[
    libqalculate # calculator
    ncdu # tui disk usage analizer
    pulsemixer # tui pulse mixer 
    powertop # power status
    btop # general system status
    htop # general system status
    neofetch # system info
    pfetch #system info
    tldr # simpler man
  ];
}
