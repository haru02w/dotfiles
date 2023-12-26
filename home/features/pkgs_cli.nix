{ config, pkgs, lib, ...}:
{
  home.packages = with pkgs;[
    powertop
    btop
	  htop
	  neofetch
    pfetch
  ];
}
