{pkgs, ...}:
{
  imports = [
    ./git.nix
  ];
  home.packages = with pkgs; [
    libqalculate # calculator
    ncdu # tui disk usage analizer
  ];
}
