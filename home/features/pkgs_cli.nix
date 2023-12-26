{ config, pkgs, lib, ...}:
{
  home.packages = with pkgs;[
    pulsemixer
    powertop
    btop
	  htop
	  neofetch
    pfetch
  ];
}
